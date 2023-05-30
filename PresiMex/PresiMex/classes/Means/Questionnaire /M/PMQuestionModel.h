//
//  PMQuestionModel.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMQuestionModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic, copy) NSString *placeHold;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ID;


@end

NS_ASSUME_NONNULL_END
