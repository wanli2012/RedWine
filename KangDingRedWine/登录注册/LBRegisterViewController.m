//
//  LBRegisterViewController.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBRegisterViewController.h"
#import "LoginIdentityView.h"

@interface LBRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *yzmTf;
@property (weak, nonatomic) IBOutlet UITextField *secretTf;
@property (weak, nonatomic) IBOutlet UITextField *ensureTf;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *submitbt;
@property (strong, nonatomic)LoginIdentityView *loginView;
@property (strong, nonatomic)UIImageView *currentloginViewimage;//当前选择身份的选中图

@property (strong, nonatomic)UIView *maskView;
@property (strong, nonatomic)NSString *usertype;//用户类型 默认为善行者

@end

@implementation LBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.loginView.cancelBt addTarget:self action:@selector(maskviewgesture) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.sureBt addTarget:self action:@selector(surebuttonEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *maskvgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskviewgesture)];
    [self.maskView addGestureRecognizer:maskvgesture];
    //选择会员
    UITapGestureRecognizer *shanVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shangViewgesture)];
    [self.loginView.shangView addGestureRecognizer:shanVgesture];
    //选择经理
    UITapGestureRecognizer *lingVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lingViewgesture)];
    [self.loginView.lingView addGestureRecognizer:lingVgesture];
    //选择主管
    UITapGestureRecognizer *OneVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneSalerViewgesture)];
    [self.loginView.oneView addGestureRecognizer:OneVgesture];
    //选择部长
    UITapGestureRecognizer *TwoVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoSalerViewgesture)];
    [self.loginView.twoView addGestureRecognizer:TwoVgesture];
    
    self.currentloginViewimage = self.loginView.shangImage;
    self.usertype = memberID;
    
}

- (IBAction)tapgestureback:(UITapGestureRecognizer *)sender {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
//获取验证码
- (IBAction)getCode:(UIButton *)sender {
    
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
//提交
- (IBAction)submitEvent:(UIButton *)sender {
    
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
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.loginView];
    self.loginView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.loginView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
}

//确定按
-(void)surebuttonEvent{
    [self maskviewgesture];
    NSString *encryptsecret = [RSAEncryptor encryptString:self.secretTf.text publicKey:public_RSA];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phone"] = self.phoneTf.text;
    dic[@"new_pwd"] = encryptsecret;
    dic[@"yzm"] = self.yzmTf.text;
    dic[@"groupID"] = self.usertype;
    
    [NetworkManager requestPOSTWithURLStr:BACKPWD paramDic:dic finish:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue]==1) {
            [MBProgressHUD showError:responseObject[@"message"]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"registerSucess" object:nil userInfo:@{@"phone":self.phoneTf.text}];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CATransition *animation = [CATransition animation];
                animation.duration = 1;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = @"rippleEffect";
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            });
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
    } enError:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败,请检查网络"];
    }];

    
}


//会员
-(void)shangViewgesture{
    
    self.usertype = memberID;
    if (self.currentloginViewimage == self.loginView.shangImage) {
        return;
    }
    self.loginView.shangImage.image=[UIImage imageNamed:@"全选选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"全选"];
    self.currentloginViewimage = self.loginView.shangImage;
}
//经理
-(void)lingViewgesture{
    
    self.usertype = managerID;
    if (self.currentloginViewimage == self.loginView.lingimage) {
        return;
    }
    self.loginView.lingimage.image=[UIImage imageNamed:@"全选选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"全选"];
    self.currentloginViewimage = self.loginView.lingimage;
    
}
//主管
-(void)oneSalerViewgesture{
    
    self.usertype = directorID;
    if (self.currentloginViewimage == self.loginView.oneImage) {
        return;
    }
    self.loginView.oneImage.image=[UIImage imageNamed:@"全选选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"全选"];
    self.currentloginViewimage = self.loginView.oneImage;
    
}
//部长
-(void)twoSalerViewgesture{
    
    self.usertype = ministerID;
    if (self.currentloginViewimage == self.loginView.twoImage) {
        return;
    }
    self.loginView.twoImage.image=[UIImage imageNamed:@"全选选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"全选"];
    self.currentloginViewimage = self.loginView.twoImage;
    
}


//点击maskview
-(void)maskviewgesture{
    
    [self.maskView removeFromSuperview];
    [self.loginView removeFromSuperview];
    
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

-(LoginIdentityView*)loginView{
    
    if (!_loginView) {
        _loginView=[[NSBundle mainBundle]loadNibNamed:@"LoginIdentityView" owner:self options:nil].firstObject;
        _loginView.frame=CGRectMake(20, (kSCREEN_HEIGHT - 240)/2, kSCREEN_WIDTH-40, 240);
        _loginView.alpha=1;
        
    }
    
    return _loginView;
    
}

-(UIView*)maskView{
    
    if (!_maskView) {
        _maskView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_maskView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8f]];
        
    }
    return _maskView;
    
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


@end
