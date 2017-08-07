//
//  GLHome_AllClassifyController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/31.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_AllClassifyController.h"
#import "GLHome_AgentController.h"
#import "GLHome_ReSellingMallController.h"
#import "GLHome_PersonCustomController.h"
#import "GLHome_ExchangeController.h"

@interface GLHome_AllClassifyController ()

@property (strong, nonatomic)UIButton *buttonedt;

@end

@implementation GLHome_AllClassifyController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addviewcontrol];
    [self selectTagByIndex:0 animated:YES];
    
}

- (IBAction)back:(id)sender {
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

//重载init方法
- (instancetype)init
{
    if (self = [super initWithTagViewHeight:45])
    {
        self.yFloat = 64;
        self.bottomDistance = 49;
    }
    
    return self;
}

-(void)addviewcontrol{
    
    //设置自定义属性
    self.tagItemSize = CGSizeMake(kSCREEN_WIDTH / 4, 45);
    
    NSArray *titleArray = @[
                            @"购买代理",
                            @"复消商城",
                            @"私人定制",
                            @"酒劵兑换"
                            ];

    NSArray *classNames = @[
                            [GLHome_AgentController class],
                            [GLHome_ReSellingMallController class],
                            [GLHome_PersonCustomController class],
                            [GLHome_ExchangeController class]
                            ];
    self.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    self.normalTitleColor = [UIColor whiteColor];
    
    self.selectedTitleColor = YYSRGBColor(255, 50, 50, 1);//红色
    
    self.selectedIndicatorColor = YYSRGBColor(255, 50, 50, 1);
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:nil];
    
}

@end
