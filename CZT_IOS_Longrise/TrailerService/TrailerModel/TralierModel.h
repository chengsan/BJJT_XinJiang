//
//  TralierModel.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/25.
//  Copyright © 2016年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TralierModel : NSObject
@property (nonatomic, copy) NSString *servicetel;
@property (nonatomic, copy) NSString *serviceno;
@property (nonatomic, copy) NSString *servicename;
@property (nonatomic, copy) NSString *serviceaddress;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
