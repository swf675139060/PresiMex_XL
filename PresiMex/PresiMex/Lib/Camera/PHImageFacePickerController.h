//
//  PHImageFacePickerController.h
//  PHPocket
//
//  Created by 王二麻子 on 2022/2/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PHImageFacePickerController;
@protocol PHImageFacePickerControllerDelegate <NSObject>

-(void)customImageFacePickerController:(PHImageFacePickerController *)picker didFinishPickingImage:(UIImage *)image;

@end
@interface PHImageFacePickerController :UIViewController
@property (weak ,nonatomic) id <PHImageFacePickerControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
