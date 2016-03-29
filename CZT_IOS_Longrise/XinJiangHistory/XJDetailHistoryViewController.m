//
//  XJDetailHistoryViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/21.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "XJDetailHistoryViewController.h"
#import "XJPhotoViewController.h"
#import "AppointmentViewController.h"

@interface XJDetailHistoryViewController ()<UIAlertViewDelegate>{
    UIAlertView *currntAlertView;
    UIAlertView *reponseAlertView;
    UIAlertView *appointmentAlertView;
}

@end

@implementation XJDetailHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 初始化UI
-(void)configUI{
    self.title = @"案件详情";
    if (nil != _dataDic) {
        NSString *cartype = _dataDic[@"acctype"];
        if ([cartype isEqualToString:@"1"]) {
            _cartypeLabel.text = @"单车";
        }else{
            _cartypeLabel.text = @"双车";
        }
        
        NSString *type = _dataDic[@"type"];
        if ([type isEqualToString:@"1"]) {
            _caseStateLabel.text = @"取证未完成";
            _caseStateLabel.textColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:15/255.0 alpha:1.0];
        }else if ([type isEqualToString:@"2"]){
            _caseStateLabel.text = @"未预约";
            _caseStateLabel.textColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:15/255.0 alpha:1.0];
        }else if ([type isEqualToString:@"3"]){
            _caseStateLabel.text = @"预约成功";
            _caseStateLabel.textColor = [UIColor colorWithRed:107/255.0 green:220/255.0 blue:91/255.0 alpha:1.0];
        }
        
        NSString *time = _dataDic[@"scebegintime"];
        _timeLabel.text = time;
    }
    
}

#pragma mark - 点击事件
- (IBAction)currentTakePhotoClicked:(id)sender {
    if (nil != _dataDic) {
        if (![_dataDic[@"scenedata"]isEqual:@""]) {
            XJPhotoViewController *PVC = [XJPhotoViewController new];
            PVC.sceneDataArray = [NSMutableArray array];
            PVC.sceneDataArray = _dataDic[@"scenedata"];
            [self.navigationController pushViewController:PVC animated:YES];
            
        }else{
            currntAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您当前还没有拍摄现场照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [currntAlertView show];
        }
    }else{
        currntAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您当前还没有拍摄现场照片!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [currntAlertView show];
    }
}

- (IBAction)responsTakePhotoClicked:(id)sender {
    if (nil != _dataDic) {
        if (![_dataDic[@"assessdata"]isEqual:@""]) {
            XJPhotoViewController *PVC = [XJPhotoViewController new];
            PVC.asswssDataArray = [NSMutableArray array];
            PVC.asswssDataArray = _dataDic[@"assessdata"];
            [self.navigationController pushViewController:PVC animated:YES];
        }else{
            reponseAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您当前还没有拍摄定损照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [reponseAlertView show];
        }
    }
    
}

- (IBAction)appointmentClicked:(id)sender {
    if (nil != _dataDic) {
        if (![_dataDic[@"appointdata"]isEqual:@""]) {
            
            AppointmentViewController *APVC = [AppointmentViewController new];
            APVC.dataDic = [NSMutableDictionary dictionary];
            [APVC.dataDic setValue:_dataDic[@"appointdata"] forKey:@"appointdata"];
            [self.navigationController pushViewController:APVC animated:YES];
            
        }else{
            
            appointmentAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"暂无快处预约信息!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [appointmentAlertView show];
            
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
