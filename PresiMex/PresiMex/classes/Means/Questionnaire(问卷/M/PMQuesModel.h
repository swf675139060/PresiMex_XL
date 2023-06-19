//
//  PMQuesModel.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMQuesModel : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic, copy) NSString *placeHold;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSArray *datas;


@end

@interface PMQuesItemModel : NSObject

//下拉列表的KEY
@property (nonatomic, copy) NSString *broken;
//下拉列表的Value
@property (nonatomic, copy) NSString *bulgaria;
@property (nonatomic, copy) NSString *choose;



@end
NS_ASSUME_NONNULL_END
