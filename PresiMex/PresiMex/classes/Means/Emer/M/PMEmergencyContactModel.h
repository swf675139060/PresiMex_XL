//
//  PMEmergencyContactModel.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMEmergencyContactModel : NSObject

@property (nonatomic, copy) NSString *relation;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
