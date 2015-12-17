//
//  Jump1ViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/21.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "Jump1ViewController.h"
#import "JumpViewController.h"


@interface Jump1ViewController ()

@end

@implementation Jump1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"页面2";
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pop:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
