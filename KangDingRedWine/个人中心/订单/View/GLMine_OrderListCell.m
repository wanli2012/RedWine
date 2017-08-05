//
//  GLMine_OrderListCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_OrderListCell.h"

@interface GLMine_OrderListCell ()

@property (weak, nonatomic) IBOutlet UIButton *payNowBtn;

@end

@implementation GLMine_OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.payNowBtn.layer.borderWidth = 1.f;
    self.payNowBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    
}

@end
