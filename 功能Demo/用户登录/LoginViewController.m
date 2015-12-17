//
//  LoginViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/20.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPW;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户登录";
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.userName becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.userName resignFirstResponder];
    [self.userPW resignFirstResponder];
}



- (IBAction)loginBtn:(id)sender {
    
    [self.userName resignFirstResponder];
    [self.userPW resignFirstResponder];
    
    //检测手机号是否正确,用的工厂方法
    if ([Common CheckIsTelNum:self.userName.text] == NO) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"请输入正确的手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    //。。。
    //登录密码验证
    if (self.userPW.text.length == 0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"请输入密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    if ([Common CheckIsIncludeNumAndWord:self.userPW.text] == NO) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"请输入正确格式的密码" message:nil delegate:nil
        cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    
    //加载数据风火轮
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //把参数赋值到字典
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setObject:self.userName.text forKey:@"username"];
    [dic setObject:self.userPW.text forKey:@"pwd"];
    [dic setObject:[NSNumber numberWithInt:1003] forKey:@"cmd"];
    
    //Post请求登录数据
    
    [HttpTool Post:ProvideCommonServerURL Params:dic UseCache:YES HttpHeaderToken:SignCode Success:^(id json) {
        
        NSLog(@"%@",json);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
        //初始化用户模型
        g_user_model = nil;
        g_user_model = [[UserModel alloc] init];
        
        //验证用户ID和用户名
        g_user_model.userID = [json cy_stringKey:@"userid"];
        g_user_model.userName = [json cy_stringKey:@"username"];
        
        //持久保存用的登录的信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:g_sign_code forKey:@"SignCode"];
        [defaults setObject:g_user_model.userID forKey:@"UserID"];
        
        [defaults synchronize];
        
        

        

        
        
    } Failure:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",error] message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [av show];
    
    }];
    
    
}



@end
