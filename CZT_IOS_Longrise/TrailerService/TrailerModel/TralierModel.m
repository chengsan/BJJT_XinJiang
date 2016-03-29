//
//  TralierModel.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/25.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "TralierModel.h"

@implementation TralierModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
