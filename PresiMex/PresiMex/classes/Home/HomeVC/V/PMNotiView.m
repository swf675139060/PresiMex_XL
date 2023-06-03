//
//  PMNotiView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/28.
//

#import "PMNotiView.h"
#import "DemoCell2.h"

#import <RollingNotice/GYRollingNoticeView.h>

@interface PMNotiView()<GYRollingNoticeViewDataSource, GYRollingNoticeViewDelegate>
//@property(nonatomic, strong) UIButton * notBtn;


@property(nonatomic, strong) NSArray * Arrlist;

@property(nonatomic, strong) GYRollingNoticeView *noticeView;

@end

@implementation PMNotiView

-(void)buildSubViews{
    self.backgroundColor = [UIColor jk_colorWithHexString:@"#FC7500"];

    [self creatRollingView];
}



- (void)creatRollingView
{
    CGRect frame = CGRectMake(0, 0, WF_ScreenWidth, 33);
 
    
    self.noticeView = [[GYRollingNoticeView alloc]initWithFrame:frame];
    self.noticeView.dataSource = self;
    self.noticeView.delegate = self;
    [self addSubview:self.noticeView];
    [self.noticeView registerClass:[DemoCell2 class] forCellReuseIdentifier:@"DemoCell2"];
    
    
    [self.noticeView reloadDataAndStartRoll];
}



- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
    
    
    return self.Arrlist.count;
}
- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    DemoCell2 *cell = [rollingView dequeueReusableCellWithIdentifier:@"DemoCell2"];
    cell.customLab.text = self.Arrlist[index];
   
    return cell;

    
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    NSLog(@"点击的index: %lu", (unsigned long)index);
}






-(void)setNotList:(NSArray *)list{
    self.Arrlist  = list;
    if(list.count){
        
        [self.noticeView reloadDataAndStartRoll];
    }else{
        [self.noticeView stopRoll];
    }
    
}
@end
