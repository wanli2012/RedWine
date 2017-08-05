//
//  LBForgetSecretViewController.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBForgetSecretViewController.h"

@interface LBForgetSecretViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentH;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *yzmTf;
@property (weak, nonatomic) IBOutlet UITextField *secretTf;
@property (weak, nonatomic) IBOutlet UITextField *ensureTf;
@property (weak, nonatomic) IBOutlet UITextField *recommendTf;
@property (weak, nonatomic) IBOutlet UITextField *qtID;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *registerBt;

@end

@implementation LBForgetSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}
//返回
- (IBAction)backevent:(UITapGestureRecognizer *)sender {
     [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    
}
//查看注册协议
- (IBAction)checkXieyi:(UITapGestureRecognizer *)sender {
}
//选中协议
- (IBAction)selectEvent:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}
//获取验证码
- (IBAction)getcode:(UIButton *)sender {
}
//点击注册
- (IBAction)clickRegister:(UIButton *)sender {
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.secretTf && [string isEqualToString:@"\n"]) {
        [self.ensureTf becomeFirstResponder];
        return NO;
        
    }else if (textField == self.ensureTf && [string isEqualToString:@"\n"]){
        
       [self.recommendTf becomeFirstResponder];
        return NO;
    }else if (textField == self.recommendTf && [string isEqualToString:@"\n"]){
        
        [self.qtID becomeFirstResponder];
        return NO;
    }else if (textField == self.qtID && [string isEqualToString:@"\n"]){
        
        [self.view endEditing:YES];
        return NO;
    }
    
    if (textField == self.phoneTf ) {
        
        for(int i=0; i< [string length];i++){
            
            int a = [string characterAtIndex:i];
            
            if( a >= 0x4e00 && a <= 0x9fff)
                
                return NO;
        }
    }
    
    return YES;
    
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.registerBt.layer.borderWidth = 1;
    self.registerBt.layer.borderColor = [UIColor whiteColor].CGColor;
    self.registerBt.layer.cornerRadius = 22.5;
    self.registerBt.clipsToBounds = YES;
    
    self.codeBt.layer.cornerRadius = 4;
    self.codeBt.clipsToBounds = YES;
    
    [self.phoneTf setValue:YYSRGBColor(168, 168, 168, 1)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTf setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    
    [self.secretTf setValue:YYSRGBColor(168, 168, 168, 1)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.secretTf setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    
    [self.ensureTf setValue:YYSRGBColor(168, 168, 168, 1)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.ensureTf setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    
    [self.yzmTf setValue:YYSRGBColor(168, 168, 168, 1)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.yzmTf setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    
    [self.recommendTf setValue:YYSRGBColor(168, 168, 168, 1)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.recommendTf setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    
    [self.qtID setValue:YYSRGBColor(168, 168, 168, 1)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.qtID setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    
    self.contentW.constant = kSCREEN_WIDTH;
    self.contentH.constant = 640;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
@end
