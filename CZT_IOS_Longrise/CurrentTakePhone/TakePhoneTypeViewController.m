//
//  TakePhoneTypeViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/20.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "TakePhoneTypeViewController.h"
#import "TakeResponsePhotoViewController.h"
#import "MakeAppointmentController.h"
#import "CZT_IOS_Longrise.pch"
#import "AppDelegate.h"
#import "SetViewController.h"
#import "WarnViewController1.h"

@interface TakePhoneTypeViewController (){
    UIAlertView *alertCarNumber; //查询车辆号码
}

@end

@implementation TakePhoneTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
        //self.isShowController = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现场处理";
    [self _initView];
    //添加通知监听，接受案件号和事故类型
    NSString *name = NotificationNameForCaseType;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiverNotification:) name:name object:nil];
    
    //添加取证完成通知
    NSString *name1 = NotificationNameForOneStepFinish;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishOneStep:) name:name1 object:nil];
    [AppDelegate storyBoradAutoLay:self.view];
}

#pragma mark 初始化UI
-(void)_initView
{
    //self.takePhoneBtn.layer.cornerRadius = 5;
    [self.takePhoneBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //self.identifiedResbtn.layer.cornerRadius = 5;
    [self.identifiedResbtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //self.reportCaseBtn.layer.cornerRadius = 5;
    [self.reportCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.takePhoneLabel.layer.cornerRadius = 15;
    self.takePhoneLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.takePhoneLabel.layer.borderWidth = 1;
    self.takePhoneLabel.layer.masksToBounds = YES;
    self.takePhoneLabel.text = @"1";
    self.takePhoneLabel.textAlignment = NSTextAlignmentCenter;
    
    self.identifiedResLabel.layer.cornerRadius = 15;
    self.identifiedResLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.identifiedResLabel.layer.borderWidth = 1;
    self.identifiedResLabel.layer.masksToBounds = YES;
    self.identifiedResLabel.text = @"2";
    self.identifiedResLabel.textAlignment = NSTextAlignmentCenter;
    
    self.reportCaseLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.reportCaseLabel.layer.borderWidth = 1;
    self.reportCaseLabel.layer.masksToBounds = YES;
    self.reportCaseLabel.layer.cornerRadius = 15;
    self.reportCaseLabel.text = @"3";
    self.reportCaseLabel.textAlignment = NSTextAlignmentCenter;
    
    //历史案件中进来
    if(self.currentMark == 1)
    {   //设置第一步拍照为选中状态
        [self setOneStep:1 selected:YES];
    }
    step = 0;
    
}

-(void)setCurrentMark:(int)currentMark
{
    step = 1;
    _currentMark = currentMark;
    [self setOneStep:1 selected:YES];
}

#pragma mark 接受通知的内容
-(void)receiverNotification:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    if(nil != dic)
    {
        self.appcaseno = [dic objectForKey:@"appcaseno"];
        
        NSString *str = [dic objectForKey:@"type"];
        if ([str isEqualToString:@"1"])
        {
            self.type = 1;
        }
        else if ([str isEqualToString:@"2"])
        {
            self.type = 2;
        }
        
    }
}

#pragma mark 接受步骤完成通知
-(void)finishOneStep:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    if(nil != dic)
    {
        NSString *stepStr = [dic objectForKey:@"dealCaseStep"];
        if([@"1" isEqualToString:stepStr])
        {
            step = 1;
//            if(nil != self.identifiedResbtn)
//            {
                //事故类型，1:单车，2:多车
//                if(self.type == 1)
//                {
//                    [self.identifiedResbtn setTitle:@"              资料录入" forState:UIControlStateNormal];
//                }
//                else
//                {
//                    [self.identifiedResbtn setTitle:@"              定损拍照" forState:UIControlStateNormal];
//                }
//            }
        }
        else if([@"2" isEqualToString:stepStr])
        {
            step = 2;
        }
        else if([@"3" isEqualToString:stepStr])
        {
            step = 3;
        }
        else
        {
            step = 0;
        }
        //设置选中效果
        [self setOneStep:step selected:true];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == alert1)
    {
        if(buttonIndex == 1)
        {
            step = 0;
            self.currentMark = 0;
            //设置状态
            [self setOneStep:1 selected:false];
            [self setOneStep:2 selected:false];
            [self setOneStep:3 selected:false];
            
          //  WXTSViewController *wxtsController = [[WXTSViewController alloc] init];
            [self.navigationController pushViewController:[[WarnViewController1 alloc]init] animated:YES];
        }
    }
    //    else if (alertView == alertCarNumber)
    //    {
    //        if (buttonIndex == 0)
    //        {
    //            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Parties" bundle:nil];
    //            PartiesConcernedController *parties = [storyboard instantiateViewControllerWithIdentifier:@"PartiesID"];
    //            parties.hidesBottomBarWhenPushed = YES;
    //            parties.appcaseno = self.appcaseno;
    //            [self.navigationController pushViewController:parties animated:YES];
    //        }
    //        else
    //        {
    //            [self.navigationController popToRootViewControllerAnimated:YES];
    //        }
    //        
    //    }
}

#pragma mark 设置某一步是否选中
-(void)setOneStep:(int)oneStep selected:(BOOL)b
{
    if(oneStep == 1)
    {
        if (nil != self.takePhoneLabel)
        {
            self.takePhoneLabel.backgroundColor = b?[UIColor colorWithRed:62 /255.0 green:166 /255.0 blue:244 /255.0 alpha:1]:[UIColor whiteColor];
            self.takePhoneLabel.textColor = (b ? [UIColor whiteColor]:[UIColor blackColor]);
        }
        if(nil != self.takePhoneBtn)
        {
            [self.takePhoneBtn setBackgroundImage:b?[UIImage imageNamed:@"item_bg-on"]:[UIImage imageNamed:@"item_bg"] forState:UIControlStateNormal];
        }
        
    }
    else if(oneStep == 2)
    {
        self.takePhoneLabel.backgroundColor = [UIColor colorWithRed:62 /255.0 green:166 /255.0 blue:244 /255.0 alpha:1];
        self.takePhoneLabel.textColor = [UIColor whiteColor];
        [self.takePhoneBtn setBackgroundImage:[UIImage imageNamed:@"item_bg-on"] forState:UIControlStateNormal];
        
        if (nil != self.identifiedResLabel)
        {
            self.identifiedResLabel.backgroundColor = b?[UIColor colorWithRed:62 /255.0 green:166 /255.0 blue:244 /255.0 alpha:1]:[UIColor whiteColor];
            self.identifiedResLabel.textColor = (b ? [UIColor whiteColor]:[UIColor blackColor]);
        }
        if(nil != self.identifiedResbtn)
        {
            [self.identifiedResbtn setBackgroundImage:b?[UIImage imageNamed:@"item_bg-on"]:[UIImage imageNamed:@"item_bg"] forState:UIControlStateNormal];
        }
    }
    else if(oneStep == 3)
    {
        self.takePhoneLabel.backgroundColor = [UIColor colorWithRed:62 /255.0 green:166 /255.0 blue:244 /255.0 alpha:1];
        self.takePhoneLabel.textColor = [UIColor whiteColor];
        [self.takePhoneBtn setBackgroundImage:[UIImage imageNamed:@"item_bg-on"] forState:UIControlStateNormal];
        
        self.identifiedResLabel.backgroundColor = [UIColor colorWithRed:62 /255.0 green:166 /255.0 blue:244 /255.0 alpha:1];
        self.identifiedResLabel.textColor = [UIColor whiteColor];
        [self.identifiedResbtn setBackgroundImage:[UIImage imageNamed:@"item_bg-on"] forState:UIControlStateNormal];
        
        if (nil != self.reportCaseLabel)
        {
            self.reportCaseLabel.backgroundColor = b?[UIColor colorWithRed:62 /255.0 green:166 /255.0 blue:244 /255.0 alpha:1]:[UIColor whiteColor];
            self.reportCaseLabel.textColor = (b ? [UIColor whiteColor]:[UIColor blackColor]);
        }
        if(nil != self.reportCaseBtn)
        {
            [self.reportCaseBtn setBackgroundImage:b?[UIImage imageNamed:@"item_bg-on"]:[UIImage imageNamed:@"item_bg"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark 单击事件回调方法
-(void)onClick:(UIButton *)btn
{
    if(btn == self.takePhoneBtn)
    {
        //判断是否是历史纪录进来的
        if(self.currentMark == 1 || step == 1 || step == 2 || step == 3)
        {
            if(nil == alert1)
            {
                alert1 = [[UIAlertView  alloc] initWithTitle:@"温馨提示" message:@"您是否要处理新案件" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
            }
            [alert1 show];
        }
        else
        {
//            WXTSViewController *wxtsController = [[WXTSViewController alloc] init];
            [self.navigationController pushViewController:[[WarnViewController1 alloc]init] animated:YES];
        }
    }
    if (btn == self.identifiedResbtn)
    {
        if(step == 0)
        {
            UIAlertView *myAlert = [[UIAlertView  alloc] initWithTitle:@"温馨提示" message:@"请先进行现场拍照" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            [myAlert show];
            return;
        }
        //判断定损拍照是否完成
        if(step == 2)
        {
            if(nil == alert2)
            {
                alert2 = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"定损拍照已经完成，请勿重复进行定损拍照" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            }
            [alert2 show];
        }
        else
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ResponsePhotoSB" bundle:nil];
            TakeResponsePhotoViewController *TVC = [storyBoard instantiateViewControllerWithIdentifier:@"TakeResponsePhotoID"];
            TVC.type = [NSString stringWithFormat:@"%d",_type];
            TVC.appcaseno = _appcaseno;
            [self.navigationController pushViewController:TVC animated:YES];

        }
    }
    if (btn == self.reportCaseBtn)
    {
        if(step == 0)
        {
            UIAlertView *myAlert = [[UIAlertView  alloc] initWithTitle:@"温馨提示" message:@"请先进行现场拍照" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            [myAlert show];
            return;
        }
        if (step == 1 || step == 2) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MakeAppointment" bundle:nil];
            MakeAppointmentController *MAVC = [storyBoard instantiateViewControllerWithIdentifier:@"MakeAppointmentID"];
            MAVC.appcaseno = _appcaseno;
            [self.navigationController pushViewController:MAVC animated:YES];
            
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
