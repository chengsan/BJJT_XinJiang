//
//  TralierServiceViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/19.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "CZT_IOS_Longrise.pch"
#import "TralierServiceViewController.h"
#import "TralierTableViewCell.h"
#import "TralierModel.h"


@interface TralierServiceViewController ()<UITableViewDelegate,UITableViewDataSource,TralierTableViewCellDelegate,UIAlertViewDelegate>{
    
    NSMutableArray *dataList;
    UIAlertView *phoneCallAlertView;
    FVCustomAlertView *FVAlertView;
}

@end

@implementation TralierServiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
        //self.isShowController = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拖车服务";
    [_tralierTableView registerNib:[UINib nibWithNibName:@"TralierTableViewCell" bundle:nil] forCellReuseIdentifier:@"tralierCell"];
    _page = 1;
    dataList = [NSMutableArray array];
    [self addRefresh];  //添加下拉刷新，上拉加载更多
    
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 添加下拉刷新，上拉加载更多
-(void)addRefresh{
    __block TralierServiceViewController * blockSelf = self;
    _tralierTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [blockSelf.tralierTableView.mj_header endRefreshing];
        });
    }];
    
    _tralierTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreTralierList];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [blockSelf.tralierTableView.mj_footer endRefreshing];
        });
        
        
    }];

}

#pragma mark - 请求数据
-(void)requestData{
    
    FVAlertView = [[FVCustomAlertView alloc] init];
    [FVAlertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:FVAlertView];
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSString *token = bigDic[@"token"];
    NSDictionary *userDic = bigDic[@"userinfo"];
    NSString *userflag = userDic[@"userflag"];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pagenum"];
    [bean setValue:userflag forKey:@"username"];
    [bean setValue:token forKey:@"password"];
    
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/xjtrailerservice",kckpxjapprest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        NSDictionary *bigDic = result;
        if (nil != bigDic) {
          
            if ([bigDic[@"restate"]isEqualToString:@"0"]) {
                
                if (![bigDic[@"data"]isEqual:@""]) {
                    
                    NSArray *dataArray = bigDic[@"data"];
                    for (NSDictionary *dic in dataArray) {
                        TralierModel *model = [[TralierModel alloc]initWithDictionary:dic];
                        [dataList addObject:model];
                    }
                    [_tralierTableView reloadData];
                    
                }else{
                    
                    [self showAlertView:@"未查询到更多数据!"];
                    
                }
                
            }else{
                
                [self showAlertView:bigDic[@"redes"]];
                
            }
            
        }else{
            
            [self showAlertView:@"请检查网络是否连接!"];
        }
        [FVAlertView dismiss];
        
    }];
}

#pragma mark - 下拉刷新
-(void)refreshData{
    _page = 1;
    [dataList removeAllObjects];
    [self requestData];
    
}

#pragma mark - 上拉加载更多
-(void)loadMoreTralierList{
    _page++;
    [self requestData];
    
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TralierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tralierCell" forIndexPath:indexPath];
    cell.delegate = self;
    if (dataList.count > indexPath.row) {
        TralierModel *model = dataList[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

//cell的代理方法
-(void)callWithPhoneNumber:(NSString *)number{
    
    NSString *str = [NSString stringWithFormat:@"您要拨打%@吗?",number];
    _phoneNumber = number;
    phoneCallAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [phoneCallAlertView show];
}



#pragma mark - 提示
-(void)showAlertView:(NSString *)notice
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:notice delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == phoneCallAlertView) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phoneNumber]]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
