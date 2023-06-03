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
@property (nonatomic,assign) BOOL isHave;//有无界头
@property (nonatomic,assign) BOOL isColor;//是否显示红色
@end

NS_ASSUME_NONNULL_END
