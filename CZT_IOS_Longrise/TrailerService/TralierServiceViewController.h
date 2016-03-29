//
//  TralierServiceViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/19.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface TralierServiceViewController : PublicViewController

@property (weak, nonatomic) IBOutlet UITableView *tralierTableView;

@property (assign, nonatomic) int page;

@property (copy, nonatomic) NSString *phoneNumber; //选中cell的电话号码

@end
