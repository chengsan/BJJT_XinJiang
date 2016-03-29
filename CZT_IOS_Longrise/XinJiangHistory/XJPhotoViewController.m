//
//  XJPhotoViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/22.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "XJPhotoViewController.h"
#import "AccidentPhotoTableViewCell.h"
#import <BJJT_Lib/UIImageView+WebCache.h>

@interface XJPhotoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSDictionary *dic;
}

@end

@implementation XJPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_photoTableView registerNib:[UINib nibWithNibName:@"AccidentPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"photoCell"];
    
    if (_sceneDataArray.count > 0) {
        
        self.title = @"现场拍照";
        
    }else if(_asswssDataArray){
        
        self.title = @"定损拍照";
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_sceneDataArray.count > 0) {
        
        return _sceneDataArray.count;
        
    }else if (_asswssDataArray.count > 0){
        
        return _asswssDataArray.count;
    }else{
        
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccidentPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell" forIndexPath:indexPath];
    if (_sceneDataArray.count > indexPath.row) {
        dic = _sceneDataArray[indexPath.row];
    }else if (_asswssDataArray.count > indexPath.row){
        dic = _asswssDataArray[indexPath.row];
    }
    //加载图片
    [cell.carPhotoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imageurl"]]placeholderImage:[UIImage imageNamed:@"loadingPhoto"]];
    if ([dic[@"imagetypename"]isEqual:@""]) {
        cell.photoLocationLabel.text = @"其它定损照片";
    }else{
        cell.photoLocationLabel.text = dic[@"imagetypename"];
    }
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
