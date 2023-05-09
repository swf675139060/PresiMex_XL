//
//  UILabel+SLFLineSpace.m
//  JKCategories
//
//  Created by wyzeww on 2022/12/19.
//

#import "UILabel+SLFLineSpace.h"
#import <objc/runtime.h>

@implementation UILabel (SLFLineSpace)

static char *slf_labelLineSpaceKey;

+ (void)load {
    //交换设置文本的方法实现。
    Method oldMethod = class_getInstanceMethod([self class], @selector(setText:));
    Method newMethod = class_getInstanceMethod([self class], @selector(slf_setHasLineSpaceText:));
    method_exchangeImplementations(oldMethod, newMethod);
}

//设置带有行间距的文本。
- (void)slf_setHasLineSpaceText:(NSString *)text {
   
    if (!text.length || self.slf_lineSpace==0) {
        [self slf_setHasLineSpaceText:text];
        return;
    }
   
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = self.slf_lineSpace;
    style.lineBreakMode = self.lineBreakMode;
   
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    self.attributedText = attrString;
}

- (void)setSlf_lineSpace:(CGFloat)slf_lineSpace{
   
    objc_setAssociatedObject(self, &slf_labelLineSpaceKey, @(slf_lineSpace), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)slf_lineSpace {
    return [objc_getAssociatedObject(self, &slf_labelLineSpaceKey) floatValue];
}

@end
