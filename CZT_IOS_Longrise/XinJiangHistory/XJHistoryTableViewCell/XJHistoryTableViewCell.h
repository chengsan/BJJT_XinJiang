//
//  XJHistoryTableViewCell.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/21.
//  Copyright © 2016年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XJHistoryModel;

@protocol XJHistoryTableViewCellDelegate <NSObject>

-(void)pushNextViewControllerWith:(NSString *)state and:(XJHistoryModel *)historyModel;

@end

@interface XJHistoryTableViewCell : UITableViewCell
@property (nonatomic, strong)XJHistoryModel *model;

@property (weak, nonatomic) IBOutlet UIButton *currentTakePhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *responseTakePhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *goToAppointmentBtn;


@property (weak, nonatomic) IBOutlet UILabel *acctypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *caseStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *accidentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointmentLabel;

@property (weak, nonatomic) IBOutlet UIButton *currentBtn;
@property (weak, nonatomic) IBOutlet UIButton *responsBtn;
@property (weak, nonatomic) IBOutlet UIButton *appointmentBtn;


@property (assign,nonatomic)id <XJHistoryTableViewCellDelegate>delegate;

@end
