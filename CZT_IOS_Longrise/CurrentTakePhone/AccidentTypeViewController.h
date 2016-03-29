//
//  AccidentTypeViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/18.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "CZT_IOS_Longrise.pch"
#import <objc/runtime.h>

@interface AccidentTypeViewController : PublicViewController
{
    FVCustomAlertView *myHUD;
}
@property (weak, nonatomic) IBOutlet UIButton *moreCarCaseBtn;

@property (weak, nonatomic) IBOutlet UIButton *oneCaseBtn;

@end
