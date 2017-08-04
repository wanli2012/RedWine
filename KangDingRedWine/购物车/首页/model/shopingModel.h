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

@property (nonatomic, copy)NSString *imagev;//图片

@property (nonatomic, copy)NSString *info;// 介绍

@property (nonatomic, copy)NSString *price;//价格

@property (nonatomic, copy)NSString *num;//数量

@end
