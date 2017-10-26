//
//  JZCoreData.m
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "JZCoreData.h"
@interface JZCoreData()
@property (nonatomic , strong)NSManagedObjectContext *jz_context;
@end
@implementation JZCoreData
static JZCoreData * jz_coreDataDB;
#pragma mark - 单例化数据库对象
+ (instancetype)jz_coredataDBShare{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jz_coreDataDB = [[JZCoreData alloc]init];
    });
    return jz_coreDataDB;
}

#pragma mark - 创建数据库
- (instancetype)jz_createCoredataDB:(NSString * )DBname{
    // 这里对构建新版本的coredatamodel有关键作用
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    //1.根据模型文件，创建NSManagedObjectModel模型类
    NSURL * fileURL = [[NSBundle mainBundle] URLForResource:DBname withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:fileURL];
    //创建数据解析器
    NSPersistentStoreCoordinator *storeCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //创建数据库保存路径
    NSString * dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Mycoredata.sqlite"];
    NSURL *url = [NSURL fileURLWithPath:dbPath];
    
    //添加SQLite持久存储到解析器
    NSError *error;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil
                                             URL:url
                                         options:optionsDictionary
                                           error:&error];
    
    
    if( !error ){
        //创建对象管理上下文，并设置数据解析器
        [JZCoreData jz_coredataDBShare].jz_context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [JZCoreData jz_coredataDBShare].jz_context.persistentStoreCoordinator = storeCoordinator;
        NSLog(@"数据库打开成功！");
    }else{
        NSLog(@"数据库打开失败！错误:%@",error.localizedDescription);
    }
    
    
    return self;
}

#pragma mark - 添加数据
+ (void)jz_inserDataWith_CoredatamodelClass:(Class)modelclass CoredataModel:(void (^)(id))Coredatamodel Error:(void (^)(NSError * error))resutError{
    NSEntityDescription *classDescription = [NSEntityDescription entityForName:NSStringFromClass(modelclass) inManagedObjectContext:[JZCoreData jz_coredataDBShare].jz_context];
    id modelObject = [[modelclass alloc] initWithEntity:classDescription insertIntoManagedObjectContext:[JZCoreData jz_coredataDBShare].jz_context];
    Coredatamodel(modelObject);
    NSError *error = nil;
    [[JZCoreData jz_coredataDBShare].jz_context save:&error];
    resutError(error);
}

#pragma mark - 更新数据
+ (void)jz_updataDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void(^)(id))Coredatamodel Error:(void (^)(NSError * error))resutError{
    NSPredicate * pre = [NSPredicate predicateWithFormat:whereStr];
    NSEntityDescription * description = [NSEntityDescription entityForName:NSStringFromClass(modelclass) inManagedObjectContext:[JZCoreData jz_coredataDBShare].jz_context];
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(modelclass)];
    request.entity = description;
    request.predicate = pre;
    NSArray * array = [[JZCoreData jz_coredataDBShare].jz_context executeFetchRequest:request error:NULL];
    for (id modelobject in array) {
        Coredatamodel(modelobject);
        [[JZCoreData jz_coredataDBShare].jz_context updatedObjects];
        
    }
    
    
}

#pragma mark - 删除数据
+ (void)jz_deleteDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void(^)(BOOL isResult))isresult Error:(void (^)(NSError * error))resutError{
    NSEntityDescription * description = [NSEntityDescription entityForName:NSStringFromClass(modelclass) inManagedObjectContext:[JZCoreData jz_coredataDBShare].jz_context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    if (whereStr) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:whereStr];
        request.predicate = predicate;
    }
    request.includesPropertyValues = NO;
    request.entity = description;
    NSError *error = nil;
    NSArray *array = [[JZCoreData jz_coredataDBShare].jz_context executeFetchRequest:request error:&error];
    if (!error && array && [array count])
    {
        for (NSManagedObject *obj in array)
        {
            [[JZCoreData jz_coredataDBShare].jz_context deleteObject:obj];
            
        }
        
        if (![[JZCoreData jz_coredataDBShare].jz_context save:&error])
        {
            isresult(NO);
        }
        else
        {
            isresult(YES);
        }
    }
    
    resutError(error);
}

#pragma mark - 查询数据
+ (void)jz_selectDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr Alldata_arr:(void(^)(NSArray * coredataModelArr))CoredatamodelArr Error:(void (^)(NSError * error))resutError{
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(modelclass)];
    if (whereStr) {
        //设置筛选条件
        // =
        // CONTAINS
        // BEGINSWITH
        // ENDSWITHD
        NSPredicate * predicate = [NSPredicate predicateWithFormat:whereStr];
        request.predicate = predicate;
    }
    
    //n.
    NSError * error = nil;
    NSArray * array = [[JZCoreData jz_coredataDBShare].jz_context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"core错误：%@",error);
    }
    //    NSLog(@"%@===%@==%ld",mp.appearNum,mp.mac,array.count);
    CoredatamodelArr(array);
}
@end
