//
//  JZCoreData.h
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface JZCoreData : NSObject
// 单例化数据库对象
+ (instancetype)jz_coredataDBShare;
// 创建数据库
- (instancetype)jz_createCoredataDB:(NSString * )DBname;
// 添加数据
+ (void)jz_inserDataWith_CoredatamodelClass:(Class)modelclass CoredataModel:(void (^)(id))Coredatamodel Error:(void (^)(NSError * error))resutError;
// 更新数据
+ (void)jz_updataDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void(^)(id))Coredatamodel Error:(void (^)(NSError * error))resutError;
// 删除数据 删除条件为nil为全部删除
+ (void)jz_deleteDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void(^)(BOOL isResult))isresult Error:(void (^)(NSError * error))resutError;
// 查询数据 查询条件nil为全部查询
+ (void)jz_selectDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr Alldata_arr:(void(^)(NSArray * coredataModelArr))CoredatamodelArr Error:(void (^)(NSError * error))resutError;
@end
