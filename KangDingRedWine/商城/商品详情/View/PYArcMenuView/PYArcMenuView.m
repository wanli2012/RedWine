//
//  PYArcMenuView.m
//  PYArcMenuView
//
//  Created by 杨鹏 on 15/12/22.
//  Copyright © 2015年 mtxc. All rights reserved.
//

#import "PYArcMenuView.h"

// 默认开关按钮中心距屏幕边缘的距离
#define DEFAULT_LAYOUT_MARGIN 50
// 默认开关按钮的宽和高
#define DEFAULT_BUTTON_SWITCH_WIDTH 50
#define DEFAULT_BUTTON_SWITCH_HEIGHT 50
// 默认开关按钮图标
#define DEFAULT_BUTTON_IMAGE [UIImage imageNamed:@"购物车1"]
// 默认菜单项按钮的宽和高
#define DEFAULT_BUTTON_ITEM_WIDTH 40
#define DEFAULT_BUTTON_ITEM_HEIGHT 40
// 默认菜单项容量
#define DEFAULT_CAPACITY 3
// 默认菜单半径
#define DEFAULT_MENU_RADIUS 80
// 默认菜单展开动画时长
#define DEFAULT_MENU_EXPAND_INTERVAL 0.3f
// 默认菜单展开动画延迟
#define DEFAULT_MENU_EXPAND_DELAY 0.0f
// 默认按钮点击动画时长
#define DEFAULT_BUTTON_CLICK_INTERVAL 0.3f
// 默认按钮点击动画缩放比例
#define DEFAULT_BUTTON_CLICK_SCALE 1.5f
// GCD计算按钮位置线程队列的label
#define QUEUE_LABEL "com.mtxc.PYArcMenuView.CalculatePoints"

///////////////////////////////////////////////////////////////////////////////////

@interface PYArcMenuView () {
    dispatch_queue_t calculatePointsQueue;
}

@property (assign, nonatomic)PYArcMenuViewPosition position;
@property (assign, nonatomic)BOOL isExpand;
@property (strong, nonatomic)UIButton *btnSwitch;
@property (assign, nonatomic)CGPoint btnSwitchPoint;
@property (strong, nonatomic)NSMutableArray<UIButton *> *btnItems;
@property (strong, nonatomic)NSMutableArray<NSValue *> *btnItemPoints;

@end

///////////////////////////////////////////////////////////////////////////////////

@implementation PYArcMenuView

-(instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame withPosition:PYArcMenuViewPositionRightBottom withButtonImage:DEFAULT_BUTTON_IMAGE];
}

- (instancetype)initWithFrame:(CGRect)frame withPosition:(PYArcMenuViewPosition)position {
    return [self initWithFrame:frame withPosition:position withButtonImage:DEFAULT_BUTTON_IMAGE];
}

- (instancetype)initWithFrame:(CGRect)frame withPosition:(PYArcMenuViewPosition)position withButtonImage:(UIImage *)image {
    self = [super initWithFrame:frame];
    if(self) {
        
        // 初始化参数
        self.position = position;
        self.isExpand = false;
        calculatePointsQueue = dispatch_queue_create(QUEUE_LABEL, NULL);
        self.layoutMargin = DEFAULT_LAYOUT_MARGIN;
        self.buttonSwitchWidth = DEFAULT_BUTTON_SWITCH_WIDTH;
        self.buttonSwitchHeight = DEFAULT_BUTTON_SWITCH_HEIGHT;
        self.buttonItemWidth = DEFAULT_BUTTON_ITEM_WIDTH;
        self.buttonItemHeight = DEFAULT_BUTTON_ITEM_HEIGHT;
        self.menuRadius = DEFAULT_MENU_RADIUS;
        self.menuExpandInterval = DEFAULT_MENU_EXPAND_INTERVAL;
        self.menuExpandDelay =  DEFAULT_MENU_EXPAND_DELAY;
        self.buttonClickInterval = DEFAULT_BUTTON_CLICK_INTERVAL;
        self.buttonClickScale = DEFAULT_BUTTON_CLICK_SCALE;
        
        // 根据所选位置添加开关按钮
        switch (self.position) {
            case PYArcMenuViewPositionLeftTop:
                self.btnSwitchPoint = CGPointMake(self.layoutMargin, self.layoutMargin);
                break;
            case PYArcMenuViewPositionRightTop:
                self.btnSwitchPoint = CGPointMake(self.bounds.size.width-self.layoutMargin, self.layoutMargin);
                break;
            case PYArcMenuViewPositionLeftBottom:
                self.btnSwitchPoint = CGPointMake(self.layoutMargin, self.bounds.size.height-self.layoutMargin);
                break;
            case PYArcMenuViewPositionRightBottom:
                self.btnSwitchPoint = CGPointMake(self.bounds.size.width-self.layoutMargin, self.bounds.size.height-self.layoutMargin);
                break;
            default:
                self.btnSwitchPoint = CGPointMake(self.bounds.size.width-self.layoutMargin, self.bounds.size.height-self.layoutMargin);
                break;
        }
        
        CGRect btnFrame = CGRectMake(self.btnSwitchPoint.x-self.buttonSwitchWidth/2, self.btnSwitchPoint.y-self.buttonSwitchHeight/2, self.buttonSwitchWidth, self.buttonSwitchHeight);
        self.btnSwitch = [[UIButton alloc] initWithFrame:btnFrame];
        [self.btnSwitch setImage:image forState:UIControlStateNormal];
        [self.btnSwitch addTarget:self action:@selector(switchTheArcMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSwitch];
        self.btnItems = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
        self.btnItemPoints = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
    }
    return self;
}

#pragma mark - 折叠或展开菜单
- (void)switchTheArcMenu:(UIButton *)sender {
    self.isExpand = !self.isExpand;
    if (self.isExpand) {
        // 将要展开菜单
        [self.delegate PYArcMenuWillExpand:self];
        for (int i=0; i<self.btnItems.count; i++){
            UIButton *btnTemp = [self.btnItems objectAtIndex:i];
            [UIView animateWithDuration:self.menuExpandInterval delay:self.menuExpandDelay*i options:UIViewAnimationOptionCurveLinear animations:^{
                btnTemp.center = [[self.btnItemPoints objectAtIndex:i] CGPointValue];
            } completion:nil];
        }
    } else {
        // 将要折叠菜单
        [self.delegate PYArcMenuWillUnExpand:self];
        for (int i=0; i<self.btnItems.count; i++){
            UIButton *btnTemp = [self.btnItems objectAtIndex:i];
            [UIView animateWithDuration:self.menuExpandInterval delay:self.menuExpandDelay*(self.btnItems.count-i-1) options:UIViewAnimationOptionCurveLinear animations:^{
                btnTemp.center = self.btnSwitchPoint;
            } completion:nil];
        }
    }
    [self startClickAnimationOfButton:self.btnSwitch];
}

#pragma mark - 点击菜单项按钮
- (void)clickMenuItem:(UIButton *)sender {
    for (int i=0; i<self.btnItems.count; i++) {
        if (self.btnItems[i] == sender) {
            [self.delegate PYArcMenuView:self didSelectedForIndex:i];
            break;
        }
    }
}

#pragma mark - 添加菜单项按钮
- (void)addMenuItemWithUIImage:(UIImage *)image {
    if (self.isExpand) {
        // 如果当前是展开状态
        /////////////////////////////////////////////////////////////////////
    }else {
        // 如果当前是折叠状态
        UIButton *btnTemp = [[UIButton alloc] initWithFrame:CGRectMake(self.btnSwitchPoint.x-self.buttonItemWidth/2, self.btnSwitchPoint.y-self.buttonItemHeight/2, self.buttonItemWidth, self.buttonItemHeight)];
        [btnTemp setImage:image forState:UIControlStateNormal];
        [btnTemp addTarget:self action:@selector(clickMenuItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnItems addObject:btnTemp];
        [self.btnItemPoints addObject:[NSValue valueWithCGPoint:self.btnSwitchPoint]];
        [self addSubview:btnTemp];
        [self bringSubviewToFront:self.btnSwitch];
        // 在另外一个线程中计算MenuItem展开后的point
        dispatch_async(calculatePointsQueue, ^{
            [self calculateMenuItemPoints];
        });
    }
}

#pragma mark - 批量添加菜单项按钮
- (void)addMenuItemsWithUIImages:(NSArray<UIImage *> *)images {
    if (self.isExpand) {
        // 如果当前是展开状态
        //////////////////////////////////////////////////////////////////////
    }else {
        // 如果当前是折叠状态
        for (UIImage *image in images) {
            UIButton *btnTemp = [[UIButton alloc] initWithFrame:CGRectMake(self.btnSwitchPoint.x-self.buttonItemWidth/2, self.btnSwitchPoint.y-self.buttonItemHeight/2, self.buttonItemWidth, self.buttonItemHeight)];
            [btnTemp setImage:image forState:UIControlStateNormal];
            [btnTemp addTarget:self action:@selector(clickMenuItem:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnItems addObject:btnTemp];
            [self.btnItemPoints addObject:[NSValue valueWithCGPoint:self.btnSwitchPoint]];
            [self addSubview:btnTemp];
        }
        [self bringSubviewToFront:self.btnSwitch];
        // 在另外一个线程中计算MenuItem展开后的point
        dispatch_async(calculatePointsQueue, ^{
            [self calculateMenuItemPoints];
        });
    }
}

#pragma mark - 计算MenuItem展开后所在的位置
- (void)calculateMenuItemPoints {
    switch (self.position) {
        case PYArcMenuViewPositionLeftTop:
            for (int i=0; i<self.btnItems.count; i++){
                CGFloat offsetX;
                CGFloat offsetY;
                if (i==0) {
                    offsetX = self.menuRadius;
                    offsetY = 0;
                } else {
                    offsetX = self.menuRadius * cos(M_PI_2/(self.btnItems.count-1)*i);
                    offsetY = self.menuRadius * sin(M_PI_2/(self.btnItems.count-1)*i);
                }
                CGPoint pointTemp = CGPointMake(self.btnSwitchPoint.x+offsetX, self.btnSwitchPoint.y+offsetY);
                NSValue *valueTemp = [NSValue valueWithCGPoint:pointTemp];
                [self.btnItemPoints replaceObjectAtIndex:i withObject:valueTemp];
            }
            break;
        case PYArcMenuViewPositionRightTop:
            for (int i=0; i<self.btnItems.count; i++){
                CGFloat offsetX;
                CGFloat offsetY;
                if (i==0) {
                    offsetX = self.menuRadius;
                    offsetY = 0;
                } else {
                    offsetX = self.menuRadius * cos(M_PI_2/(self.btnItems.count-1)*i);
                    offsetY = self.menuRadius * sin(M_PI_2/(self.btnItems.count-1)*i);
                }
                CGPoint pointTemp = CGPointMake(self.btnSwitchPoint.x-offsetX, self.btnSwitchPoint.y+offsetY);
                NSValue *valueTemp = [NSValue valueWithCGPoint:pointTemp];
                [self.btnItemPoints replaceObjectAtIndex:i withObject:valueTemp];
            }
            break;
        case PYArcMenuViewPositionLeftBottom:
            for (int i=0; i<self.btnItems.count; i++){
                CGFloat offsetX;
                CGFloat offsetY;
                if (i==0) {
                    offsetX = self.menuRadius;
                    offsetY = 0;
                } else {
                    offsetX = self.menuRadius * cos(M_PI_2/(self.btnItems.count-1)*i);
                    offsetY = self.menuRadius * sin(M_PI_2/(self.btnItems.count-1)*i);
                }
                CGPoint pointTemp = CGPointMake(self.btnSwitchPoint.x+offsetX, self.btnSwitchPoint.y-offsetY);
                NSValue *valueTemp = [NSValue valueWithCGPoint:pointTemp];
                [self.btnItemPoints replaceObjectAtIndex:i withObject:valueTemp];
            }
            break;
        case PYArcMenuViewPositionRightBottom:
            for (int i=0; i<self.btnItems.count; i++){
                CGFloat offsetX;
                CGFloat offsetY;
                if (i==0) {
                    offsetX = self.menuRadius;
                    offsetY = 0;
                } else {
                    offsetX = self.menuRadius * cos(M_PI_2/(self.btnItems.count-1)*i);
                    offsetY = self.menuRadius * sin(M_PI_2/(self.btnItems.count-1)*i);
//                    offsetX = self.menuRadius;
//                    offsetY = 0;
                }
                CGPoint pointTemp = CGPointMake(self.btnSwitchPoint.x-offsetX, self.btnSwitchPoint.y-offsetY);
                NSValue *valueTemp = [NSValue valueWithCGPoint:pointTemp];
                [self.btnItemPoints replaceObjectAtIndex:i withObject:valueTemp];
            }
            break;
        default:
            for (int i=0; i<self.btnItems.count; i++){
                CGFloat offsetX;
                CGFloat offsetY;
                if (i==0) {
                    offsetX = self.menuRadius;
                    offsetY = 0;
                } else {
                    offsetX = self.menuRadius * cos(M_PI_2/(self.btnItems.count-1)*i);
                    offsetY = self.menuRadius * sin(M_PI_2/(self.btnItems.count-1)*i);
                }
                CGPoint pointTemp = CGPointMake(self.btnSwitchPoint.x-offsetX, self.btnSwitchPoint.y-offsetY);
                NSValue *valueTemp = [NSValue valueWithCGPoint:pointTemp];
                [self.btnItemPoints replaceObjectAtIndex:i withObject:valueTemp];
            }
            break;
    }
}

#pragma mark - 播放点击按钮的动画
- (void)startClickAnimationOfButton:(UIButton *)btn {
    [UIView animateWithDuration:self.buttonClickInterval/2 animations:^{
        btn.transform = CGAffineTransformMakeScale(self.buttonClickScale, self.buttonClickScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:self.buttonClickInterval/2 animations:^{
            btn.transform = CGAffineTransformIdentity;
        }];
    }];
}

#pragma mark - 重写UIView的方法，保证没有按钮的地方事件可以穿透
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withUIView:self.btnSwitch]) {
        return YES;
    }
    for (UIButton *btn in self.btnItems) {
        if ([self pointInside:point withUIView:btn]){
            return YES;
        }
    }
    return NO;
}

#pragma mark - 判断点是否在控件内
- (BOOL)pointInside:(CGPoint)point withUIView:(UIView *)view {
    if (point.x >= view.frame.origin.x && point.x <= view.frame.origin.x+view.frame.size.width && point.y >= view.frame.origin.y && point.y <= view.frame.origin.y+view.frame.size.height) {
        return YES;
    }
    return NO;
}

@end
