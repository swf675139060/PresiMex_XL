//
//  PMIDAuthModel.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMIDAuthModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desTitle;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic, copy) NSString *cardNumbber;

@end

NS_ASSUME_NONNULL_END