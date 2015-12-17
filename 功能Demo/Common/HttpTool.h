//
//  HttpTool.h
//  功能Demo
//
//  Created by 123 on 15/10/20.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import <Foundation/Foundation.h>

// 封装上传文件的数据模型
@interface FormData : NSObject

@property (nonatomic, strong) NSData *fileData;//上传的文件数据
@property (nonatomic, copy) NSString *fileName;//上传的文件名字
@property(nonatomic,copy)NSString * name;//参数名
@property(nonatomic,copy)NSString * fileType;//文件类型


@end

@interface HttpTool : NSObject


/**
 *  发送一个GET请求
 *
 *  @param url      请求路径
 *  @param params   请求参数
 *  @param useCache 是否需要缓存
 *  @param httpHeaderToken http头验证
 *  @param success  请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure  请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)Get:(NSString *)url Params:(NSDictionary *)params UseCache:(BOOL)useCache HttpHeaderToken:(NSString *)httpHeaderToken Success:(void (^) (id json))success Failure:(void (^) (NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url      请求路径
 *  @param params   请求参数
 *  @param useCache 是否需要缓存
 *  @param httpHeaderToken http头验证
 *  @param success  请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure  请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)Post:(NSString *)url Params:(NSDictionary *)params UseCache:(BOOL)useCache HttpHeaderToken:(NSString *)httpHeaderToken Success:(void (^) (id json))success Failure:(void (^) (NSError *error))failure;


/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData 文件参数 需传入fileData fileName(xxx.jpg)
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 *  @param percent 请求中的回调（上传完成百分比）
*/

+ (void)Upload:(NSString *)url Params:(NSDictionary *)params DataSource:(FormData *)dataSource Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure Progress:(void(^)(float percent))percent;

@end
