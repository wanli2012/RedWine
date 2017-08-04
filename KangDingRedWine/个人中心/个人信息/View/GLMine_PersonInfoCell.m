//
//  GLMine_PersonInfoCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_PersonInfoCell.h"

@implementation GLMine_PersonInfoCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.imageV.layer.cornerRadius = 25;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * autoSizeScaleX];
    self.detailLabel.font = [UIFont systemFontOfSize:15 * autoSizeScaleX];
    
}


@end
