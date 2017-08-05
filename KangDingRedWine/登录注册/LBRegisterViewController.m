//
//  LBRegisterViewController.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBRegisterViewController.h"

@interface LBRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *yzmTf;
@property (weak, nonatomic) IBOutlet UITextField *secretTf;
@property (weak, nonatomic) IBOutlet UITextField *ensureTf;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *submitbt;

@end

@implementation LBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

- (IBAction)tapgestureback:(UITapGestureRecognizer *)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}
//获取验证码
- (IBAction)getCode:(UIButton *)sender {
}
//提交
- (IBAction)submitEvent:(UIButton *)sender {
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.secretTf && [string isEqualToString:@"\n"]) {
        [self.ensureTf becomeFirstResponder];
        return NO;
        
    }else if (textField == self.ensureTf && [string isEqualToString:@"\n"]){
        
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
    
    self.submitbt.layer.borderWidth = 1;
    self.submitbt.layer.borderColor = [UIColor whiteColor].CGColor;
    self.submitbt.layer.cornerRadius = 22.5;
    self.submitbt.clipsToBounds = YES;
    
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
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}



@end
