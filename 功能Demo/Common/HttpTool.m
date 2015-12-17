//
//  HttpTool.m
//  功能Demo
//
//  Created by 123 on 15/10/20.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "HttpTool.h"


@implementation HttpTool
+(void)Get:(NSString *)url Params:(NSDictionary *)params UseCache:(BOOL)useCache HttpHeaderToken:(NSString*)httpHeaderToken Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure
{
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    // 1.获得请求管理者
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr.requestSerializer setValue:httpHeaderToken forHTTPHeaderField:HttpHeaderFieldName];
    
    // 2.发送GET请求
    [mgr setSecurityPolicy:policy];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success([Common GetResponseData:responseObj]);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             
             failure(error);
             
         }
     }];
}

+(void)Post:(NSString *)url Params:(NSDictionary *)params UseCache:(BOOL)useCache HttpHeaderToken:(NSString*)httpHeaderToken Success:(void (^)(id json))success Failure:(void (^)(NSString *error))failure
{
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr setSecurityPolicy:policy];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //http头验证
    [mgr.requestSerializer setValue:httpHeaderToken forHTTPHeaderField:HttpHeaderFieldName];
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSLog(@"%@",responseObj);
          if ([Common IsRequestSuccess:responseObj]) {
              if ([[Common GetResponseData:responseObj]isKindOfClass:[NSNull class]]==YES) {
                  success(responseObj);
              }else
                  success ([Common GetResponseData:responseObj]);
          }else
              failure([Common GetResponseMSG:responseObj]);
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure([NSString stringWithFormat:@"%@",error]);
          }
      }];
}

/**
 *  上传文件请求
 */
+ (void)Upload:(NSString *)url Params:(NSDictionary *)params DataSource:(FormData *)dataSource Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure Progress:(void(^)(float percent))percent
{
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation= [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:dataSource.fileData name:dataSource.name fileName:dataSource.fileName mimeType:dataSource.fileType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            success([jsonString JSONObject]);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        
        
        if (percent) {
            
            float f_precent=(float)totalBytesWritten/totalBytesExpectedToWrite;
            
            percent( f_precent);
            
        }
    }];
    
    // 5. Begin!
    [operation start];
    
}
@end

@implementation FormData : NSObject



@end
