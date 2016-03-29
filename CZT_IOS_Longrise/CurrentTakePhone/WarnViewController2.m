//
//  WarnViewController2.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/18.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "WarnViewController2.h"
#import "AccidentTypeViewController.h"

@interface WarnViewController2 ()

@end

@implementation WarnViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"温馨提示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *itemViews = [[NSBundle mainBundle]loadNibNamed:@"WarnView2Xib" owner:self options:nil];
    UIView *itemView = [itemViews lastObject];
    itemView.frame = CGRectMake(0, 0, self.bacScrollView.frame.size.width, 650);
    self.bacScrollView.contentSize = CGSizeMake(0, 650);
    [self.bacScrollView addSubview:itemView];
    
    self.btn1.layer.cornerRadius = 5;
    self.btn1.layer.borderColor = [UIColor grayColor].CGColor;
    self.btn1.layer.borderWidth = 0.5;
    self.btn1.layer.masksToBounds = YES;
    
    self.btn2.layer.cornerRadius = 5;
    self.btn2.layer.borderColor = [UIColor grayColor].CGColor;
    self.btn2.layer.borderWidth = 0.5;
    self.btn2.layer.masksToBounds = YES;
    
    self.btn3.layer.cornerRadius = 5;
    self.btn3.layer.borderColor = [UIColor grayColor].CGColor;
    self.btn3.layer.borderWidth = 0.5;
    self.btn3.layer.masksToBounds = YES;
    
    self.btn4.layer.cornerRadius = 5;
    self.btn4.layer.borderColor = [UIColor grayColor].CGColor;
    self.btn4.layer.borderWidth = 0.5;
    self.btn4.layer.masksToBounds = YES;
    
    self.btn5.layer.cornerRadius = 5;
    self.btn5.layer.borderColor = [UIColor grayColor].CGColor;
    self.btn5.layer.borderWidth = 0.5;
    self.btn5.layer.masksToBounds = YES;
    
    self.okBtn.layer.cornerRadius = 5;
    [self.okBtn setBackgroundColor:[UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1]];
    self.repCaseBtn.layer.cornerRadius = 5;
    [self.repCaseBtn setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]];
    
    
    //设置监听
    [self.okBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.repCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [AppDelegate storyBoradAutoLay:self.view];
}

#pragma mark 按钮点击回调方法
-(void)onClick:(UIButton *)btn
{
    if(btn == self.okBtn)
    {
//        PZQZViewController *pzqzController = [[PZQZViewController alloc] init];
        [self.navigationController pushViewController:[[AccidentTypeViewController alloc]init] animated:YES];
    }
    else if(btn == self.repCaseBtn)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"你要拨打112吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://112"]];
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
