//
//  CarTypeFactory.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/19.
//  Copyright © 2016年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarTypeViewController.h"

@interface CarTypeFactory : NSObject

//mark 1:单车 2:多车
+(CarTypeViewController *)createPhoneViewController:(int)mark;

@end
