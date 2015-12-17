//
//  Model.h
//  功能Demo
//
//  Created by 123 on 15/10/19.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import <Foundation/Foundation.h>



//用户数据模型
@interface UserModel : NSObject

@property (nonatomic, copy) NSString *userID;//用户的ID

@property (nonatomic, copy) NSString *userName;//用户名

@end

//[{"goodId":"1","goodName":"商品1","givePoint":1000,"imgUrl":"imgurl"}]},"RetCode":0,"RetDese":"成功"

//商品数据模型
@interface goodsAllModel : NSObject

@property (nonatomic, strong) NSString *goodName;//商品名字

@property (nonatomic, strong) NSString *goodID;//商品点击量

@property (nonatomic) int goodgivePoint;//商品点击数

@property (nonatomic, copy) NSString *goodimgUrl;//商品图片URL

@end

//文章数据模型
@interface ArticleModel : NSObject

@property (nonatomic, strong) NSString *title;//文章标题

@end
