//
//  GLHome_AgentCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_AgentCell.h"

@interface GLHome_AgentCell ()

@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation GLHome_AgentCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.titleView.layer.cornerRadius = 15;
    
}

@end
