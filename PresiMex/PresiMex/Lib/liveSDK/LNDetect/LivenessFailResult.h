//
//  LivenessFailResult.h
//  livenessSdk
//
//  Created by chenjiajian on 2023/3/1.
//  Copyright © 2023 TENG. All rights reserved.
//

#import "DetectorTypes.h"

#ifndef LivenessFailResult_h
#define LivenessFailResult_h

typedef struct LivenessFailResult{
    NSString *livenessId;
    NSInteger errorCode;
    NSString *errorMsg;
} LivenessFailResult;

#endif /* LivenessFailResult_h */
