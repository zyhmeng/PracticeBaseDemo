//
//  ListViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/20.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "ListViewController.h"
#import "ListCellViewController.h"


@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    int pageNum;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //上拉加载
    [self uploadData];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    
    self.navigationItem.title = @"商品列表";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

//上拉加载
- (void)uploadData
{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        pageNum++;
        
        //拼接参数
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"1" forKey:@"modId"];
        [dict setObject:@"1" forKey:@"articleType"];
        [dict setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNo"];
        [dict setObject: [NSNumber numberWithInt:8512]forKey:@"cmd"];
        [HttpTool Post:ProvideCommonServerURL Params:dict UseCache:YES HttpHeaderToken:g_sign_code Success:^(id json) {
            NSArray *array=[json objectForKey:@"list"];
            
            
            //判断还有没有数据
            if (array.count==0) {
                [(MJRefreshAutoNormalFooter *)self.tableView.footer setTitle:@"已经是最后一页" forState:MJRefreshStateIdle];
            }
            for (NSDictionary *dict in array) {
                goodsAllModel *model = [[goodsAllModel alloc]init];
                model.goodName = [dict objectForKey:@"goodName"];
                model.goodID = [dict objectForKey:@"goodID"];
                
                model.goodimgUrl = [dict cy_stringKey:@"goodimgUrl"];
                
                model.goodgivePoint = [[dict objectForKey:@"goodgivePoint"]intValue];
                [self.dataArray addObject:model];
                
                [self.tableView reloadData];
                
                
                //结束刷新
                [self.tableView.footer endRefreshing];
            }
  
        } Failure:^(NSError *error) {
            [self.tableView.footer endRefreshing];
        }];
    }];
    
}





#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark - UITableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[ListCellViewController alloc]init];
        }
//    goodsAllModel *model = [self.dataArray objectAtIndex:[indexPath row]];
//    goodsAllModel *model = [self.dataArray objectAtIndex:[indexPath.row]];
    goodsAllModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.goodName.text = model.goodName;
    cell.givePoint.text = [NSString stringWithFormat:@"%d",model.goodgivePoint];
    [cell.imgUrl sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ResHeaderURL,model.goodimgUrl]]];
    NSLog(@"%@",cell.goodName.text);
    
    return cell;
}








@end
