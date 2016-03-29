//
//  MakeAppointmentController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 16/1/21.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "MakeAppointmentController.h"
#import "AppDelegate.h"
#import <BJJT_Lib/FVCustomAlertView.h>
#import "UISelectListView.h"
#import "UWDatePickerView.h"

@interface MakeAppointmentController ()<UISelectListViewDelegate,UWDatePickerViewDelegate,UIAlertViewDelegate>
{
    //车牌的省市
    UISelectListView *brancesSelect;
    NSString *brancesName; //网点名称
    NSString *brancesCode; //网点名称代码
    UWDatePickerView *_pickerView; //时间选择
    NSString *selectTimes;
    UIAlertView *sucessAlertView;  //成功alertView
}
@end

@implementation MakeAppointmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快处预约";
    //查询网点名称
    [AppDelegate storyBoradAutoLay:self.view];
    [self loadBrancesName];
    
}

#pragma mark - 查询网点名称
-(void)loadBrancesName
{

    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSString *token = bigDic[@"token"];
    NSDictionary *userDic = bigDic[@"userinfo"];
    NSString *userflag = userDic[@"userflag"];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:userflag forKey:@"username"];
    [bean setValue:token forKey:@"password"];
    
    FVCustomAlertView *alertView = [[FVCustomAlertView alloc] init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:alertView];
    
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/xjkckpsearchservicenet",kckpxjapprest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [alertView dismiss];
        if (nil != result) {
            NSDictionary *bigDic = result;
            if ([bigDic[@"restate"]isEqualToString:@"0"])
            {
                if (![bigDic[@"data"]isEqual:@""]) {
                    NSArray *dataAray = bigDic[@"data"];
                    [self loadTextfiledLine:dataAray];
                }else{
                    [self showAlertView:@"暂无网点"];
                }
                
            }
            else
            {
                [self showAlertView:bigDic[@"redes"]];
            }
        }else{
            
            [self showAlertView:@"查询网点信息失败，请检查您的网络！"];
            [self loadTextfiledLine:nil];
            NSLog(@"没有请求到数据！");
        }
        
    }];
}
-(void)loadTextfiledLine:(NSArray *)array
{
    
    self.backScollView.contentSize = CGSizeMake(0, self.view.frame.size.height);
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"MakeAppointment" owner:self options:nil];
    UIView *views = [arr lastObject];
    views.frame = CGRectMake(0, 0, self.backScollView.frame.size.width, self.view.frame.size.height);
    [self.backScollView addSubview:views];
    
    CGFloat top = 8;
    CGFloat left = 5;
    CGFloat bottom = 8;
    CGFloat right = 5;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *backLine = [[UIImage imageNamed:@"select_line"] resizableImageWithCapInsets:insets];
    self.phoneNumber.background = backLine;
    self.concernName.background = backLine;
    [self.timeSelectBtn setBackgroundImage:backLine forState:UIControlStateNormal];
    [self.timeSelectBtn setTitle:@"请输入预约时间" forState:UIControlStateNormal];
    [self.timeSelectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
   // self.timeSelectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -100, 0, 0);
    
    self.upAppointBtn.layer.cornerRadius = 2;
    self.upAppointBtn.layer.masksToBounds = YES;
    
    brancesSelect = [[UISelectListView alloc]initWithFrame:CGRectMake(0, 0,self.brancesView.frame.size.width, self.brancesView.bounds.size.height)];
    brancesSelect.currentView = self.view;
    brancesSelect.delegate = self;
    [brancesSelect setShowLabelSize:[UIFont systemFontOfSize:14]];
    [brancesSelect addArray:array forKey:@"servicename"];
    brancesSelect.backgroundColor = [UIColor whiteColor];
    [brancesSelect setBackgroundImage:backLine forState:UIControlStateNormal];
    [brancesSelect setIcon:[UIImage imageNamed:@"icon10"]];
    [brancesSelect setDropWidth:50];
    self.timeSelectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.brancesView addSubview:brancesSelect];
    
    self.upAppointBtn.layer.masksToBounds = YES;
    self.describText.layer.masksToBounds = YES;
    self.upAppointBtn.layer.cornerRadius = 5;
    self.describText.layer.cornerRadius = 5;

    
}

#pragma mark - 提交预约
- (IBAction)upAppointmentBtn:(id)sender {
    
    if (self.phoneNumber.text.length != 11 || !self.concernName.text.length || !brancesName || !selectTimes.length)
    {
        [self judgeInfomation];
    }
    else
    {
        [self upMakeAppointInfomation];
    }
}

#pragma mark - 上传预约信息
-(void)upMakeAppointInfomation
{
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSString *token = bigDic[@"token"];
    NSDictionary *userDic = bigDic[@"userinfo"];
    NSString *userflag = userDic[@"userflag"];
    
    FVCustomAlertView *alertView = [[FVCustomAlertView alloc] init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:alertView];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    NSMutableDictionary *bigBean = [NSMutableDictionary dictionary];

    NSString *times = [NSString stringWithFormat:@"%@:00",selectTimes];
   // [selectTimes stringByAppendingString:@":00"];
    [bean setValue:self.appcaseno forKey:@"appcaseno"];
    [bean setValue:self.phoneNumber.text forKey:@"phonenumber"];
    [bean setValue:self.concernName.text forKey:@"name"];
    [bean setValue:brancesCode forKey:@"ordernetwork"];
    [bean setValue:brancesName forKey:@"ordernwname"];
    [bean setValue:self.describText.text forKey:@"orderdes"];
    [bean setValue:times forKey:@"ordertime"];
    [bigBean setValue:bean forKey:@"casebean"];
    [bigBean setValue:userflag forKey:@"username"];
    [bigBean setValue:token forKey:@"password"];
    
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/xjkckpsubmitkcorder",kckpxjapprest] params:bigBean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
      
        if (nil != result) {
            NSDictionary *bigDic = result;
            if ([result[@"restate"]isEqualToString:@"1"])
            {
                [self showAlertView:bigDic[@"redes"]];
            }
            else
            {
                sucessAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"预约成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [sucessAlertView show];
            }
        }else{
            
            [self showAlertView:@"保存修改信息失败，请检查您的网络！"];
            NSLog(@"没有请求到数据！");
        }
        [alertView dismiss];
        
    }];

}

#pragma mark - 选择时间
- (IBAction)selectTimeBtn:(id)sender {
    
    [self setupDateView:DateTypeOfStart];
}



#pragma mark - UWDatePickerDelegate

- (void)setupDateView:(DateType)type {
    
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_pickerView setBackgroundColor:[UIColor clearColor]];
    _pickerView.delegate = self;
    _pickerView.type = type;
    [self.view addSubview:_pickerView];
    
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    
    switch (type) {
        case DateTypeOfStart:
            // TODO 日期确定选择
        {
            selectTimes = date;
            [self.timeSelectBtn setTitle:date forState:UIControlStateNormal];
            
        }
            break;
            
        case DateTypeOfEnd:
            // TODO 日期取消选择
            break;
        default:
            break;
    }
}

#pragma mark - 下拉菜单的 delegate
-(void)selectListView:(UISelectListView *)selectListView index:(NSUInteger)index content:(NSDictionary *)dic
{
    brancesName = dic[@"servicename"];
    brancesCode = dic[@"serviceno"];
}

#pragma mark - 判断填写信息
-(void)judgeInfomation
{
    if (self.phoneNumber.text.length != 11)
    {
        [self showAlertView:@"手机号码不能为空或者手机号码不为11位！"];
    }
    else if (!self.concernName.text.length)
    {
        [self showAlertView:@"当事人姓名不能为空！"];
    }
    else if (!brancesName)
    {
        [self showAlertView:@"预约网点不能为空！"];
    }
    else if (!selectTimes.length)
    {
        [self showAlertView:@"预约时间不能为空！"];
    }
//    else if (!self.describText.text.length)
//    {
//        [self showAlertView:@"预约说明不能为空！"];
//    }
}


-(void)showAlertView:(NSString *)notice
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:notice delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == sucessAlertView) {
        if ([_currentMark isEqualToString:@"1"]) {
            //取证完成通知
            NSString *name = NotificationNameForOneStepFinish;
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:@"3" forKey:@"dealCaseStep"];
            [center postNotificationName:name object:nil userInfo:dic];
            
            NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
            [self.navigationController popToViewController:[navigationArray objectAtIndex:1] animated:YES];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
}

@end










