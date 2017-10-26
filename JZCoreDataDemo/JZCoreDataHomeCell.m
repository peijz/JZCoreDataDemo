//
//  JZCoreDataHomeCell.m
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "JZCoreDataHomeCell.h"
#define JZIphoneWidth [UIScreen mainScreen].bounds.size.width
#define JZIphoneHeight [UIScreen mainScreen].bounds.size.height
@interface JZCoreDataHomeCell()
// 姓名
@property(nonatomic,weak)UILabel * jz_nameText;
// 电话
@property(nonatomic,weak)UILabel * jz_phoneText;

// 线
@property(nonatomic,weak)UIView * jz_line;
@end
@implementation JZCoreDataHomeCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * IJZCoreDataHomeCell = @"JZCoreDataHomeCell";
    JZCoreDataHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:IJZCoreDataHomeCell];
    if (cell == nil)
    {
        cell = [[JZCoreDataHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IJZCoreDataHomeCell];
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
    // 姓名
    UILabel * jz_nameText = [[UILabel alloc]init];
    jz_nameText.text = @"";
    jz_nameText.textColor = [UIColor blackColor];
    jz_nameText.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:jz_nameText];
    self.jz_nameText = jz_nameText;
    
    // 电话
    UILabel * jz_phoneText = [[UILabel alloc]init];
    jz_phoneText.text = @"";
    jz_phoneText.textColor = [UIColor blackColor];
    jz_phoneText.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:jz_phoneText];
    self.jz_phoneText = jz_phoneText;
    
    // 线
    UIView *jz_line = [[UIView alloc]init];
    jz_line.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:jz_line];
    self.jz_line = jz_line;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 姓名
    CGFloat jz_nameTextX = 10;
    CGFloat jz_nameTextY = 10;
    CGFloat jz_nameTextW = self.bounds.size.width - 2*jz_nameTextX;
    CGFloat jz_nameTextH = 20;
    self.jz_nameText.frame = CGRectMake(jz_nameTextX, jz_nameTextY, jz_nameTextW, jz_nameTextH);
    
    // 电话
    CGFloat jz_phoneTextX = jz_nameTextX;
    CGFloat jz_phoneTextY = CGRectGetMaxY(self.jz_nameText.frame)+10;
    CGFloat jz_phoneTextW = jz_nameTextW;
    CGFloat jz_phoneTextH = jz_nameTextH;
    self.jz_phoneText.frame = CGRectMake(jz_phoneTextX, jz_phoneTextY, jz_phoneTextW, jz_phoneTextH);
    
    // 线
    CGFloat jz_lineX = 0;
    CGFloat jz_lineY = self.bounds.size.height - 0.5;
    CGFloat jz_lineW = self.bounds.size.width;
    CGFloat jz_lineH = 0.5;
    self.jz_line.frame = CGRectMake(jz_lineX, jz_lineY, jz_lineW, jz_lineH);
}

-(void)setJz_entity:(JZPersonEntity *)jz_entity{
    _jz_entity = jz_entity;
    // 名称
    if (jz_entity.name.length>0) {
        self.jz_nameText.text = jz_entity.name;
    }else{
        self.jz_nameText.text = @"无姓名";
    }
    
    // 电话
    if (jz_entity.phone.length>0) {
        self.jz_phoneText.text = jz_entity.phone;
    }else{
        self.jz_phoneText.text = @"无电话";
    }
}

@end
