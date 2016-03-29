//
//  XJHistoryTableViewself.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/21.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "XJHistoryTableViewCell.h"
#import "XJHistoryModel.h"

@implementation XJHistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(XJHistoryModel *)model{
    _model = model;

    //判断案件车辆类型
    if ([model.acctype isEqualToString:@"1"]) {
        self.acctypeLabel.text = @"单车";
        
    }else if([model.acctype isEqualToString:@"2"]){
        self.acctypeLabel.text = @"双车";
    }
    
    //判断案件状态
    if ([model.type isEqualToString:@"1"]) {
        
        self.caseStateLabel.text = @"取证未完成";
        self.caseStateLabel.textColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:15/255.0 alpha:1.0];
    }else if ([model.type isEqualToString:@"2"]){
        
        self.caseStateLabel.text = @"未预约";
        self.caseStateLabel.textColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:15/255.0 alpha:1.0];
    }else if ([model.type isEqualToString:@"3"]){
        
        self.caseStateLabel.text = @"预约成功";
        self.caseStateLabel.textColor = [UIColor colorWithRed:107/255.0 green:220/255.0 blue:91/255.0 alpha:1.0];
    }
    
    //判断定损是否完成
    if ([model.dampicoverd isEqualToString:@"1"]) {
        self.responseLabel.text = @"(已完成)";
        [self.responseTakePhotoBtn setTitle:@"补拍照片" forState:UIControlStateNormal];
    }else{
        self.responseLabel.text = @"(未完成)";
        [self.currentTakePhotoBtn setTitle:@"继续拍照" forState:UIControlStateNormal];
    }
    
    //判断现场拍照是否完成
    if ([model.scepicoverd isEqualToString:@"1"]) {
        self.currentLabel.text = @"(已完成)";
        [self.currentTakePhotoBtn setTitle:@"补拍照片" forState:UIControlStateNormal];
    }else{
        self.currentLabel.text = @"(未完成)";
        [self.currentTakePhotoBtn setTitle:@"继续拍照" forState:UIControlStateNormal];
    }
    
    //判断是否预约
    if ([model.isbespeak isEqualToString:@"1"]) {
        self.appointmentLabel.text = @"(已完成)";
        [self.goToAppointmentBtn setTitle:@"已预约" forState:UIControlStateNormal];
    }else{
        self.appointmentLabel.text = @"(未完成)";
        [self.goToAppointmentBtn setTitle:@"去预约" forState:UIControlStateNormal];
    }
    
    //案件发生时间
    self.accidentTimeLabel.text = model.scebegintime;

}

//cell上三个按钮的点击事件
- (IBAction)btnClicked:(UIButton *)sender {
    
    if (sender == _currentBtn) {
        
        [_delegate pushNextViewControllerWith:@"1" and:_model];
        
    }else if (sender == _responsBtn){
        
        [_delegate pushNextViewControllerWith:@"2" and:_model];
    }else if (sender == _appointmentBtn){
        
        [_delegate pushNextViewControllerWith:@"3" and:_model];
        
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
