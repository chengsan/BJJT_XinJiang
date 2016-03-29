//
//  MakeAppointmentController.h
//  CZT_IOS_Longrise
//
//  Created by OSch on 16/1/21.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface MakeAppointmentController : PublicViewController
//案件号
@property (copy, nonatomic) NSString *appcaseno;

@property (copy, nonatomic) NSString *currentMark; //是否从历史案件进来的

@property (weak, nonatomic) IBOutlet UIScrollView *backScollView;

//电话号码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
//当事人姓名
@property (weak, nonatomic) IBOutlet UITextField *concernName;

//网点下拉的View
@property (weak, nonatomic) IBOutlet UIView *brancesView;

//预约时间
@property (weak, nonatomic) IBOutlet UIButton *timeSelectBtn;


//预约说明
@property (weak, nonatomic) IBOutlet UITextView *describText;

//上传预约button
@property (weak, nonatomic) IBOutlet UIButton *upAppointBtn;

@end
