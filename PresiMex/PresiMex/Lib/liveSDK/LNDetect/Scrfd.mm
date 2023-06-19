//
//

#include "Scrfd.h"
#include <opencv2/imgcodecs/ios.h>

bool Scrfd::hasGPU = true;
bool Scrfd::toUseGPU = true;
Scrfd *Scrfd::detector = nullptr;

static inline float intersection_area(const FaceInfo & a, const FaceInfo& b)
{
    float inner_x0 = a.x1 > b.x1 ? a.x1 : b.x1;
    float inner_y0 = a.y1 > b.y1 ? a.y1 : b.y1;

    float inner_x1 = a.x2 < b.x2 ? a.x2 : b.x2;
    float inner_y1 = a.y2 < b.y2 ? a.y2 : b.y2;

    float inner_h = inner_y1 - inner_y0 + 1;
    float inner_w = inner_x1 - inner_x0 + 1;

    if (inner_h <= 0 || inner_w <= 0)
        return 0;

    float inner_area = inner_h * inner_w;
    return inner_area;
}

static void qsort_descent_inplace(std::vector<FaceInfo>& faceobjects, int left, int right)
{
    int i = left;
    int j = right;
    float p = faceobjects[(left + right) / 2].prob;

    while (i <= j)
    {
        while (faceobjects[i].prob > p)
            i++;

        while (faceobjects[j].prob < p)
            j--;

        if (i <= j)
        {
            // swap
            std::swap(faceobjects[i], faceobjects[j]);

            i++;
            j--;
        }
    }

//     #pragma omp parallel sections
    {
//         #pragma omp section
        {
            if (left < j) qsort_descent_inplace(faceobjects, left, j);
        }
//         #pragma omp section
        {
            if (i < right) qsort_descent_inplace(faceobjects, i, right);
        }
    }
}

static void qsort_descent_inplace(std::vector<FaceInfo>& faceobjects)
{
    if (faceobjects.empty())
        return;

    qsort_descent_inplace(faceobjects, 0, faceobjects.size() - 1);
}

static void nms_sorted_bboxes(const std::vector<FaceInfo>& faceobjects, std::vector<int>& picked, float nms_threshold)
{
    picked.clear();

    const int n = faceobjects.size();

    std::vector<float> areas(n);
    for (int i = 0; i < n; i++)
    {
        areas[i] = (faceobjects[i].x2 - faceobjects[i].x1) * (faceobjects[i].y2 - faceobjects[i].y1);
    }

    for (int i = 0; i < n; i++)
    {
        const FaceInfo & a = faceobjects[i];

        int keep = 1;
        for (int j = 0; j < (int)picked.size(); j++)
        {
            const FaceInfo & b = faceobjects[picked[j]];

            // intersection over union
            float inter_area = intersection_area(a, b);
            float union_area = areas[i] + areas[picked[j]] - inter_area;
            //             float IoU = inter_area / union_area
            if (inter_area / union_area > nms_threshold)
                keep = 0;
        }

        if (keep)
            picked.push_back(i);
    }
}

// insightface/detection/scrfd/mmdet/core/anchor/anchor_generator.py gen_single_level_base_anchors()
static ncnn::Mat generate_anchors(int base_size, const ncnn::Mat& ratios, const ncnn::Mat& scales)
{
    int num_ratio = ratios.w;
    int num_scale = scales.w;

    ncnn::Mat anchors;
    anchors.create(4, num_ratio * num_scale);

    const float cx = 0;
    const float cy = 0;

    for (int i = 0; i < num_ratio; i++)
    {
        float ar = ratios[i];

        int r_w = round(base_size / sqrt(ar));
        int r_h = round(r_w * ar); //round(base_size * sqrt(ar));

        for (int j = 0; j < num_scale; j++)
        {
            float scale = scales[j];

            float rs_w = r_w * scale;
            float rs_h = r_h * scale;

            float* anchor = anchors.row(i * num_scale + j);

            anchor[0] = cx - rs_w * 0.5f;
            anchor[1] = cy - rs_h * 0.5f;
            anchor[2] = cx + rs_w * 0.5f;
            anchor[3] = cy + rs_h * 0.5f;
        }
    }

    return anchors;
}

static void generate_proposals(const ncnn::Mat& anchors, int feat_stride, const ncnn::Mat& score_blob, const ncnn::Mat& bbox_blob, const ncnn::Mat& kps_blob, float prob_threshold, std::vector<FaceInfo>& faceobjects)
{
    int w = score_blob.w;
    int h = score_blob.h;

    // generate face proposal from bbox deltas and shifted anchors
    const int num_anchors = anchors.h;

//    LOGD("11-411");
    for (int q = 0; q < num_anchors; q++)
    {
        const float* anchor = anchors.row(q);

        const ncnn::Mat score = score_blob.channel(q);
        const ncnn::Mat bbox = bbox_blob.channel_range(q * 4, 4);

        // shifted anchor
        float anchor_y = anchor[1];

        float anchor_w = anchor[2] - anchor[0];
        float anchor_h = anchor[3] - anchor[1];
//        LOGD("11-412");

        for (int i = 0; i < h; i++)
        {
            float anchor_x = anchor[0];

            for (int j = 0; j < w; j++)
            {
                int index = i * w + j;

                float prob = score[index];
//                LOGD("11-413");

                if (prob >= prob_threshold)
                {
                    // insightface/detection/scrfd/mmdet/models/dense_heads/scrfd_head.py _get_bboxes_single()
                    float dx = bbox.channel(0)[index] * feat_stride;
                    float dy = bbox.channel(1)[index] * feat_stride;
                    float dw = bbox.channel(2)[index] * feat_stride;
                    float dh = bbox.channel(3)[index] * feat_stride;
//                    LOGD("11-414");

                    // insightface/detection/scrfd/mmdet/core/bbox/transforms.py distance2bbox()
                    float cx = anchor_x + anchor_w * 0.5f;
                    float cy = anchor_y + anchor_h * 0.5f;

                    float x0 = cx - dx;
                    float y0 = cy - dy;
                    float x1 = cx + dw;
                    float y1 = cy + dh;
//                    LOGD("11-415");

                    FaceInfo obj;
                    obj.x1 = x0;
                    obj.y1 = y0;
                    obj.x2 = x1;
                    obj.y2 = y1;
                    obj.prob = prob;

                    faceobjects.push_back(obj);
                }

                anchor_x += feat_stride;
            }

            anchor_y += feat_stride;
        }
    }
}

Scrfd::Scrfd(bool useGPU) {
#if NCNN_VULKAN
    ncnn::create_gpu_instance();
    hasGPU = ncnn::get_gpu_count() > 0;
#endif
    toUseGPU = hasGPU && useGPU;
    has_kps = false;
    initFailed = false;
    ScrfdNet = new ncnn::Net();
    ScrfdNet->opt.use_vulkan_compute = toUseGPU;
    ScrfdNet->opt.use_fp16_arithmetic = true;
    NSString *paramPath = [[NSBundle mainBundle] pathForResource:@"detect1" ofType:@"param"];
    NSString *binPath = [[NSBundle mainBundle] pathForResource:@"detect1" ofType:@"bin"];
    int rp = ScrfdNet->load_param([paramPath UTF8String]);
    int rm = ScrfdNet->load_model([binPath UTF8String]);
    if (rp == 0 && rm == 0) {
        printf("ScrfdNet load param and model success!");
    } else {
        fprintf(stderr, "ScrfdNet load fail, param: %d model: %d", rp, rm);
        initFailed = true;
    }
    
    PfldNet = new ncnn::Net();
    PfldNet->opt.use_vulkan_compute = toUseGPU;
    PfldNet->opt.use_fp16_arithmetic = true;
    NSString *paramPath2 = [[NSBundle mainBundle] pathForResource:@"detect2" ofType:@"param"];
    NSString *binPath2 = [[NSBundle mainBundle] pathForResource:@"detect2" ofType:@"bin"];
    int rp2 = PfldNet->load_param([paramPath2 UTF8String]);
    int rm2 = PfldNet->load_model([binPath2 UTF8String]);
    if (rp2 == 0 && rm2 == 0) {
        printf("PfldNet load param and model success!");
    } else {
        fprintf(stderr, "PfldNet load fail, param: %d model: %d", rp, rm);
        initFailed = true;
    }
};

Scrfd::~Scrfd() {
    ScrfdNet->clear();
    PfldNet->clear();
    delete ScrfdNet;
    delete PfldNet;
#if NCNN_VULKAN
    ncnn::destroy_gpu_instance();
#endif
}

std::vector<FaceInfo> Scrfd::detect_scrfd(UIImage *image, float prob_threshold, float nms_threshold) {

    int img_w = image.size.width;
    int img_h = image.size.height;
    
    const int target_size = 640;
    int w = img_w;
    int h = img_h;
    float scale = 1.f;
    if (w > h)
    {
        scale = (float)target_size / w;
        w = target_size;
        h = h * scale;
    }
    else
    {
        scale = (float)target_size / h;
        h = target_size;
        w = w * scale;
    }
    
    unsigned char* rgba = new unsigned char[img_w * img_h * 4];
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGContextRef contextRef = CGBitmapContextCreate(rgba, img_w, img_h, 8, img_w * 4, colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, img_w, img_h), image.CGImage);
    CGContextRelease(contextRef);


//    cv::Mat tempImg;
//    UIImageToMat(image, tempImg);
//    UIImage *imageTemp = MatToUIImage(tempImg);
    
//    ncnn::Mat img = ncnn::Mat::from_pixels_resize(tempImg.data, ncnn::Mat::PIXEL_BGR2RGB, img_w, img_h, w, h);
    ncnn::Mat img = ncnn::Mat::from_pixels_resize(rgba, ncnn::Mat::PIXEL_RGBA2RGB, img_w, img_h, img_w, img_h);

    ncnn::Mat in_img;
    ncnn::resize_bilinear(img, in_img, w, h);
    int wpad = (w + 31) / 32 * 32 - w;
    int hpad = (h + 31) / 32 * 32 - h;
    ncnn::Mat in_pad;
    ncnn::copy_make_border(in_img, in_pad, hpad / 2, hpad - hpad / 2, wpad / 2, wpad - wpad / 2, ncnn::BORDER_CONSTANT, 0.f);
    const float mean_vals[3] = {127.5f, 127.5f, 127.5f};
    const float norm_vals[3] = {1/128.f, 1/128.f, 1/128.f};
    in_pad.substract_mean_normalize(mean_vals, norm_vals);
    
    ncnn::Extractor ex = ScrfdNet->create_extractor();
    ex.input("input.1", in_pad);
    
    std::vector<FaceInfo> faceproposals;



    // stride 8
    {
        ncnn::Mat score_blob, bbox_blob, kps_blob;
        ex.extract("score_8", score_blob);
        ex.extract("bbox_8", bbox_blob);
        if (has_kps)
            ex.extract("kps_8", kps_blob);

        const int base_size = 16;
        const int feat_stride = 8;
        ncnn::Mat ratios(1);
        ratios[0] = 1.f;
        ncnn::Mat scales(2);
        scales[0] = 1.f;
        scales[1] = 2.f;
        ncnn::Mat anchors = generate_anchors(base_size, ratios, scales);

//        LOGD("11-41");
        std::vector<FaceInfo> faceobjects32;
        generate_proposals(anchors, feat_stride, score_blob, bbox_blob, kps_blob, prob_threshold, faceobjects32);

//        LOGD("11-42");
        faceproposals.insert(faceproposals.end(), faceobjects32.begin(), faceobjects32.end());
    }

    //    LOGD("11-5");
    // stride 16
    {
        ncnn::Mat score_blob, bbox_blob, kps_blob;
        ex.extract("score_16", score_blob);
        ex.extract("bbox_16", bbox_blob);
        if (has_kps)
            ex.extract("kps_16", kps_blob);

        const int base_size = 64;
        const int feat_stride = 16;
        ncnn::Mat ratios(1);
        ratios[0] = 1.f;
        ncnn::Mat scales(2);
        scales[0] = 1.f;
        scales[1] = 2.f;
        ncnn::Mat anchors = generate_anchors(base_size, ratios, scales);

        std::vector<FaceInfo> faceobjects16;
        generate_proposals(anchors, feat_stride, score_blob, bbox_blob, kps_blob, prob_threshold, faceobjects16);

        faceproposals.insert(faceproposals.end(), faceobjects16.begin(), faceobjects16.end());
    }

//        LOGD("11-6");
    // stride 32
    {
        ncnn::Mat score_blob, bbox_blob, kps_blob;
        ex.extract("score_32", score_blob);
        ex.extract("bbox_32", bbox_blob);
        if (has_kps)
            ex.extract("kps_32", kps_blob);

        const int base_size = 256;
        const int feat_stride = 32;
        ncnn::Mat ratios(1);
        ratios[0] = 1.f;
        ncnn::Mat scales(2);
        scales[0] = 1.f;
        scales[1] = 2.f;
        ncnn::Mat anchors = generate_anchors(base_size, ratios, scales);

        std::vector<FaceInfo> faceobjects8;
        generate_proposals(anchors, feat_stride, score_blob, bbox_blob, kps_blob, prob_threshold, faceobjects8);

        faceproposals.insert(faceproposals.end(), faceobjects8.begin(), faceobjects8.end());
    }
        
    // sort all proposals by score from highest to lowest
    qsort_descent_inplace(faceproposals);

    // apply nms with nms_threshold
    std::vector<int> picked;
    nms_sorted_bboxes(faceproposals, picked, nms_threshold);

    int face_count = picked.size();

    std::vector<FaceInfo> faceobjects;
    faceobjects.resize(face_count);

    for (int i = 0; i < face_count; i++)
    {
        faceobjects[i] = faceproposals[picked[i]];

        // adjust offset to original unpadded
        float x0 = (faceobjects[i].x1 - (wpad / 2)) / scale;
        float y0 = (faceobjects[i].y1 - (hpad / 2)) / scale;
        float x1 = (faceobjects[i].x2 - (wpad / 2)) / scale;
        float y1 = (faceobjects[i].y2 - (hpad / 2)) / scale;

        x0 = std::max(std::min(x0, (float)img_w - 1), 0.f);
        y0 = std::max(std::min(y0, (float)img_h - 1), 0.f);
        x1 = std::max(std::min(x1, (float)img_w - 1), 0.f);
        y1 = std::max(std::min(y1, (float)img_h - 1), 0.f);

        faceobjects[i].x1 = x0;
        faceobjects[i].y1 = y0;
        faceobjects[i].x2 = x1;
        faceobjects[i].y2 = y1;
    }
    
    if (faceobjects.size() >= 1) {
        ncnn::Mat img = ncnn::Mat::from_pixels(rgba, ncnn::Mat::PIXEL_RGBA2RGB, img_w, img_h);
        FaceInfo faceObject = faceobjects[0];
        const int ld_w = 112;
        const int ld_h = 112;
        const float norm_vals[3] = {1.0 / 255, 1.0 / 255, 1.0 / 255};
        int out_size = 4;
        int point = 106;
        int landmark_size = point * 2;
        float *faceInfo = new float[out_size];
        float *out_points = new float[landmark_size];
        faceInfo[0] = faceObject.x1;
        faceInfo[1] = faceObject.y1;
        faceInfo[2] = faceObject.x2;
        faceInfo[3] = std::min(faceobjects[0].y2 * 1.05f, (float) img_h);
        int nw = static_cast<int>(faceInfo[2] - faceInfo[0]);
        int nh = static_cast<int>(faceInfo[3] - faceInfo[1]);
        if (nw >= nh) {
            faceInfo[1] = std::max(faceInfo[1] - (float) (nw - nh) / 2.0f, 0.0f);
            faceInfo[3] = std::min(faceInfo[3] + (float) (nw - nh) / 2.0f, (float) img_h);
        } else {
            faceInfo[0] = std::max(faceInfo[0] - (float) (nh - nw) / 2.0f, 0.0f);
            faceInfo[2] = std::min(faceInfo[2] + (float) (nh - nw) / 2.0f, (float) img_w);
        }
        int top = static_cast<int>(faceInfo[1]);
        int bottom = static_cast<int>(faceInfo[3]);
        int left = static_cast<int>(faceInfo[0]);
        int right = static_cast<int>(faceInfo[2]);
        ncnn::Mat crop_img(right - left, bottom - top);
        ncnn::copy_cut_border(img, crop_img, top, img.h - bottom,
                              left, img.w - right);
        ncnn::Mat crop_img1;
        ncnn::resize_bilinear(crop_img, crop_img1, ld_w, ld_h);
        crop_img1.substract_mean_normalize(0, norm_vals);
        ncnn::Extractor ex = PfldNet->create_extractor();
        ex.set_num_threads(1);
        ex.input("input", crop_img1);
        ncnn::Mat out;
        ex.extract("output", out);
        for (int j = 0; j < out.w; j++) {
            if (j % 2 == 0) {
                out_points[j] = out[j] * (float) crop_img.w + (float) left;
            } else {
                out_points[j] = out[j] * (float) crop_img.h + (float) top;
            }
        }
        faceObject.landmarks = out_points;
        faceobjects[0] = faceObject;
    }
    delete[] rgba;
    return faceobjects;
}
