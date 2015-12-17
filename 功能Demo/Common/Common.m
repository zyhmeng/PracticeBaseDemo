//
//  Common.m
//  功能Demo
//
//  Created by 123 on 15/10/20.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "Common.h"

@implementation Common
+(BOOL)IsRequestSuccess:(id)response_object
{
    if ([[[response_object objectForKey:@"RetCode"] stringValue]isEqualToString:@"0"]==YES) {
        return YES;
    }else if ([[[response_object objectForKey:@"RetCode"] stringValue]isEqualToString:@"0"]==NO)
    {
        return NO;
    }else
        return NO;
}

+(NSString *)GetResponseMSG:(id)response_object
{
    return [response_object objectForKey:@"RetDese"];
}

+(id)GetResponseData:(id)response_object
{
    return [response_object objectForKey:@"result"];
}

+(BOOL)CheckIsTelNum:(NSString *)str
{
    if ([str length] == 0) {
        
        return NO;
    }
    
    //NSString *regex = @"^((13[0-9])|(147)|(170)|(15[^4,\\D])|(18[0,2,5-9]))\\d{8}$";
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}

+(BOOL)CheckIsIncludeNumAndWord:(NSString *)str
{
    
    NSString *testString = str;
    
    int alength = [testString length];
    
    BOOL b_return=YES;
    for (int i = 0; i<alength; i++) {
        char commitChar = [testString characterAtIndex:i];
        NSString *temp = [testString substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            NSLog(@"字符串中含有中文");
            b_return=NO;
            return b_return;
        }else if((commitChar>64)&&(commitChar<91)){
            NSLog(@"字符串中含有大写英文字母");
        }else if((commitChar>96)&&(commitChar<123)){
            NSLog(@"字符串中含有小写英文字母");
        }else if((commitChar>47)&&(commitChar<58)){
            NSLog(@"字符串中含有数字");
        }else{
            NSLog(@"字符串中含有非法字符");
            b_return=NO;
            return b_return;
        }
    }
    return b_return;
    
}

//+(void)SetNav:(UINavigationBar *)bar
//{
//    bar.barTintColor=NAV_COLOR;
//    bar.alpha=1;
//    
//    [bar setTranslucent:NO];
//    
//    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
//                                  NSFontAttributeName:[UIFont systemFontOfSize:18]
//                                  }];
//    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//}

+(void)DrowLineAtImageView:(UIImageView *)image_view StartPoint:(CGPoint )line_start_pt EndPoint:(CGPoint )line_end_pt Color:(UIColor *)line_color LineWidth:(float)line_width
{
    
    UIGraphicsBeginImageContext(image_view.frame.size);
    [image_view.image drawInRect:CGRectMake(0, 0, image_view.frame.size.width, image_view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), line_width);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    
    
    const CGFloat *components = CGColorGetComponents(line_color.CGColor);
    NSLog(@"Red: %f", components[0]);
    NSLog(@"Green: %f", components[1]);
    NSLog(@"Blue: %f", components[2]);
    
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), components[0], components[1], components[2], 1.0);  //颜色
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), line_start_pt.x, line_start_pt.y);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), line_end_pt.x, line_end_pt.y);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    image_view.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}


+(NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    
    
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: destDate];
    
    NSDate *localeDate = [destDate  dateByAddingTimeInterval: interval];
    
    
    
    
    return localeDate;
    
}

+(BOOL)myString:(NSString *)string ContainsString:(NSString*)other {
    NSRange range = [string rangeOfString:other];
    return range.length != 0;
}

+(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [Common fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
}

+(MJRefreshGifHeader*)AddGifHeaderAndLoadDataFinished:(void (^)())finished
{
    NSMutableArray *Arr=[[NSMutableArray alloc]init];
    for (int i=1; i<=35; i++) {
        
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"mty%d",i]];
    UIImage *image = [UIImage imageNamed:@"mty1"];
        [Arr addObject:image];
        
        [Arr addObject:image];
    }
    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        finished();
        
    }];
    // 设置普通状态的动画图片
    [header setImages:Arr forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:Arr forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:Arr duration:1.0 forState:MJRefreshStateRefreshing];
    //     设置header
    
    return header;
    
}

/*
 密码不能为空 请重新输入
 不能有非法字符
 请输入至少6位英文及数字密码
 两次密码输入不一致 请重新输入
 */
+(BOOL)CheckPWByOnce:(NSString *)OncePW TwicePW:(NSString *)TwicePW
{
    NSString *msg=@"";
    if (OncePW.length==0||TwicePW.length==0) {
        msg=@"密码不能为空 请重新输入";
        
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"密码不能为空 请重新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return NO;
    }
    
    if ([self CheckIsIncludeNumAndWord:OncePW]==NO||[self CheckIsIncludeNumAndWord:TwicePW]==NO) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"密码不能有中文字符 请重新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return NO;
    }
    
    if (OncePW.length<6||OncePW.length>16 ||TwicePW.length<6||TwicePW.length>16) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"密码长度应6-16位 请重新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return NO;
    }
    
    if ([OncePW isEqualToString:TwicePW]==NO) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"密码两次输入不一致 请重新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return NO;
    }
    return YES;
}



//+(NSMutableArray *)GetAreaList{
//    
//    NSMutableArray *listArr=[[NSMutableArray alloc]init];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
//    [dic setObject: [NSNumber numberWithInt:9501]forKey:@"cmd"];
//    
//    
//    [HttpTool Post:ProvideCommonServerURL Params:dic UseCache:YES HttpHeaderToken:g_sign_code Success:^(id json) {
//    
//        
//        
//        
//        [listArr removeAllObjects];
//        
//        NSArray *array=[json objectForKey:@"list"];
//        for (NSDictionary *Dic in array) {
//            AreaModel *model=[[AreaModel alloc] init];
//            
//            model.areaId=[Dic cy_stringKey:@"areaId"];
//            model.areaName=[Dic objectForKey:@"areaName"];
//            [listArr addObject:model];
//        }
//        
//        
//    } Failure:^(NSString *error) {
//        
//        
//    }];
//    
//    
//    return listArr;
//}


@end
