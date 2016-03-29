//
//  GoResponseViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/20.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface GoResponseViewController : PublicViewController

@property (weak, nonatomic) IBOutlet UIButton *giveUpButton;

@property (weak, nonatomic) IBOutlet UIButton *responsePhotoButton;

@property (copy, nonatomic) NSString *appcaseno;

@property (copy, nonatomic) NSString *type;

@end
