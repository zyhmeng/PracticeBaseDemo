//
//  PassData1ViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/22.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "PassData1ViewController.h"

@interface PassData1ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation PassData1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)passDataWithDelegate:(id)sender {
    if (self.textField.text.length == 0) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"请输入字符" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else
    {
        [self.delegate showValue:self.textField.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (IBAction)block:(id)sender {
    
    if (self.textField.text.length == 0) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"请输入字符" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else
    {
        if (self.block) {
            self.block(self.textField.text);
            }
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (IBAction)notification:(id)sender {
    
    if (self.textField.text.length == 0) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"请输入字符" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changValueNotification" object:self userInfo:@{@"value":self.textField.text}];
        [self dismissViewControllerAnimated:YES completion:nil];
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
