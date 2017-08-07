//
//  GLMine_DonationListCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_DonationListCell.h"

@interface GLMine_DonationListCell ()

@property (weak, nonatomic) IBOutlet UIView *reasonView;
@property (weak, nonatomic) IBOutlet UIView *openReasonView;
@property (weak, nonatomic) IBOutlet UIView *closeReasonView;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;

@end

@implementation GLMine_DonationListCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showReason)];
    [self.openReasonView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeReason)];
    [self.closeReasonView addGestureRecognizer:tap1];
    
    self.openBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_4);
   
}

//展示原因
- (void)showReason{
    
    self.reasonView.frame = CGRectMake(kSCREEN_WIDTH, 0, kSCREEN_WIDTH - 50, 50);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.reasonView.hidden = NO;
        self.reasonView.frame = CGRectMake(50, 0, kSCREEN_WIDTH - 50, 50);
        
    }];
    
}

//收起原因
- (void)closeReason{

    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.reasonView.hidden = NO;
        self.reasonView.frame = CGRectMake(kSCREEN_WIDTH, 0, kSCREEN_WIDTH - 50, 50);
        
    }];
}

@end
