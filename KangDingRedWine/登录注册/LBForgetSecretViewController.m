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
@property (weak, nonatomic) IBOutlet UIButton *protcolBt;

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
    if (sender.selected) {
        self.registerBt.alpha = 1;
    }else{
        self.registerBt.alpha = 0.5;
    }
    
    
    
}
//获取验证码
- (IBAction)getcode:(UIButton *)sender {
    
    if (self.phoneTf.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入手机号码"];
        return;
    }else{
        if (![predicateModel valiMobile:self.phoneTf.text]) {
            [MBProgressHUD showError:@"手机号格式不对"];
            return;
        }
    }
    
    [self startTime];//获取倒计时
    [NetworkManager requestPOSTWithURLStr:GETYZM paramDic:@{@"phone":self.phoneTf.text} finish:^(id responseObject) {
        if ([responseObject[@"code"] integerValue]==1) {
            
        }else{
            
        }
    } enError:^(NSError *error) {
        
    }];
    
}
//点击注册
- (IBAction)clickRegister:(UIButton *)sender {
    
    if (!self.protcolBt.selected) {
        [MBProgressHUD showError:@"请同意注册协议"];
        return;
    }
    
    if (self.phoneTf.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入手机号码"];
        return;
    }else{
        if (![predicateModel valiMobile:self.phoneTf.text]) {
            [MBProgressHUD showError:@"手机号格式不对"];
            return;
        }
    }
    
    if (self.yzmTf.text.length <= 0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    
    if (self.secretTf.text.length <= 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    
    if (self.secretTf.text.length < 8 || self.secretTf.text.length > 16) {
        [MBProgressHUD showError:@"请输入8-16位密码"];
        return;
    }
    if (![predicateModel checkPassWord:self.secretTf.text]) {
        
        [MBProgressHUD showError:@"密请输入正确的密码格式"];
        return;
    }
    
    if (self.ensureTf.text.length <= 0) {
        [MBProgressHUD showError:@"请输入确认密码"];
        return;
    }
    
    if (![self.secretTf.text isEqualToString:self.ensureTf.text]) {
        [MBProgressHUD showError:@"两次输入的密码不一致"];
        return;
    }
    
    NSString *encryptsecret = [RSAEncryptor encryptString:self.secretTf.text publicKey:public_RSA];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userphone"] = self.phoneTf.text;
    dic[@"password"] = encryptsecret;
    dic[@"user_name"] = self.recommendTf.text;
    dic[@"yzm"] = self.yzmTf.text;
    dic[@"qtidnum"] = self.qtID.text;
    
    [NetworkManager requestPOSTWithURLStr:REGISTER paramDic:dic finish:^(id responseObject) {
        NSLog(@"%@",dic);
        NSLog(@"%@",responseObject[@"message"]);
        if ([responseObject[@"code"] integerValue]==1) {
            
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
    } enError:^(NSError *error) {
         [MBProgressHUD showError:@""];
    }];
    
    
    
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

//获取倒计时
-(void)startTime{
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBt setTitle:@"重发验证码" forState:UIControlStateNormal];
                self.codeBt.userInteractionEnabled = YES;
                //self.codeBt.backgroundColor = YYSRGBColor(44, 153, 46, 1);
                self.codeBt.titleLabel.font = [UIFont systemFontOfSize:13];
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d秒后重新发送", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBt setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                self.codeBt.userInteractionEnabled = NO;
                //self.codeBt.backgroundColor = YYSRGBColor(184, 184, 184, 1);
                self.codeBt.titleLabel.font = [UIFont systemFontOfSize:11];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
@end
