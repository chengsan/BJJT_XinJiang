//
//  TakeResponsePhotoViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/20.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "CarTypeViewController.h"
#import "CZT_IOS_Longrise.pch"

@interface TakeResponsePhotoViewController : CarTypeViewController<TakePhotoViewControllerDelegate>{
    //临时按钮对象
    UIButton *tempBtn;
    //临时照片对象
    UIImage *tempImage;
    //照片类型
    int shoottype;
}

@property (copy, nonatomic)NSString *dampicoverd;  //定损是否完成
@property (copy, nonatomic)NSString *currentMark;  //判断是否从历史记录进来的

@property (strong, nonatomic)NSArray *responsePhotoArray;   //放置从历史记录进来的时候已照的照片

@property (weak, nonatomic) IBOutlet UIScrollView *bacScrollView;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (weak, nonatomic) IBOutlet UIButton *imageBtn1;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn2;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn3;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn4;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn5;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn6;




@end
