//
//  TakePhoneTypeViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/20.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "CZT_IOS_Longrise.pch"

@interface TakePhoneTypeViewController : PublicViewController<UIAlertViewDelegate>{
    //当前处理步骤 1 ，2 ，3
    int step;
    UIAlertView *alert1;
    UIAlertView *alert2;
}
//当前类型 0:新增 1:历史
@property(nonatomic,assign) int currentMark;
//事故类型，1:单车，2:多车
@property(nonatomic,assign) int type;



//报案号
@property(nonatomic,copy) NSString *appcaseno;
@property (weak, nonatomic) IBOutlet UIButton *takePhoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *identifiedResbtn;
@property (weak, nonatomic) IBOutlet UIButton *reportCaseBtn;


@property (weak, nonatomic) IBOutlet UILabel *takePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *identifiedResLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportCaseLabel;
@end
