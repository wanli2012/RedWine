//
//  shopingModel.h
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shopingModel : NSObject

@property (nonatomic, assign)BOOL isSelect;//是否被选

@property (nonatomic, copy)NSString *info;// 介绍

@property (nonatomic, copy)NSString *cart_id;//购物车id

@property (nonatomic, copy)NSString *goods_id;//商品ID

@property (nonatomic, copy)NSString *thumb;//图片

@property (nonatomic, copy)NSString *num;//数量

@property (nonatomic, copy)NSString *goods_price;//价格

@property (nonatomic, copy)NSString *goods_name;//商品名字

@property (nonatomic, copy)NSString *goods_type;//类型  1复消商品 2酒券商品


@end
