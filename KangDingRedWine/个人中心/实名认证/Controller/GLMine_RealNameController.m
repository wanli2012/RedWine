//
//  GLMine_RealNameController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_RealNameController.h"

@interface GLMine_RealNameController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;


@property (nonatomic, assign)BOOL isAgreeProtocol;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *IDCardNumTF;

@end

@implementation GLMine_RealNameController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.isAgreeProtocol = NO;
    
    self.navigationItem.title = @"实名认证";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentViewHeight.constant = kSCREEN_HEIGHT - 64;
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    
    self.applyBtn.layer.cornerRadius = 5.f;
    
}

//是否同意协议
- (IBAction)isAgreeProtocol:(id)sender {
    
    self.isAgreeProtocol = !self.isAgreeProtocol;
    
    if (self.isAgreeProtocol) {
        self.imageV.image = [UIImage imageNamed:@"选中{协议）"];
    }else{
        self.imageV.image = [UIImage imageNamed:@"未选择（协议）"];
    }
    
}

//申请认证
- (IBAction)applyIdentification:(id)sender {
    
    NSLog(@"申请认证");
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.nameTF && [string isEqualToString:@"\n"]) {
        
        [self.IDCardNumTF becomeFirstResponder];
        return NO;
        
    }else if(textField == self.IDCardNumTF && [string isEqualToString:@"\n"]){
        
        [self.IDCardNumTF resignFirstResponder];
        return NO;
        
    }
    
    return YES;
}


@end
