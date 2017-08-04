//
//  GLMine_BankCardBlindingController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_BankCardBlindingController.h"

@interface GLMine_BankCardBlindingController ()

@property (weak, nonatomic) IBOutlet UITextField *bankCardTF;
@property (weak, nonatomic) IBOutlet UIView *bankStyleView;
@property (weak, nonatomic) IBOutlet UITextField *branchTF;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;

@end

@implementation GLMine_BankCardBlindingController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bankCardTF.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bankCardTF.layer.borderWidth = 1.f;
    self.bankStyleView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bankStyleView.layer.borderWidth = 1.f;
    self.branchTF.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.branchTF.layer.borderWidth = 1.f;
    
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    self.contentViewHeight.constant = kSCREEN_HEIGHT - 64;
}

//是否同意协议
- (IBAction)isAgree:(id)sender {
    NSLog(@"点钟了协议");
}

//选择银行
- (IBAction)chooseBank:(id)sender {
    NSLog(@"选择银行");
}


@end
