//
//  CommentsPopView.m
//  Douyin
//
//  Created by Tang TianCheng
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "SLFCommentsPopView.h"
#import <Masonry/Masonry.h>

@interface SLFCommentsPopView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView                           *container;
@property (nonatomic, strong) UIView                         *contentView;
@property (nonatomic, strong) UILabel                         *titleLabel;//标题LB


@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
//当前正在拖拽的是否是tableView
@property (nonatomic, assign) BOOL isDragScrollView;
@property (nonatomic, strong) UIScrollView *scrollerView;
//向下拖拽最后时刻的位移
@property (nonatomic, assign) CGFloat lastDrapDistance;

@property (nonatomic, assign) BOOL ClickBGHiden;


@end


@implementation SLFCommentsPopView

+ (instancetype)commentsPopViewWithFrame:(CGRect)frame contentView:(UIView *)contentView contentViewNeedScroView:(BOOL)needScroView {
    
    NSLog(@"%f",contentView.frame.size.height);
    SLFCommentsPopView *view = [[SLFCommentsPopView alloc] initWithFrame:frame commentBackView:contentView contentViewNeedScroView:needScroView];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame commentBackView:(UIView *)contentView  contentViewNeedScroView:(BOOL)needScroView {
    self = [super initWithFrame:frame];
    if (self) {
        self.ClickBGHiden = YES;
        self.isDragScrollView = NO;
        self.lastDrapDistance = 0.0;
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)];
        self.tapGestureRecognizer = tapGestureRecognizer;
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        [self addSubviewWithContainer:contentView contentViewNeedScroView:needScroView];

    }
    return self;
}

- (void)clickBGHiden:(BOOL)hiden{
    self.ClickBGHiden  = hiden;
}
-(void)addSubviewWithContainer:(UIView *)contentView  contentViewNeedScroView:(BOOL)needScroView {
    self.contentView = contentView;
    UIView *container = [[UIView alloc] init];
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        
        make.height.mas_lessThanOrEqualTo([UIScreen mainScreen].bounds.size.height - 80);

    }];
    self.container = container;
    
//
//    //创建顶部拖动区域
//    UIView * topView = [[UIView alloc] init];
//    topView.backgroundColor = [UIColor colorWithRed:0.154 green:0.154 blue:0.154 alpha:1];
//
//    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 48) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
//    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
//    [shape setPath:rounded.CGPath];
//
//    topView.layer.mask = shape;
//
//
//    [container addSubview:topView];
//    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(container);
//        make.height.equalTo(@(48));
//    }];
//
//    UILabel * titleLabel = [[UILabel alloc] init];
//    titleLabel.backgroundColor = [UIColor colorWithRed:0.154 green:0.154 blue:0.154 alpha:1];
////    titleLabel.font = [SLFFonts MediumStyleWithSize:20];
//    titleLabel.textColor = UIColor.whiteColor;
//    self.titleLabel = titleLabel;
//
//    [topView addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(topView);
//        make.top.equalTo(topView).offset(16);
//        make.height.equalTo(@(32));
//    }];
    
    
//    UIButton * closeBtn = [[UIButton alloc] init];
//    [closeBtn setImage:[SLFBundle imageNamed:SLFImage.SLF_Close] forState:UIControlStateNormal];
////    closeBtn.backgroundColor = [UIColor yellowColor];
//    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:closeBtn];
//    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(20));
//        make.right.equalTo(@(-20));
//        make.width.height.equalTo(@(24));
//    }];




    if (needScroView) {
        //创建ScrollView
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        [container addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(container);
            make.top.equalTo(container);
            make.centerX.equalTo(container);
        }];
        // 添加内容
        [scrollView addSubview:contentView];
        [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {            make.top.bottom.equalTo(scrollView);
            make.centerX.equalTo(container);
            if (contentView.jk_height) {
                make.height.equalTo(@(contentView.jk_height));
            }
            if (contentView.jk_width) {
                make.width.equalTo(@(contentView.jk_width));
            }

        }];
    }else{
        // 添加内容
        [container addSubview:contentView];
        
        CGFloat height = contentView.frame.size.height;
        [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(container);
            make.centerX.equalTo(container);
            make.top.equalTo(container);
            make.left.right.equalTo(container);
            if (height) {
                make.height.equalTo(@(height));
            }
//            if (contentView.jk_width) {
//                make.width.equalTo(@(contentView.jk_width));
//            }

        }];
    }







//
//    [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_bottom);
//        make.left.right.equalTo(self);
//        make.height.equalTo(contentView).offset(48);
//        make.height.lessThanOrEqualTo(@([UIScreen mainScreen].bounds.size.height - 80));
//
//    }];
//
//    [self layoutIfNeeded];


    //添加拖拽手势
//    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    [self.container addGestureRecognizer:self.panGestureRecognizer];
//    self.panGestureRecognizer.delegate = self;
}




#pragma mark - Action
- (void)showWithTitileStr:(NSString *)title{
    [self showToView:[UIApplication sharedApplication].keyWindow titileStr:title];
}
//update method
- (void)showToView:(UIView *)view titileStr:(NSString *)title{
    
    self.titleLabel.text = title;
    [self removeFromSuperview];
    [view addSubview:self];
    
    
    [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(self.contentView).offset(48);
        make.height.lessThanOrEqualTo(@([UIScreen mainScreen].bounds.size.height - 80));

    }];
    
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(self.contentView);
            make.height.lessThanOrEqualTo(@([UIScreen mainScreen].bounds.size.height - 80));

        }];
        
        [self layoutIfNeeded];
    }];
    

}

- (void)dismiss {
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - UIGestureRecognizerDelegate
//1
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

    if(gestureRecognizer == self.panGestureRecognizer) {
        UIView *touchView = touch.view;
        while (touchView != nil) {
            if([touchView isKindOfClass:[UIScrollView class]]) {
                self.isDragScrollView = YES;
                self.scrollerView = (UIScrollView*)touchView;
                break;
            } else if(touchView == self.container) {
                self.isDragScrollView = NO;
                break;
            }
            touchView = (UIView *)[touchView nextResponder];
        }
    }
    return YES;
}

//2.
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer == self.tapGestureRecognizer) {
        //如果是点击手势
        CGPoint point = [gestureRecognizer locationInView:_container];
        if([_container.layer containsPoint:point] && gestureRecognizer.view == self) {
            return NO;
        }
    } else if(gestureRecognizer == self.panGestureRecognizer){
        //如果是自己加的拖拽手势
        NSLog(@"gestureRecognizerShouldBegin");
    }
    return YES;
}

//3. 是否与其他手势共存，一般使用默认值(默认返回NO：不与任何手势共存)
- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if(gestureRecognizer == self.panGestureRecognizer) {
        if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")] ) {
            if([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]] ) {

                return YES;
            }

        }
    }
    return NO;
}

//拖拽手势
- (void)pan:(UIPanGestureRecognizer *)panGestureRecognizer {
    // 获取手指的偏移量
    CGPoint transP = [panGestureRecognizer translationInView:self.container];
    if(self.isDragScrollView) {
        //如果当前拖拽的是tableView
        if(self.scrollerView.contentOffset.y <= 0) {
            //如果tableView置于顶端
            if(transP.y > 0) {
                //如果向下拖拽
                self.scrollerView.contentOffset = CGPointMake(0, 0 );
                self.scrollerView.panGestureRecognizer.enabled = NO;
                self.scrollerView.panGestureRecognizer.enabled = YES;
                self.isDragScrollView = NO;
                //向下拖
                self.container.frame = CGRectMake(self.container.frame.origin.x, self.container.frame.origin.y + transP.y, self.container.frame.size.width, self.container.frame.size.height);
            } else {
                //如果向上拖拽
            }
        }
    } else {
        if(transP.y > 0) {
            //向下拖
            self.container.frame = CGRectMake(self.container.frame.origin.x, self.container.frame.origin.y + transP.y, self.container.frame.size.width, self.container.frame.size.height);
        } else if(transP.y < 0 && self.container.frame.origin.y > (self.frame.size.height - self.container.frame.size.height)){
            //向上拖
            self.container.frame = CGRectMake(self.container.frame.origin.x, (self.container.frame.origin.y + transP.y) > (self.frame.size.height - self.container.frame.size.height) ? (self.container.frame.origin.y + transP.y) : (self.frame.size.height - self.container.frame.size.height), self.container.frame.size.width, self.container.frame.size.height);
        } else {

        }
    }

    [panGestureRecognizer setTranslation:CGPointZero inView:self.container];
    if(panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"transP : %@",NSStringFromCGPoint(transP));
        if(self.lastDrapDistance > 10 && self.isDragScrollView == NO) {
            //如果是类似轻扫的那种
            [self dismiss];
        } else {
            //如果是普通拖拽
            if(self.container.frame.origin.y >= [UIScreen mainScreen].bounds.size.height - self.container.frame.size.height/2) {
                [self dismiss];
            } else {
                [UIView animateWithDuration:0.15f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     CGRect frame = self.container.frame;
                                     frame.origin.y = self.frame.size.height - self.container.frame.size.height;
                                     self.container.frame = frame;
                                 }
                                 completion:^(BOOL finished) {
                                     NSLog(@"结束");
                                 }];
            }
        }
    }
    self.lastDrapDistance = transP.y;
}

//点击手势
- (void)handleGuesture:(UITapGestureRecognizer *)sender {

    if(self.ClickBGHiden == YES){
        
        CGPoint point = [sender locationInView:_container];
        if(![_container.layer containsPoint:point] && sender.view == self) {
            [self dismiss];
            return;
        }
    }
}

#pragma mark - lazyLoad

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}




@end
