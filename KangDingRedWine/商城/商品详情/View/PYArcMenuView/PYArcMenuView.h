//
//  PYArcMenuView.h
//  PYArcMenuView
//
//  Created by 杨鹏 on 15/12/22.
//  Copyright © 2015年 mtxc. All rights reserved.
//

#import <UIKit/UIKit.h>

// 菜单按钮所在位置的枚举类型
typedef enum {
    PYArcMenuViewPositionLeftTop,
    PYArcMenuViewPositionRightTop,
    PYArcMenuViewPositionLeftBottom,
    PYArcMenuViewPositionRightBottom
}PYArcMenuViewPosition;

///////////////////////////////////////////////////////////////////////////////////

@protocol PYArcMenuViewDelegate;

///////////////////////////////////////////////////////////////////////////////////

@interface PYArcMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame withPosition:(PYArcMenuViewPosition)position;
- (instancetype)initWithFrame:(CGRect)frame withPosition:(PYArcMenuViewPosition)position withButtonImage:(UIImage *)image;
- (void)addMenuItemWithUIImage:(UIImage *)image;
- (void)addMenuItemsWithUIImages:(NSArray<UIImage *> *)images;

@property (weak, nonatomic) id<PYArcMenuViewDelegate> delegate;
// 开关按钮中心距屏幕边缘的距离
@property (assign, nonatomic) CGFloat layoutMargin;
// 开关按钮的宽和高
@property (assign, nonatomic) CGFloat buttonSwitchWidth;
@property (assign, nonatomic) CGFloat buttonSwitchHeight;
// 菜单项按钮的宽和高
@property (assign, nonatomic) CGFloat buttonItemWidth;
@property (assign, nonatomic) CGFloat buttonItemHeight;
// 默认菜单半径
@property (assign, nonatomic) CGFloat menuRadius;
// 默认菜单展开动画时长
@property (assign, nonatomic) CGFloat menuExpandInterval;
// 默认菜单展开动画延迟
@property (assign, nonatomic) CGFloat menuExpandDelay;
// 默认按钮点击动画时长
@property (assign, nonatomic) CGFloat buttonClickInterval;
// 默认按钮点击动画缩放比例
@property (assign, nonatomic) CGFloat buttonClickScale;

@end

///////////////////////////////////////////////////////////////////////////////////

@protocol PYArcMenuViewDelegate <NSObject>

@optional
- (void)PYArcMenuWillExpand:(PYArcMenuView *)menu;
- (void)PYArcMenuWillUnExpand:(PYArcMenuView *)menu;
- (void)PYArcMenuView:(PYArcMenuView *)menu didSelectedForIndex:(NSInteger)index;

@end