//
//  AppointmentViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/22.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface AppointmentViewController : PublicViewController

@property (weak, nonatomic) IBOutlet UILabel *phoneCallLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *InternetName;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *caseStateLabel;

@property (weak, nonatomic) IBOutlet UILabel *appointmentTimeLabel;

@property (strong,nonatomic) NSMutableDictionary *dataDic;

@property (strong,nonatomic) NSDictionary *appointmentDataDic;

@end
