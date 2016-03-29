//
//  WarnViewController1.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/18.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "WarnViewController1.h"
#import "WarnViewController2.h"
#import "AppDelegate.h"

@interface WarnViewController1 ()

@end

@implementation WarnViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"温馨提示";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadXIB];
    
    
    //    UIImage *okImage = [UIImage imageNamed:@"item_bg-on"];
    //    CGFloat top = 100;
    //    CGFloat bottom = 100;
    //    CGFloat left = 100;
    //    CGFloat right = 100;
    //    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    //    okImage = [okImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    //    [self.okBtn setBackgroundImage:okImage forState:UIControlStateNormal];
    
}

-(void)loadXIB{
    NSArray *ietms = [[NSBundle mainBundle]loadNibNamed:@"WarnView1XIB" owner:self options:nil];
    UIView *views = [ietms lastObject];
    [self.view addSubview:views];
    
    self.icon1.layer.cornerRadius = 5;
    self.icon2.layer.cornerRadius = 5;
    self.icon3.layer.cornerRadius = 5;
    
    [self.okBtn setBackgroundColor:[UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1]];
    self.okBtn.layer.cornerRadius = 5;
    [self.okBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [AppDelegate storyBoradAutoLay:self.view];
}

-(void)onClick:(UIButton *)btn
{
//    WXTSViewController2 *wxtsController2 = [[WXTSViewController2 alloc] init];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"WarnView2SB" bundle:nil];
    WarnViewController2 *warn2VC = [storyBoard instantiateViewControllerWithIdentifier:@"WarnViewID"];
    [self.navigationController pushViewController:warn2VC animated:YES];
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
