//
//  JZAddPersonCell.m
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "JZAddPersonCell.h"
@interface JZAddPersonCell()
// 姓名文本
@property(nonatomic,weak)UILabel * jz_nameLabel;

// 线
@property(nonatomic,weak)UIView * jz_line;
// 电话文本
@property(nonatomic,weak)UILabel * jz_phoneLabel;

@end
@implementation JZAddPersonCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * IJZAddPersonCell = @"JZAddPersonCell";
    JZAddPersonCell * cell = [tableView dequeueReusableCellWithIdentifier:IJZAddPersonCell];
    if (cell == nil)
    {
        cell = [[JZAddPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IJZAddPersonCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    // 姓名文本
    UILabel * jz_nameLabel = [[UILabel alloc]init];
    jz_nameLabel.text = @"姓名:";
    jz_nameLabel.textColor = [UIColor blackColor];
    jz_nameLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:jz_nameLabel];
    self.jz_nameLabel = jz_nameLabel;
    
    // 姓名录入框
    UITextField * jz_nameText = [[UITextField alloc]init];
    jz_nameText.font = [UIFont systemFontOfSize:20];
    jz_nameText.textAlignment = NSTextAlignmentRight;
    jz_nameText.placeholder = @"请输入姓名";
    [self.contentView addSubview:jz_nameText];
    self.jz_nameText = jz_nameText;
    
    // 线
    UIView * jz_line = [[UIView alloc]init];
    jz_line.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:jz_line];
    self.jz_line = jz_line;
    
    // 电话文本
    UILabel * jz_phoneLabel = [[UILabel alloc]init];
    jz_phoneLabel.text = @"电话:";
    jz_phoneLabel.textColor = [UIColor blackColor];
    jz_phoneLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:jz_phoneLabel];
    self.jz_phoneLabel = jz_phoneLabel;
    
    // 电话录入框
    UITextField * jz_phoneText = [[UITextField alloc]init];
    jz_phoneText.font = [UIFont systemFontOfSize:20];
    jz_phoneText.textAlignment = NSTextAlignmentRight;
    jz_phoneText.placeholder = @"请输入电话";
    [self.contentView addSubview:jz_phoneText];
    self.jz_phoneText = jz_phoneText;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 姓名文本
    CGFloat jz_nameLabelX = 10;
    CGFloat jz_nameLabelY = 10;
    CGFloat jz_nameLabelW = 60;
    CGFloat jz_nameLabelH = 25;
    self.jz_nameLabel.frame = CGRectMake(jz_nameLabelX, jz_nameLabelY, jz_nameLabelW, jz_nameLabelH);
    
    // 姓名录入框
    CGFloat jz_nameTextX = CGRectGetMaxX(self.jz_nameLabel.frame);
    CGFloat jz_nameTextY = jz_nameLabelY;
    CGFloat jz_nameTextW = self.bounds.size.width - jz_nameTextX - 10;
    CGFloat jz_nameTextH = jz_nameLabelH;
    self.jz_nameText.frame = CGRectMake(jz_nameTextX, jz_nameTextY, jz_nameTextW, jz_nameTextH);
    
    // 线
    CGFloat jz_lineX = 0;
    CGFloat jz_lineY = CGRectGetMaxY(self.jz_nameText.frame);
    CGFloat jz_lineW = self.bounds.size.width;
    CGFloat jz_lineH = 0.5;
    self.jz_line.frame = CGRectMake(jz_lineX, jz_lineY, jz_lineW, jz_lineH);
    
    // 电话文本
    CGFloat jz_phoneLabelX = jz_nameLabelX;
    CGFloat jz_phoneLabelY = CGRectGetMaxY(self.jz_line.frame)+10;
    CGFloat jz_phoneLabelW = jz_nameLabelW;
    CGFloat jz_phoneLabelH = jz_nameLabelH;
    self.jz_phoneLabel.frame = CGRectMake(jz_phoneLabelX, jz_phoneLabelY, jz_phoneLabelW, jz_phoneLabelH);
    
    // 电话录入框
    CGFloat jz_phoneTextX = jz_nameTextX;
    CGFloat jz_phoneTextY = jz_phoneLabelY;
    CGFloat jz_phoneTextW = jz_nameTextW;
    CGFloat jz_phoneTextH = jz_nameTextH;
    self.jz_phoneText.frame = CGRectMake(jz_phoneTextX, jz_phoneTextY, jz_phoneTextW, jz_phoneTextH);
}

@end
