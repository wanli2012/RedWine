//
//  LBWineDonationVoucherViewController.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/7.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBWineDonationVoucherViewController.h"

@interface LBWineDonationVoucherViewController ()

@property (weak, nonatomic) IBOutlet UIView *protcolView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *numView;
@property (weak, nonatomic) IBOutlet UIButton *backBt;
@property (weak, nonatomic) IBOutlet UIButton *donationBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentH;
@property (strong, nonatomic)UIButton *buttonedt;

@end

@implementation LBWineDonationVoucherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"酒券转赠";
    
    _buttonedt=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 60)];
    [_buttonedt setImage:[UIImage imageNamed:@"总类"] forState:UIControlStateNormal];
    [_buttonedt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    
    [_buttonedt addTarget:self action:@selector(edtingInfo) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_buttonedt];
    
}

-(void)edtingInfo{
    
}

//阅读协议
- (IBAction)readProtcol:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}
//确认转赠
- (IBAction)ApplyForRepurchase:(UIButton *)sender {
    
}
//申请回购
- (IBAction)DonationToOthers:(UIButton *)sender {
    
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    self.backBt.layer.cornerRadius = 4;
    self.backBt.clipsToBounds = YES;
    
    self.donationBt.layer.cornerRadius = 4;
    self.donationBt.clipsToBounds = YES;
    
    self.phoneView.layer.borderWidth = 1;
    self.phoneView.layer.borderColor = YYSRGBColor(121, 120, 120, 1).CGColor;
    
    self.numView.layer.borderWidth = 1;
    self.numView.layer.borderColor = YYSRGBColor(121, 120, 120, 1).CGColor;
    
    self.protcolView.layer.borderWidth = 1;
    self.protcolView.layer.borderColor = YYSRGBColor(121, 120, 120, 1).CGColor;
    
    self.contentW.constant =  kSCREEN_WIDTH;
    self.contentH.constant =  700;
    
}



@end
