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
@property (weak, nonatomic) IBOutlet UIView *bankCardView;
@property (weak, nonatomic) IBOutlet UIView *branchView;

@property (weak, nonatomic) IBOutlet UIButton *identificateBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;

@property (nonatomic, assign)BOOL isAgreeProtocol;
@property (weak, nonatomic) IBOutlet UIImageView *protocolImageV;

@end

@implementation GLMine_BankCardBlindingController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"银行卡绑定";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.bankStyleView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bankStyleView.layer.borderWidth = 1.f;
    self.bankCardView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bankCardView.layer.borderWidth = 1.f;
    self.branchView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.branchView.layer.borderWidth = 1.f;
    
    self.identificateBtn.layer.cornerRadius = 5.f;
    
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    self.contentViewHeight.constant = kSCREEN_HEIGHT - 64;
    
}

//是否同意协议

- (IBAction)isAgree:(id)sender {
    
    self.isAgreeProtocol = !self.isAgreeProtocol;
    
    if (self.isAgreeProtocol) {
        
        self.protocolImageV.image = [UIImage imageNamed:@"选中{协议）"];
        
    }else{
        
        self.protocolImageV.image = [UIImage imageNamed:@"未选择（协议）"];
        
    }
}

//选择银行
- (IBAction)chooseBank:(id)sender {
    NSLog(@"选择银行");
}
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.bankCardTF && [string isEqualToString:@"\n"]) {
        
        [self.branchTF becomeFirstResponder];
        
        return NO;
        
    }else if(textField == self.branchTF && [string isEqualToString:@"\n"]){
        
        [self.branchTF resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
}


@end
