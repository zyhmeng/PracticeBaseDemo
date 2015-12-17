//
//  MainViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/20.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "ListViewController.h"
#import "GoodListTableViewController.h"
#import "UploadViewController.h"
#import "DuiHuanTableViewController.h"
#import "JumpViewController.h"
#import "PassDataViewController.h"
#import "FMDBViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong)NSArray *cellData;

@end

@implementation MainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"返回";
}

- (NSArray *)cellData
{
    if (!_cellData) {
        _cellData = @[@"用户登录",@"商品列表",@"上传图片",@"用户分享",@"商品兑换",@"页面跳转",@"页面传值",@"FMDB"];
    }
    return _cellData;
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cellData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    //cell的重用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    cell.textLabel.text = self.cellData[indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //根据点击切换控制器
    if (indexPath.row == 0) {
        
        LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:YES];
     }
//    if (indexPath.row == 1) {
//        ListViewController *listVC = [[ListViewController alloc]initWithNibName:@"ListViewController" bundle:nil];
//        [self.navigationController pushViewController:listVC animated:YES];
//     }
    if (indexPath.row == 1) {
        GoodListTableViewController *goodVC = [[GoodListTableViewController alloc] initWithNibName:@"GoodListTableViewController" bundle:nil];
        [self.navigationController pushViewController:goodVC animated:YES];
    }
    if (indexPath.row == 2) {
        UploadViewController *uploadVC = [[UploadViewController alloc] initWithNibName:@"UploadViewController" bundle:nil];
        [self.navigationController pushViewController:uploadVC animated:YES];
        
        
    }
    if (indexPath.row == 3) {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"562650f267e58e7324004d57"
                                          shareText:@"你要分享的文字"
                                         shareImage:[UIImage imageNamed:@"icon.png"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                           delegate:self];
        
    }
    if (indexPath.row == 4) {
        DuiHuanTableViewController *duiHuanVC = [[DuiHuanTableViewController alloc] init];
        [self.navigationController pushViewController:duiHuanVC animated:YES];
    }
    if (indexPath.row == 5) {
        JumpViewController *jump = [[JumpViewController alloc] init];
        [self.navigationController pushViewController:jump animated:YES];
    }
    if (indexPath.row == 6) {
        PassDataViewController *passData = [[PassDataViewController alloc] init];
        [self.navigationController pushViewController:passData animated:YES];
    }
    if (indexPath.row == 7) {
        FMDBViewController *fmdb = [[FMDBViewController alloc] init];
        [self.navigationController pushViewController:fmdb animated:YES];
    }
}

@end
