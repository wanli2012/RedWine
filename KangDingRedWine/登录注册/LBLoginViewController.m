//
//  LBLoginViewController.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBLoginViewController.h"
#import "LBRegisterViewController.h"
#import "LBForgetSecretViewController.h"

@interface LBLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *secretTf;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;


@end

@implementation LBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}
//忘记密码
- (IBAction)forgetSecret:(UIButton *)sender {
    
    LBRegisterViewController *vc = [[LBRegisterViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
    
}
//快速注册
- (IBAction)fastlyRegister:(UIButton *)sender {
    
    LBForgetSecretViewController *vc = [[LBForgetSecretViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.phoneTf && [string isEqualToString:@"\n"]) {
        [self.secretTf becomeFirstResponder];
        return NO;
        
    }else if (textField == self.secretTf && [string isEqualToString:@"\n"]){
        
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}

-(void)updateViewConstraints{
    [super updateViewConstraints];

    self.loginBt.layer.borderWidth = 1;
    self.loginBt.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBt.layer.cornerRadius = 22.5;
    self.loginBt.clipsToBounds = YES;
    
    [self.phoneTf setValue:YYSRGBColor(168, 168, 168, 1)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTf setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    
    [self.secretTf setValue:YYSRGBColor(168, 168, 168, 1)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.secretTf setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}


@end
