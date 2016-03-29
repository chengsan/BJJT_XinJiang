//
//  XJHistoryViewController.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 16/1/15.
//  Copyright (c) 2016年 程三. All rights reserved.
//  新疆历史入口

#import "PublicViewController.h"

@interface XJHistoryViewController : PublicViewController{
    //临时照片对象
    UIImage *tempImage;
    //照片类型
    int shoottype;
}
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (nonatomic,copy) NSString *appcaseno; //选中cell的案件号
@property (nonatomic,copy) NSString *acctype;   //选中cell的案件类型
@property (nonatomic,copy) NSString *photoType; //选中cell的拍摄类型

@end
