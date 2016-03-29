//
//  XJDetailHistoryViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/21.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface XJDetailHistoryViewController : PublicViewController

@property (nonatomic,strong)NSDictionary *dataDic;

@property (weak, nonatomic) IBOutlet UILabel *cartypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *caseStateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
