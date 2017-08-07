//
//  AppDelegate.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/24.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "BasetabbarViewController.h"
#import "BaseNavigationViewController.h"
#import "GLHomePageController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BasetabbarViewController *tab = [[BasetabbarViewController alloc] init];
    
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
