//
//  PMIDAuthViewCell.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMIDAuthViewCell.h"

@implementation PMIDAuthViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PMIDAuthViewCell";
    
    PMIDAuthViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMIDAuthViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


-(void)setupSubViews{
    
}


-(void)setCellWithModel:(PMIDAuthModel*)model{
    
}
@end
