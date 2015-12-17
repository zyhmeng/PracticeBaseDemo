//
//  GoodListTableViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/21.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "GoodListTableViewController.h"


@interface GoodListTableViewController ()

@property (nonatomic) int pageNum;

@end

@implementation GoodListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 0;
    
    self.dataArr = [[NSMutableArray alloc] init];
    
    //上拉加载
    [self pullUpLoading];
    
    //下拉刷新
    [self PullDownRefresh];
    
    //拼接参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"1" forKey:@"modId"];
    [dict setObject:@"1" forKey:@"articleType"];
    [dict setObject:[NSNumber numberWithInt:self.pageNum] forKey:@"pageNo"];
    [dict setObject: [NSNumber numberWithInt:8512]forKey:@"cmd"];
    [HttpTool Post:ProvideCommonServerURL Params:dict UseCache:YES HttpHeaderToken:g_sign_code Success:^(id json) {
        
        
        NSArray *array=[json objectForKey:@"list"];
        
        for (NSDictionary *Dic in array) {
            goodsAllModel *model=[[goodsAllModel alloc] init];
            
            model.goodName = [Dic objectForKey:@"title"];
            
            
            [self.dataArr addObject:model];
            
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error) {
        
        [self.tableView.footer endRefreshing];
    }];



    
    
}
//下拉刷新
- (void)PullDownRefresh
{
    self.tableView.header = [Common AddGifHeaderAndLoadDataFinished:^{
        [(MJRefreshNormalHeader *)self.tableView.header setTitle:@"点击或者下拉刷新" forState:MJRefreshStateIdle];
        self.pageNum = 0;
        //拼接参数
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"1" forKey:@"modId"];
        [dict setObject:@"1" forKey:@"articleType"];
        [dict setObject:[NSNumber numberWithInt:self.pageNum] forKey:@"pageNo"];
        [dict setObject: [NSNumber numberWithInt:8512]forKey:@"cmd"];
        [HttpTool Post:ProvideCommonServerURL Params:dict UseCache:YES HttpHeaderToken:g_sign_code Success:^(id json) {
            
            
            NSArray *array=[json objectForKey:@"list"];
            
            for (NSDictionary *Dic in array) {
                goodsAllModel *model=[[goodsAllModel alloc] init];
                
                model.goodName = [Dic objectForKey:@"title"];
                
                
                [self.dataArr addObject:model];
                
                [self.tableView reloadData];
                
                [self.tableView.header endRefreshing];
            }
        } Failure:^(NSError *error) {
            
            [self.tableView.footer endRefreshing];
        }];

        
    }];
}


//上拉加载
- (void)pullUpLoading
{
    [(MJRefreshAutoNormalFooter *)self.tableView.footer setTitle:@"点击或者上拉加载" forState:MJRefreshStateIdle];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.pageNum++;
        
        
        //拼接参数
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"1" forKey:@"modId"];
        [dict setObject:@"1" forKey:@"articleType"];
        [dict setObject:[NSNumber numberWithInt:self.pageNum] forKey:@"pageNo"];
        [dict setObject: [NSNumber numberWithInt:8512]forKey:@"cmd"];
        [HttpTool Post:ProvideCommonServerURL Params:dict UseCache:YES HttpHeaderToken:g_sign_code Success:^(id json) {
            
            NSArray *array=[json objectForKey:@"list"];
            
            //判断还有没有数据
            if (array.count == 0) {
                [(MJRefreshAutoNormalFooter *)self.tableView.footer setTitle:@"已经是最后一页" forState:MJRefreshStateIdle];
                
            }

            for (NSDictionary *Dic in array) {
                goodsAllModel *model=[[goodsAllModel alloc] init];
                
                model.goodName = [Dic objectForKey:@"title"];
                
                
                [self.dataArr addObject:model];
                
                [self.tableView reloadData];
                
                [self.tableView.footer endRefreshing];
            }
        } Failure:^(NSError *error) {
            
            [self.tableView.footer endRefreshing];
        }];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"goodlist";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    goodsAllModel *model = [self.dataArr objectAtIndex:indexPath.row];
   
    cell.textLabel.text = model.goodName;
    
    return cell;
}



@end
