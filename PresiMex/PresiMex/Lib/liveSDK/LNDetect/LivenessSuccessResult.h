//
//  LivenessResult.h
//  livenessSdk
//
//  Created by chenjiajian on 2023/2/28.
//  Copyright © 2023 TENG. All rights reserved.
//

#ifndef LivenessSuccessResult_h
#define LivenessSuccessResult_h

typedef struct LivenessSuccessResult{
    NSString *livenessId;
    UIImage *livenessBitmap;
    NSString *livenessBitmapBase64Str;
} LivenessSuccessResult;

#endif /* LivenessSuccessResult_h */
