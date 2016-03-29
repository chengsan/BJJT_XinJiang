//
//  TakeResponsePhotoViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/20.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "TakeResponsePhotoViewController.h"
#import <BJJT_Lib/UIImageView+WebCache.h>

@interface TakeResponsePhotoViewController ()

@end

@implementation TakeResponsePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self monitorBackButton];
    [self loadXib];
    // Do any additional setup after loading the view.
}

-(void)monitorBackButton{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1];
    
    //监听back键
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
    
    self.finishBtn.layer.masksToBounds = YES;
    self.finishBtn.layer.cornerRadius = 5;
    [self.finishBtn setBackgroundColor:[UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1]];
}

-(void)loadXib{
    
    NSArray *itemViews = [[NSBundle mainBundle]loadNibNamed:@"ResponsePhotoXib" owner:self options:nil];
    UIView *itemView = [itemViews lastObject];
    itemView.frame = CGRectMake(0, 0, self.bacScrollView.frame.size.width, 550);
    self.bacScrollView.contentSize = CGSizeMake(0, 550);
    [self.bacScrollView addSubview:itemView];
    
    //从历史记录进来
    if (![_responsePhotoArray isEqual:@""] && _responsePhotoArray != nil) {
        //如果拍照已完成则隐藏finishBtn
        if ([_dampicoverd isEqualToString:@"1"]) {
            _finishBtn.hidden = YES;
        }
        for (NSDictionary *dic in _responsePhotoArray) {
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 30)/2, _imageBtn1.frame.size.height)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imageurl"]]];
    
            if ([dic[@"imagetype"]isEqualToString:@"10"]) {
                [_imageBtn1 addSubview:imageView];
                _imageBtn1.tag = 1;   //tag为1表示该照片已拍摄过
            }else if ([dic[@"imagetype"]isEqualToString:@"11"]){
                [_imageBtn2 addSubview:imageView];
                _imageBtn2.tag = 1;
            }else if ([dic[@"imagetype"]isEqualToString:@"12"]){
                [_imageBtn3 addSubview:imageView];
                _imageBtn3.tag = 1;
            }else if ([dic[@"imagetype"]isEqualToString:@"13"]){
                [_imageBtn4 addSubview:imageView];
                _imageBtn4.tag = 1;
            }else if ([dic[@"imagetype"]isEqualToString:@"14"]){
                [_imageBtn5 addSubview:imageView];
                _imageBtn5.tag = 1;
            }else if ([dic[@"imagetype"]isEqualToString:@"16"]){
                [_imageBtn6 addSubview:imageView];
                _imageBtn6.tag = 1;
            }
        }
    }
    
    [self.imageBtn1 addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn2 addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn3 addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn4 addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn5 addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn6 addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishBtn addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - photo点击事件
-(void)photoBtnClicked:(UIButton *)btn{
    
    if(btn == self.finishBtn)
    {
        //判断照片是否拍摄完成(0:未完成，1:完成)
        long tag = 0;
        tag = self.imageBtn1.tag;
        if(tag != 1)
        {
            [self showNoticeAboutImage];
            return;
        }
        tag = 0;
        
        tag = self.imageBtn2.tag;
        if(tag != 1)
        {
            [self showNoticeAboutImage];
            return;
        }
        tag = 0;
        
        tag = self.imageBtn3.tag;
        if(tag != 1)
        {
            [self showNoticeAboutImage];
            return;
        }
        tag = 0;
        
        tag = self.imageBtn5.tag;
        if (tag != 1) {
            [self showNoticeAboutImage];
            return;
        }
        tag = 0;
        
        NSMutableDictionary *finishDic = [[NSMutableDictionary alloc] init];
        [finishDic setObject:self.appcaseno forKey:@"appcaseno"];
        NSDictionary *userinfo = [[Globle getInstance].loginInfoDic objectForKey:@"userinfo"];
        NSDictionary *loginInfo = [Globle getInstance].loginInfoDic;
        NSString *token = loginInfo[@"token"];
        NSString *userflag = userinfo[@"userflag"];
        if(nil != userinfo)
        {
            [finishDic setValue:[userinfo objectForKey:@"mobilephone"] forKey:@"appphone"];
        }
        [finishDic setObject:@"2" forKey:@"shoottype"];
        [finishDic setObject:userflag forKey:@"username"];
        [finishDic setObject:token forKey:@"password"];
        
//        [self zdsubmitcaseimageisover:finishDic];
        if (hud == nil) {
            hud = [[FVCustomAlertView alloc]init];
        }
        [hud showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:0];
        
        NSString *tempStr = kckpxjapprest;
        [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[tempStr stringByAppendingString:@"/xjsubmitcaseimageisover"] params:finishDic httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            NSDictionary *bigDic = result;
            if (nil != bigDic) {
                if ([bigDic[@"restate"]isEqualToString:@"0"]) {
                    
                    //取证完成通知
                    NSString *name = NotificationNameForOneStepFinish;
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:@"2" forKey:@"dealCaseStep"];
                    [center postNotificationName:name object:nil userInfo:dic];
                    
                    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
                    [self.navigationController popToViewController:[navigationArray objectAtIndex:1] animated:YES];
                }else{
                    [self showAlertView:bigDic[@"redes"]];
                }
                
            }else{
                
                [self showAlertView:@"请检查网络是否连接!"];
            }
            
            if(nil != hud)
            {
                [hud dismiss];
            }
        }];
        
        return;
    }
    tempBtn = btn;
    tempBtn.tag =1;
    
    if(btn == self.imageBtn1)
    {
        shoottype = 10;
    }
    else if(btn == self.imageBtn2)
    {
        shoottype = 11;
    }
    else if(btn == self.imageBtn3)
    {
        shoottype = 12;
    }
    else if(btn == self.imageBtn4)
    {
        shoottype = 13;
    }
    else if (btn == self.imageBtn5)
    {
        shoottype = 14;
    }
    else if (btn == self.imageBtn6)
    {
        shoottype = 16;
    }
    [self takePhone2:shoottype];

    
}

- (void)takePhone2:(int)photoType
{
    //遵守协议
    TakePhotoViewController *cameraVc = [[TakePhotoViewController alloc]initWithNibName:@"BJJT_Lib.framework/TakePhotoViewController" bundle:nil];
    cameraVc.delegate = self;
    if(photoType == 10)
    {
        cameraVc.stringFromLast = @"身份证正面";
        cameraVc.imageFromLast = [UIImage imageNamed:@"IDcard_Photo_font"];
    }
    else if(photoType == 11)
    {
        cameraVc.stringFromLast = @"身份证背面";
        cameraVc.imageFromLast = [UIImage imageNamed:@"IDcard_Photo_behind"];
    }
    else if(photoType == 12)
    {
        cameraVc.stringFromLast = @"损失部位全貌";
        cameraVc.imageFromLast = [UIImage imageNamed:@"car_one_zhuang"];
    }
    else if(photoType == 13)
    {
        cameraVc.stringFromLast = @"损失部位近貌";
        cameraVc.imageFromLast = [UIImage imageNamed:@"car_close_photo"];
    }
    else if (photoType == 14)
    {
        cameraVc.stringFromLast = @"车辆识别码";
        cameraVc.imageFromLast = [UIImage imageNamed:@"other_drive_license"];
        
    }
    else if (photoType == 16)
    {
        cameraVc.stringFromLast = @"其它";
        cameraVc.imageFromLast = [UIImage imageNamed:@"other_photo"];
    }
    
    UINavigationController *cameraNavigationController = [[UINavigationController alloc] initWithRootViewController:cameraVc];
    cameraNavigationController.navigationBarHidden = YES;
    [self presentViewController:cameraNavigationController animated:YES completion:nil];
}

#pragma mark 自定义相机回调方法
-(void)takeTheCamera:(UIImage *)image
{
    if(nil == tempBtn || image == nil)
    {
        return;
    }
    
    //进行缩放图片
    //    CGSize imgSize = image.size;
    //    float height = imgSize.width*(640/imgSize.height);
    
    tempImage = [Util originImage:image scaleToSize:CGSizeMake(640,480)];
    [tempBtn setBackgroundImage:tempImage forState:UIControlStateNormal];
    
    //提交照片
    [self zdsubmitcaseimageinfor];
}

#pragma mark 上传图片
-(void)zdsubmitcaseimageinfor
{
    if(nil == tempImage)
    {
        return;
    }
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSString *token = bigDic[@"token"];
    NSDictionary *userInfo = bigDic[@"userinfo"];
    NSString *userFlag = userInfo[@"userflag"];
    
    NSData *_data = UIImageJPEGRepresentation(tempImage, 0.9);
    NSString * encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    encodedImageStr = [encodedImageStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    encodedImageStr = [NSString stringWithFormat:@"\"%@\"",encodedImageStr];
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //移动报案号
    [dic setValue:self.appcaseno forKey:@"appcaseno"];
    //经度
    [dic setValue:[[NSNumber alloc] initWithFloat:[Globle getInstance].imagelon] forKey:@"imagelon"];
    //纬度
    [dic setValue:[[NSNumber alloc] initWithFloat:[Globle getInstance].imagelat] forKey:@"imagelat"];
    //地址描述	String
    [dic setValue:[Globle getInstance].imageaddress forKey:@"imageaddress"];
    //经过序列化的字节数组字符串
    [dic setValue:encodedImageStr forKey:@"imagedata"];
    //图片大小(单位是K)	String
    [dic setValue:[Util getImageBig:tempImage] forKey:@"imagebig"];
    //图片的宽
    [dic setValue:[[NSNumber alloc] initWithInt:tempImage.size.width] forKey:@"imagewide"];
    //图片的高
    [dic setValue:[[NSNumber alloc] initWithInt:tempImage.size.height] forKey:@"imageheigth"];
    NSDictionary *userinfo = [[Globle getInstance].loginInfoDic objectForKey:@"userinfo"];
    //报案手机号
    [dic setValue:[userinfo objectForKey:@"mobilephone"] forKey:@"casetelephoe"];
    //拍摄类型	String		1,定责图片 2定损图片
    [dic setValue:[[NSNumber alloc] initWithInt:2] forKey:@"shoottype"];
    /*照片类型	Int	4
     1	侧前方事故全景
     2	侧后方事故全景
     3	碰撞部位
     4	本方车辆损失全景
     5	对方车辆损失全景
     6	本方车辆行驶证
     7	本方车辆驾驶证
     8	对方车辆行驶证
     9	对方车辆驾驶证
     */
    [dic setValue:[[NSNumber alloc] initWithInt:shoottype] forKey:@"imagetype"];
    //拍照时间	String	19	格式：YYYY-MM-DD HH:MM:SS(24小时)
    [dic setValue:[Util getCurrentTimeByFormal:@"yyyy-MM-dd HH:mm:ss"] forKey:@"imagedate"];
    //区域	String	18	报案所在的区域精确到区级
    [dic setValue:[Globle getInstance].areaid forKey:@"areaid"];
    //事故类型
    [dic setValue:self.type forKey:@"acctype"];
    //用户名
    [dic setValue:userFlag forKey:@"username"];
    //密码
    [dic setValue:token forKey:@"password"];
    
    [self sendPhoneInfo:dic];
    
}


#pragma mark 点击回调函数
-(void)onClick:(UIButton *)btn
{
    //如果从历史记录进来的点击返回不发通知
    if (![_currentMark isEqualToString:@"1"]) {
        //取证完成通知
        NSString *name = NotificationNameForOneStepFinish;
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"1" forKey:@"dealCaseStep"];
        [center postNotificationName:name object:nil userInfo:dic];
    }
    
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    [self.navigationController popToViewController:[navigationArray objectAtIndex:1] animated:YES];
}

#pragma mark - 提示
-(void)showAlertView:(NSString *)notice
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:notice delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
