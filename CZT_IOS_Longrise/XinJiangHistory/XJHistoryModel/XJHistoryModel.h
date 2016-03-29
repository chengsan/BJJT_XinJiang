//
//  XJHistoryModel.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/21.
//  Copyright © 2016年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJHistoryModel : NSObject
@property (nonatomic, copy) NSString *caseaddress;
@property (nonatomic, copy) NSString *scebegintime;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *dampicoverd;
@property (nonatomic, copy) NSString *isbespeak;
@property (nonatomic, copy) NSString *scepicoverd;
@property (nonatomic, copy) NSString *acctype;
@property (nonatomic, copy) NSString *appcaseno;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
