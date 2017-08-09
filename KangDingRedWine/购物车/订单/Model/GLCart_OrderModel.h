//
//  GLCart_OrderModel.h
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/9.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLCart_OrderModel : NSObject

@property (nonatomic, copy)NSString *discount;//价格

@property (nonatomic, copy)NSString *goods_id;//id

@property (nonatomic, copy)NSString *goods_info;//描述

@property (nonatomic, copy)NSString *goods_name;//名字

@property (nonatomic, copy)NSString *goods_num;//数量

@property (nonatomic, copy)NSString *goods_type;//类型  1复消商品 2酒券商品

@property (nonatomic, copy)NSString *thumb;//图片

@end
