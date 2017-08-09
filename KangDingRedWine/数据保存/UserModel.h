//
//  UserModel.h
//  813DeepBreathing
//
//  Created by rimi on 15/8/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>
@property (nonatomic, assign) BOOL needAutoLogin;

@property (nonatomic, assign)BOOL   loginstatus;//登陆状态

@property (nonatomic, copy)NSString  *token;//token 校验码
@property (nonatomic, copy)NSString  *uid;//用户uid
@property (nonatomic, copy)NSString  *IDCard;
@property (nonatomic, copy)NSString  *address;
@property (nonatomic, copy)NSString  *banknumber;
@property (nonatomic, copy)NSString  *group_id;
@property (nonatomic, copy)NSString  *group_name;
@property (nonatomic, copy)NSString  *isBqInfo;
@property (nonatomic, copy)NSString  *mark;
@property (nonatomic, copy)NSString  *openbank;
@property (nonatomic, copy)NSString  *phone;
@property (nonatomic, copy)NSString  *pic;
@property (nonatomic, copy)NSString  *price;
@property (nonatomic, copy)NSString  *qtIdNum;
@property (nonatomic, copy)NSString  *recNumber;
@property (nonatomic, copy)NSString  *recommendID;
@property (nonatomic, copy)NSString  *recommendUser;
@property (nonatomic, copy)NSString  *truename;
@property (nonatomic, copy)NSString  *username;
@property (nonatomic, copy)NSString  *version;

+(UserModel*)defaultUser;

@end
