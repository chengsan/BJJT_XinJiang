//
//  AppointmentViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/22.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "AppointmentViewController.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约记录详情";
    [self requestData];
    [self configUI];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 数据转化
-(void)requestData{
    if (nil != _dataDic) {
        if (![_dataDic[@"appointdata"]isEqual:@""]) {
            _appointmentDataDic = _dataDic[@"appointdata"];
        }
    }
}

#pragma mark - 配置UI
-(void)configUI{
    if (nil != _appointmentDataDic) {

            NSString *appointtype = _appointmentDataDic[@"appointtype"];
            if ([appointtype isEqualToString:@"1"]) {
                NSMutableString *phoneCallString = [NSMutableString stringWithString:[_appointmentDataDic objectForKey:@"bespeakphone"]];
                if (phoneCallString.length == 11) {
                    [phoneCallString replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                }
                _phoneCallLabel.text = phoneCallString;
                _nameLabel.text = _appointmentDataDic[@"username"];
                _InternetName.text = _appointmentDataDic[@"servicename"];
                _timeLabel.text = _appointmentDataDic[@"subbespeaktime"];
                _caseStateLabel.text = @"预约成功";
                _caseStateLabel.textColor = [UIColor colorWithRed:107/255.0 green:220/255.0 blue:91/255.0 alpha:1.0];
                _appointmentTimeLabel.text = _appointmentDataDic[@"bespeaktime"];
                
            }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
