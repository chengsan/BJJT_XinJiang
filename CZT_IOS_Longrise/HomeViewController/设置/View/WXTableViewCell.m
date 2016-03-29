//
//  WXTableViewCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/9.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "WXTableViewCell.h"
#import "AppDelegate.h"

@implementation WXTableViewCell

-(void)setUIWithInfo:(CarModel *)model{
    
    self.license.text = model.carno;
    self.carUseage.text = model.usertype;
    self.carModel.text = model.brandtype;
    self.carType.text = model.cartype;
    
}


// 健康档案点击事件 上海，新疆的不存在
- (IBAction)btnClicked:(id)sender {
    [_delegate pushToNextViewControllerWith:_CellCarNo];
}

//车辆验证点击事件  上海，新疆的不存在
- (IBAction)varifyBtnClicked:(id)sender {
    [_delegate pushToNextViewControllerWith:_CellCarNo and:_VINCode and:_engineNumber and:_isApprove];
}

- (void)awakeFromNib {
    // Initialization code
    [AppDelegate storyBoradAutoLay:self];
    self.carVarifyStateButton.layer.masksToBounds = YES;
    self.carVarifyStateButton.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
