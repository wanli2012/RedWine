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
#import "LoginIdentityView.h"

@interface LBLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *secretTf;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (strong, nonatomic)LoginIdentityView *loginView;
@property (strong, nonatomic)UIImageView *currentloginViewimage;//当前选择身份的选中图

@property (strong, nonatomic)UIView *maskView;
@property (strong, nonatomic)NSString *usertype;//用户类型 默认为善行者

@end

@implementation LBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSucess:) name:@"registerSucess" object:nil];
    
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
}
//注册成功
-(void)registerSucess:(NSNotification*)noti{

    NSDictionary *dic = noti.userInfo;
    self.phoneTf.text = dic[@"phone"];

}
//忘记密码
- (IBAction)forgetSecret:(UIButton *)sender {
    
    LBRegisterViewController *vc = [[LBRegisterViewController alloc]init];
    //[self presentViewController:vc animated:NO completion:nil];
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    // animation.type = kCATransitionFade;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:vc animated:NO completion:nil];
    
}
//快速注册
- (IBAction)fastlyRegister:(UIButton *)sender {
    
    LBForgetSecretViewController *vc = [[LBForgetSecretViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    // animation.type = kCATransitionFade;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:vc animated:NO completion:nil];

}
//登录
- (IBAction)loginEvent:(UIButton *)sender {
    
    if (self.phoneTf.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入手机号码"];
        return;
    }else{
        if (![predicateModel valiMobile:self.phoneTf.text]) {
            [MBProgressHUD showError:@"手机号格式不对"];
            return;
        }
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
    dic[@"userphone"] = self.phoneTf.text;
    dic[@"password"] = encryptsecret;
    dic[@"groupID"] = @"";
    
    [NetworkManager requestPOSTWithURLStr:LOGIN paramDic:dic finish:^(id responseObject) {
        if ([responseObject[@"code"] integerValue]==1) {
            
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
    } enError:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败,请检查网络"];
    }];

}

//普通用户
-(void)shangViewgesture{
    
    self.usertype = @"";
    if (self.currentloginViewimage == self.loginView.shangImage) {
        return;
    }
    self.loginView.shangImage.image=[UIImage imageNamed:@"全选选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"全选"];
    self.currentloginViewimage = self.loginView.shangImage;
}
//零售商
-(void)lingViewgesture{
    
    self.usertype = @"";
    if (self.currentloginViewimage == self.loginView.lingimage) {
        return;
    }
    self.loginView.lingimage.image=[UIImage imageNamed:@"全选选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"全选"];
    self.currentloginViewimage = self.loginView.lingimage;
    
}
//一级业务员
-(void)oneSalerViewgesture{
    
    self.usertype = @"";
    if (self.currentloginViewimage == self.loginView.oneImage) {
        return;
    }
    self.loginView.oneImage.image=[UIImage imageNamed:@"全选选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"全选"];
    self.currentloginViewimage = self.loginView.oneImage;
    
}
//二级业务员
-(void)twoSalerViewgesture{
    
    self.usertype = @"";
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
    
    self.loginView.sureBt.layer.cornerRadius = 4;
    self.loginView.sureBt.clipsToBounds = YES;
    self.loginView.cancelBt.layer.cornerRadius = 4;
    self.loginView.cancelBt.clipsToBounds = YES;

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
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}


@end
