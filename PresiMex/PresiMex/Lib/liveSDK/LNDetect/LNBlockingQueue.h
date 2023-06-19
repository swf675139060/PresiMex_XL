//
//  LNBlockingQueue.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/7.
//  Copyright © 2022 TENG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNBlockingQueue: NSObject
- (nullable id)dequeueElementWaitingUntilDate:(NSDate *)timeoutDate;
- (void)enqueue:(id)element;
- (void)clean;

@end

NS_ASSUME_NONNULL_END
