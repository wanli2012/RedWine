//
//  GLHome_ResellingEnsurelCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/1.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_ResellingEnsurelCell.h"

@implementation GLHome_ResellingEnsurelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)ensureClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(ensure)]) {
        [self.delegate ensure];
    }
    
}

@end
