//
//  PassDataViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/22.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "PassDataViewController.h"
#import "PassData1ViewController.h"

@interface PassDataViewController ()

@property (weak, nonatomic) IBOutlet UILabel *passByValue;
@end

@implementation PassDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:@"changValueNotification" object:nil];
    
}

- (void)changeValue:(NSNotification *)notification
{
    NSDictionary *dictValue = [notification userInfo];
    self.passByValue.text = [dictValue objectForKey:@"value"];
    
}

- (IBAction)showSecond:(id)sender {
    PassData1ViewController *passData1 = [[PassData1ViewController alloc] initWithNibName:@"PassData1ViewController" bundle:nil];
    passData1.delegate = self;
    [self presentViewController:passData1 animated:YES completion:nil];
}
- (IBAction)showValueWithBlock:(id)sender {
    
    PassData1ViewController *passData1 = [[PassData1ViewController alloc] initWithNibName:@"PassData1ViewController" bundle:nil];
    [self presentViewController:passData1 animated:YES completion:nil];
    passData1.block = ^(NSString *value){
        
        self.passByValue.text = value;};
}

- (void)showValue:(NSString *)value
{
    self.passByValue.text = value;
}

@end
