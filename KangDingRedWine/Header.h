//
//  Header.h
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define YYSRGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define TABBARTITLE_COLOR YYSRGBColor(15, 15,  15, 1.0) //导航栏颜色

#define autoSizeScaleX (kSCREEN_WIDTH/320.f)
#define autoSizeScaleY (kSCREEN_HEIGHT/568.f)

///接口

#define URL_Base @"http://192.168.0.191/CMcard/index.php/App/"

#define PlaceHolderImage @"picnodata"
#define LUNBO_PlaceHolder @"banner"
#define kGOODS_PlaceHolder @"产品占位图"

//分享
#define SHARE_URL @"http://dzgx.joshuaweb.cn/index.php/Home/Regist/index.html?mod=member&act=register&username="
#define UMSHARE_APPKEY @"58cf31dcf29d982906001f63"
//微信分享
#define WEIXI_APPKEY @"wxf482af02a200da8e"
#define WEIXI_SECRET @"487532cd8355a7ae06f44d5abe2486ba"
//微博分享
#define WEIBO_APPKEY @"3040295141"
#define WEIBO_SECRET @"3e3728b874c9f207cefb043cf418e6a4"
//友盟分享 AppKey
#define USHARE_DEMO_APPKEY @"594b286765b6d607f3000f9a"



#define NMUBERS @"0123456789./*-+~!@#$%^&()_+-=,./;'[]{}:<>?`"


#endif /* Header_h */
