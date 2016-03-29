//
//  TralierTableViewCell.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/25.
//  Copyright © 2016年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TralierModel;

@protocol TralierTableViewCellDelegate<NSObject>

-(void)callWithPhoneNumber:(NSString *)number;

@end

@interface TralierTableViewCell : UITableViewCell
@property (nonatomic, copy) NSString *servicetel;  //电话号码

@property (nonatomic,strong)TralierModel *model;

@property (weak, nonatomic) IBOutlet UILabel *InternetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressWarnLabel;


@property (assign, nonatomic) id <TralierTableViewCellDelegate>delegate;

@end
