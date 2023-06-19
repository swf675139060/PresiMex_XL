//
//  PHImagePickerController.h
//  PHPocket
//
//  Created by 王二麻子 on 2021/12/3.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class PHImagePickerController;

@protocol PHImagePickerControllerDelegate <NSObject>


- (void)customImagePickerController:(PHImagePickerController *)picker didFinishPickingImage:(UIImage *)image;


@end


@interface PHImagePickerController :UIViewController

@property (assign ,nonatomic) NSInteger type;//0 正面 1背面

@property (weak ,nonatomic) id <PHImagePickerControllerDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
