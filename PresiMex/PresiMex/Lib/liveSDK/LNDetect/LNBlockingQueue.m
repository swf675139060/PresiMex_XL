//
//  LNBlockingQueue.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/7.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "LNBlockingQueue.h"

enum {
    kNoElementQueued = 0,
    kElementQueued = 1
};

@interface LNBlockingQueue ()
@property (nonatomic, strong) NSMutableArray *queue;
@property (nonatomic, strong) NSConditionLock *queueLock;
@end

@implementation LNBlockingQueue

- (id)init {
    if ((self = [super init])) {
        _queueLock = [[NSConditionLock alloc] initWithCondition:kNoElementQueued];
        _queue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (nullable id)dequeueElementWaitingUntilDate:(NSDate *)timeoutDate {
    id element = nil;
    if ([_queueLock lockWhenCondition:kElementQueued beforeDate:timeoutDate]) {
        element = [_queue objectAtIndex:0];
        [_queue removeObjectAtIndex:0];
        [_queueLock unlockWithCondition:([_queue count] ? kElementQueued : kNoElementQueued)];
    }
    return element;

}

- (void)enqueue:(id)element {
    [_queueLock lock];
    [_queue addObject:element];
    [_queueLock unlockWithCondition:kElementQueued];
}

- (void)clean {
    [_queue removeAllObjects];
    [_queueLock unlockWithCondition:([_queue count] ? kElementQueued : kNoElementQueued)];
}

@end
