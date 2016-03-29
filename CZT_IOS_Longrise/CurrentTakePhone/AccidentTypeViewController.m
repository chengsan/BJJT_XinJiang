//
//  AccidentTypeViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/18.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "AccidentTypeViewController.h"
#import "CarTypeViewController.h"
#import "AppDelegate.h"
#import "CarTypeFactory.h"

@interface AccidentTypeViewController ()

@end

@implementation AccidentTypeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"事故类型"];
    //设置按钮监听
    [self.moreCarCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [AppDelegate storyBoradAutoLay:self.view];
}

//尝试使用objc_setAssociatedObject来实现传值
//-(void)setMoreCarCaseBtn:(UIButton *)moreCarCaseBtn{
//    objc_setAssociatedObject(moreCarCaseBtn, @"mageji", [NSNumber numberWithInteger: moreCarCaseBtn.tag], OBJC_ASSOCIATION_ASSIGN);
//    
//    NSNumber *i = objc_getAssociatedObject(moreCarCaseBtn, @"mageji");
//    NSLog(@"%@",i);
//}

#pragma mark 按钮点击回调方法
-(void)onClick:(UIButton *)btn
{
    myHUD = [[FVCustomAlertView alloc] init];
    [myHUD showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:0];
    [self startLoadData:btn];
    
}

#pragma mark 产生APP唯一案件号
-(void)startLoadData:(UIButton *)btn
{
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSString *token = bigDic[@"token"];
    NSDictionary *userInfo = bigDic[@"userinfo"];
    NSString *userFlag = userInfo[@"userflag"];
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    
    [bean setValue:userFlag forKey:@"username"];
    [bean setValue:token forKey:@"password"];
    
    NSString *tempStr = kckpxjapprest;
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[tempStr stringByAppendingString:@"/kckpCreateAppCaseNo"] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        [self loadFinish:result view:btn];
        if(nil != myHUD)
        {
            [myHUD dismiss];
        }
    } ];
    
}

#pragma mark 数据加载完成
-(void)loadFinish:(id)result view:(UIButton *)btn
{
    NSString *string = nil;
    BOOL sucess = false;
    NSDictionary *dic = result;
    if(nil == result)
    {
        string = @"数据加载失败,请检查网络。";
    }
    else
    {
        NSString *restate = [dic objectForKey:@"restate"];
        if([@"0" isEqualToString:restate])
        {
            sucess = true;
        }
        else
        {
            //失败
            string = (NSString *)[dic objectForKey:@"redes"];
        }
        
    }
    
    if(sucess)
    {
        CarTypeViewController *phoneController = nil;
        
        NSDictionary *data = [dic objectForKey:@"data"];
        NSString *appcaseno =[data objectForKey:@"appcaseno"];
        
        //获取通知对象
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:appcaseno forKey:@"appcaseno"];
        
        if(self.oneCaseBtn == btn)
        {
            [dic setValue:@"1" forKey:@"type"];
            phoneController = [CarTypeFactory createPhoneViewController:1];
        }
        else if(self.moreCarCaseBtn == btn)
        {
            [dic setValue:@"2" forKey:@"type"];
            phoneController = [CarTypeFactory createPhoneViewController:2];
        }
        //发送通知，将事故类型和报案号发送到事故步骤页面，定责用到
        NSString *name = NotificationNameForCaseType;
        [center postNotificationName:name object:nil userInfo:dic];
        
        phoneController.appcaseno = appcaseno;
        [self.navigationController pushViewController:phoneController animated:YES];
        
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = string;
        hud.margin = 20.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:3];
        
    }
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
