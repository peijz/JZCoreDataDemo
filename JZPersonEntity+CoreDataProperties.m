//
//  JZPersonEntity+CoreDataProperties.m
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//
//

#import "JZPersonEntity+CoreDataProperties.h"

@implementation JZPersonEntity (CoreDataProperties)

+ (NSFetchRequest<JZPersonEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"JZPersonEntity"];
}

@dynamic name;
@dynamic phone;

@end
