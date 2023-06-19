//
//

#ifndef SCRFD_H
#define SCRFD_H

#include <stdio.h>
#include "ncnn/ncnn/net.h"
#include "FaceInfo.h"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIImage.h>
#import <functional>

#include <vector>


class Scrfd {
public:
    Scrfd(bool useGPU);
    ~Scrfd();
    std::vector<FaceInfo> detect_scrfd(UIImage *image, float prob_threshold = 0.5f, float nms_threshold = 0.45f);
private:
    ncnn::Net *ScrfdNet;
    ncnn::Net *PfldNet;
    bool has_kps;
public:
    bool initFailed;
    static Scrfd *detector;
    static bool hasGPU;
    static bool toUseGPU;
};


#endif // SCRFD_H
