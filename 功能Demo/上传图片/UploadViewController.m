//
//  UploadViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/21.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "UploadViewController.h"
#import "HttpTool.h"

@interface UploadViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *ProgressView;



@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FormData *formData = [[FormData alloc] init];

    
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"mty1"], 1);
    formData.fileData = data;
    formData.fileName = @"mty1.png";
    formData.name = @"mty1.png";
    formData.fileType = @"mty1.png";

    [HttpTool Upload:UploadServerURL Params:nil DataSource:formData Success:^(id json) {
        
        NSLog(@"%@",json);
        
    } Failure:^(NSError *error) {
        
    } Progress:^(float percent) {
        NSLog(@"%f",percent);
        
        [self.ProgressView setProgress:percent animated:YES];
    }];
}



@end
