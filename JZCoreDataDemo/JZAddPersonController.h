//
//  JZAddPersonController.h
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZAddPersonController : UIViewController
@property(nonatomic,copy) NSString * jz_nameStr; // 姓名
@property(nonatomic,copy) NSString * jz_phoneStr; // 电话
@property(nonatomic,copy) NSString * jz_type; // 模式 1 添加 2 编辑

@end
