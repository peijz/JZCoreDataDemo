//
//  JZCoreDataHomeCell.h
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZPersonEntity.h"
@interface JZCoreDataHomeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,weak)JZPersonEntity * jz_entity;
@end
