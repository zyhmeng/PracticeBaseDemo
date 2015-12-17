//
//  PassData1ViewController.h
//  功能Demo
//
//  Created by 123 on 15/10/22.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol secondViewDelegate

-(void)showValue:(NSString *)value;

@end
typedef void (^ablock) (NSString *value);

@interface PassData1ViewController : UIViewController

@property (nonatomic, weak)id<secondViewDelegate> delegate;

@property (nonatomic, copy) ablock block;
@end
