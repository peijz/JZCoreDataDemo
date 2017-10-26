//
//  JZPersonEntity+CoreDataProperties.h
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//
//

#import "JZPersonEntity.h"


NS_ASSUME_NONNULL_BEGIN

@interface JZPersonEntity (CoreDataProperties)

+ (NSFetchRequest<JZPersonEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
