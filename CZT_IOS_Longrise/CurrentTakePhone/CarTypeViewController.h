//
//  CarTypeViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/19.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "CZT_IOS_Longrise.pch"
#import "FinishTakePhotoViewController.h"

@interface CarTypeViewController : PublicViewController<UIAlertViewDelegate>{
    NSMutableDictionary *tempDic;
    UIAlertView *alert1;
    FVCustomAlertView *hud;
}
@property(nonatomic,copy)NSString *appcaseno;
@property(nonatomic,copy)NSString *type;  //事故类型

#pragma mark 发送数据
-(void)sendPhoneInfo:(NSMutableDictionary *)dic;
#pragma mark 取证完成
-(void)zdsubmitcaseimageisover:(NSMutableDictionary *)dic;
#pragma mark 照片没有拍摄完整提示
-(void)showNoticeAboutImage;
@end
