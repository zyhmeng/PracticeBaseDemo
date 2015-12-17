//
//  JumpViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/21.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "JumpViewController.h"
#import "Jump1ViewController.h"

@interface JumpViewController ()

@end

@implementation JumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"页面1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Push:(id)sender {
    Jump1ViewController *jump1 = [[Jump1ViewController alloc] init];
    [self.navigationController pushViewController:jump1 animated:YES];
}
- (IBAction)Modal:(id)sender {
    Jump1ViewController *jump1 = [[Jump1ViewController alloc] init];
    [self presentViewController:jump1 animated:YES completion:nil];
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
