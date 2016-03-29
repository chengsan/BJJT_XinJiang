//
//  GoResponseViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/20.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "GoResponseViewController.h"
#import "TakeResponsePhotoViewController.h"

@interface GoResponseViewController ()

@end

@implementation GoResponseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 配置UI
-(void)configUI{
    self.title = @"温馨提示";
    self.giveUpButton.layer.masksToBounds = YES;
    self.giveUpButton.layer.cornerRadius = 3;
    self.responsePhotoButton.layer.masksToBounds = YES;
    self.responsePhotoButton.layer.cornerRadius = 3;
    
    //设置navigationBar的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1];
    
    NSArray *array = self.navigationController.viewControllers;
    if(array.count > 1)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 45, 30);
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //图标
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public_back"]];
        imageView.frame = CGRectMake(10, 0, 30, 30);
        [button addSubview:imageView];
        
        // 调整 leftBarButtonItem 在 iOS7 下面的位置
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
            
        {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                           target:nil action:nil];
            negativeSpacer.width = -20;//这个数值可以根据情况自由变化
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
        }
        else
        {
            self.navigationItem.leftBarButtonItem = backItem;
        }
    }
    [self.giveUpButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.responsePhotoButton addTarget:self action:@selector(takeResponsPhoto:) forControlEvents:UIControlEventTouchUpInside];

    [AppDelegate storyBoradAutoLay:self.view];
    
}

-(void)onClick:(UIButton *)btn{
    //取证完成通知
    NSString *name = NotificationNameForOneStepFinish;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"dealCaseStep"];
    [center postNotificationName:name object:nil userInfo:dic];
    
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    [self.navigationController popToViewController:[navigationArray objectAtIndex:1] animated:YES];
}

-(void)takeResponsPhoto:(UIButton *)btn{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ResponsePhotoSB" bundle:nil];
    TakeResponsePhotoViewController *TVC = [storyBoard instantiateViewControllerWithIdentifier:@"TakeResponsePhotoID"];
    TVC.appcaseno = _appcaseno;
    TVC.type = _type;
    [self.navigationController pushViewController:TVC animated:YES];
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
