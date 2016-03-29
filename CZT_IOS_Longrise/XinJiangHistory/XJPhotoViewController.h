//
//  XJPhotoViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/22.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface XJPhotoViewController : PublicViewController

@property (weak, nonatomic) IBOutlet UITableView *photoTableView;

@property (strong,nonatomic)NSMutableArray *sceneDataArray;

@property (strong,nonatomic)NSMutableArray *asswssDataArray;

@end
