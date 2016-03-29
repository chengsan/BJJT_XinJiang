//
//  FinishTakePhotoViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/19.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface FinishTakePhotoViewController : PublicViewController

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (copy, nonatomic) NSString *appcaseno;

@property (nonatomic,copy)NSString *type; //车辆类型

@end
