//
//  CarTypeFactory.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/19.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "CarTypeFactory.h"
#import "MuchViewController.h"
#import "SingleViewController.h"

@implementation CarTypeFactory
#pragma mark 1:单车 2:多车
+(CarTypeViewController *)createPhoneViewController:(int)mark
{
    CarTypeViewController *phoneViewController = nil;
    switch (mark)
    {
        case 1:
        {
            phoneViewController = [[SingleViewController alloc] init];
            break;
        }
        case 2:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MuchViewStoryBoard" bundle:nil];
            phoneViewController = [storyboard instantiateViewControllerWithIdentifier:@"MuchControrllerID"];
            break;
        }
    }
    
    return phoneViewController;
}
@end
