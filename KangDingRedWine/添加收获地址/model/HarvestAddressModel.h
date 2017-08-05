//
//  HarvestAddressModel.h
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HarvestAddressModel : NSObject

@property (nonatomic, assign)BOOL isSelect;//是否设为默认

@property (nonatomic, copy)NSString *name;//姓名

@property (nonatomic, copy)NSString *phone;// 电话

@property (nonatomic, copy)NSString *address;//地址

@end
