//
//  BasetabbarViewController.m
//  PovertyAlleviation
//
//  Created by 四川三君科技有限公司 on 2017/2/20.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "BasetabbarViewController.h"
#import "BaseNavigationViewController.h"
#import "GLHomePageController.h"
#import "GLMineController.h"
#import "GLHome_AllClassifyController.h"
#import "GLShoppingCartController.h"

@interface BasetabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation BasetabbarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor=TABBARTITLE_COLOR;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBar.barTintColor = TABBARTITLE_COLOR;
    self.delegate=self;
    [self addViewControllers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(refreshInterface) name:@"refreshInterface" object:nil];
    
}

- (void)addViewControllers {
    
    //主页
    GLHomePageController *homeVC = [[GLHomePageController alloc] init];
    BaseNavigationViewController *homeNav = [[BaseNavigationViewController alloc] initWithRootViewController:homeVC];
    homeNav.tabBarItem = [self barTitle:@"首页" image:@"首页白" selectImage:@"首页"];
    
    //分类
    GLHome_AllClassifyController *classifyVC = [[GLHome_AllClassifyController alloc] init];
    BaseNavigationViewController *classifyNav = [[BaseNavigationViewController alloc] initWithRootViewController:classifyVC];
    classifyNav.tabBarItem = [self barTitle:@"分类" image:@"分类白" selectImage:@"分类"];
    
    //购物车
    GLShoppingCartController *cartVC = [[GLShoppingCartController alloc] init];
    BaseNavigationViewController *cartNav = [[BaseNavigationViewController alloc] initWithRootViewController:cartVC];
    cartNav.tabBarItem = [self barTitle:@"购物车" image:@"购物车白" selectImage:@"购物车"];
    
    //个人中心
    GLMineController *mineVC = [[GLMineController alloc] init];
    BaseNavigationViewController *mineNav = [[BaseNavigationViewController alloc] initWithRootViewController:mineVC];
    mineNav.tabBarItem = [self barTitle:@"我的" image:@"个人白" selectImage:@"个人"];
    
//    if ([UserModel defaultUser].loginstatus == YES) {//登录状态
//        if ([[UserModel defaultUser].group_id isEqualToString:MANAGER] || [[UserModel defaultUser].group_id isEqualToString:DIRECTOR] || [[UserModel defaultUser].group_id isEqualToString:MINISTER]) {//经理
//
//            self.viewControllers = @[mineNav];
//
//        }else if ([[UserModel defaultUser].group_id isEqualToString:Retailer] || [[UserModel defaultUser].group_id isEqualToString:OrdinaryUser]|| [[UserModel defaultUser].group_id isEqualToString:TWODELEGATE]){//商家
//            self.viewControllers = @[mallNav,uploadNav,mineNav];
//        }else{
//            self.viewControllers = @[mallNav,mineNav];
//        }
//    }else{//退出状态
        self.viewControllers = @[homeNav,classifyNav,cartNav,mineNav];
//    }
//
//    self.selectedIndex=0;
    
}

- (UITabBarItem *)barTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    UITabBarItem *item = [[UITabBarItem alloc] init];
    
    item.title = title;
    item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    item.titlePositionAdjustment = UIOffsetMake(0, -4);
    return item;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
//    int index;
//    if ([[UserModel defaultUser].group_id isEqualToString:OrdinaryUser] || [[UserModel defaultUser].group_id isEqualToString:Retailer] ) {
//        
//        index = 2;
//        
//    }else if ([[UserModel defaultUser].group_id isEqualToString:MANAGER] || [[UserModel defaultUser].group_id isEqualToString:DIRECTOR]|| [[UserModel defaultUser].group_id isEqualToString:MINISTER]){
//        
//        index = 0;
//        
//    }else if ( [UserModel defaultUser].group_id == nil || [[UserModel defaultUser].group_id integerValue] == 0){
//        
//        index = 1;
//        
//    }else{
//        
//        index = 1;
//        
//    }
//    if (viewController == [tabBarController.viewControllers objectAtIndex:index]) {
//
//        if ([UserModel defaultUser].loginstatus == YES) {
//            
//            if ([[UserModel defaultUser].isBqInfo integerValue] == 0) {
//                
//                GLCompleteInfoController *infoVC = [[GLCompleteInfoController alloc] init];
//                infoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//                [self presentViewController:infoVC animated:YES completion:nil];
//                
//                return NO;
//            }
//            return YES;
//        }
//        
//        GLLoginController *loginVC = [[GLLoginController alloc] init];
//        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
//        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:nav animated:YES completion:nil];
//        return NO;
//
//    }

    return YES;
}
//刷新界面
-(void)refreshInterface{
    
    [self.viewControllers reverseObjectEnumerator];
    
    [self addViewControllers];

}

- (void)pushToHome{
    
     self.selectedIndex = 0;
}

@end
