//
//  GLHome_GoodsCommentModel.h
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/10.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLHome_GoodsCommentModel : NSObject

@property (nonatomic, copy)NSString *comment;//评论内容

@property (nonatomic, copy)NSString *pic;//头像

@property (nonatomic, copy)NSString *user_name;//用户ID

@property (nonatomic, copy)NSString *is_reply;//商家是否回复

@property (nonatomic, copy)NSString *reply;//商家回复

@property (nonatomic, copy)NSString *uid;//用户UID

@end
