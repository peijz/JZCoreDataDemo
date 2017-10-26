//
//  JZAddPersonCell.h
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZAddPersonCell : UITableViewCell
// 姓名录入框
@property(nonatomic,weak)UITextField * jz_nameText;
// 电话录入框
@property(nonatomic,weak)UITextField * jz_phoneText;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
