//
//  GLShoppingCart_OrderController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLShoppingCart_OrderController.h"

@interface GLShoppingCart_OrderController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@end

@implementation GLShoppingCart_OrderController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"确认订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    self.contentViewHeight.constant = kSCREEN_HEIGHT - 64;
    
}

@end
