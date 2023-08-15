//
//  PMNotiView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/28.
//

#import "PMNotiView.h"
#import "UUMarqueeView.h"

@interface PMNotiView()<UUMarqueeViewDelegate>


@property(nonatomic, strong) NSArray * Arrlist;
@property(nonatomic, strong) UUMarqueeView * marqueeView;


@end

@implementation PMNotiView

-(void)buildSubViews{
    self.backgroundColor = [UIColor jk_colorWithHexString:@"#FC7500"];

    [self creatRollingView];
}

-(void)creatRollingView{
    
    UIButton *testBtn = [[UIButton alloc] init];
    testBtn.frame = CGRectMake(15, 0, 11, 33);
    [testBtn setImage:[UIImage imageNamed:@"tongzhi"] forState:UIControlStateNormal];
    [self addSubview:testBtn];
    
    self.marqueeView = [[UUMarqueeView alloc] initWithFrame:CGRectMake(36.0f, 0.0f, WF_ScreenWidth - 33, 33.0f) direction:UUMarqueeViewDirectionLeftward];
    self.marqueeView.delegate = self;
    self.marqueeView.timeIntervalPerScroll = 0.0f;
    self.marqueeView.stopWhenLessData = YES;
    self.marqueeView.scrollSpeed = 60.0f;
    self.marqueeView.itemSpacing = 20.0f;    // the minimum spacing between items
    self.marqueeView.touchEnabled = YES;    // Set YES if you want to handle touch event. Default is NO.
    [self addSubview:self.marqueeView];
    [self.marqueeView reloadData];
}

- (NSUInteger)numberOfVisibleItemsForMarqueeView:(UUMarqueeView*)marqueeView {
    // this will be called only when direction is [UUMarqueeViewDirectionUpward].
    // set a row count that you want to display.
    return 1;
}

- (NSUInteger)numberOfDataForMarqueeView:(UUMarqueeView*)marqueeView {
    // the count of data source array.
    // For example: if data source is @[@"A", @"B", @"C"]; then return 3.
    return self.Arrlist.count;
}

- (void)createItemView:(UIView*)itemView forMarqueeView:(UUMarqueeView*)marqueeView {
    // add any subviews you want but do not set any content.
    // this will be called to create every row view in '-(void)reloadData'.
    // ### give a tag on all of your changeable subviews then you can find it later('-(void)updateItemView:withData:forMarqueeView:').
    UILabel *content = [[UILabel alloc] initWithFrame:itemView.bounds];
    content.font = [UIFont systemFontOfSize:16.0f];
    content.tag = 1001;
    [itemView addSubview:content];
}

- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    // set content to subviews, this will be called on each time the MarqueeView scrolls.
    // 'index' is the index of data source array.
    UILabel *content = [itemView viewWithTag:1001];
    content.textColor = [UIColor whiteColor];
    content.text = self.Arrlist[index];
}

- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    // this will be called only when direction is [UUMarqueeViewDirectionLeftward].
    // give the width of item view when the data source setup.
    // ### is good to cache the width once and reuse it in next time. if you do so, remember to clear the cache when you chang the data source array.
    UILabel *content = [[UILabel alloc] init];
    content.font = [UIFont systemFontOfSize:16.0f];
    content.text = self.Arrlist[index];
    return content.intrinsicContentSize.width;
}

- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    // if 'touchEnabled' is 'YES', this will call back when touch on the item view.
    // if you ever changed data source array, becareful in using the index.
    NSLog(@"Touch at index %lu", (unsigned long)index);
}




-(void)setNotList:(NSArray *)list{
    self.Arrlist  = list;
    if(list.count){
        
        [self.marqueeView reloadData];
    }else{
        [self.marqueeView reloadData];
    }
    
}
@end
