//
//  BaseNavigationViewController.m
//  PovertyAlleviation
//
//  Created by 四川三君科技有限公司 on 2017/2/20.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = TABBARTITLE_COLOR;
    self.navigationBar.tintColor=[UIColor whiteColor];
//    self.navigationBarHidden = YES;
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];

//    self.navigationBar.translucent = YES;
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    // viewController.hidesBottomBarWhenPushed = YES; //隐藏底部标签栏
    
    [super pushViewController:viewController animated:animated];
    
    [self.visibleViewController.navigationItem setHidesBackButton:YES];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    [button setImage:[UIImage imageNamed:@"标题栏返回键1白"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 25)];
    
    button.backgroundColor=[UIColor clearColor];
    [button addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ba=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.visibleViewController.navigationItem.leftBarButtonItem = ba;
    
}

-(UIBarButtonItem*) createBackButton

{
    
    return [[UIBarButtonItem alloc]
            
            initWithTitle:@"返回"
            
            style:UIBarButtonItemStylePlain
            
            target:self 
            
            action:@selector(popself)];
    
}

-(void)popself

{
    
    [self popViewControllerAnimated:YES];
    
}

@end
