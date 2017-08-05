//
//  LBAddHarvestAddressViewController.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBAddHarvestAddressViewController.h"
#import "UIButton+SetEdgeInsets.h"

@interface LBAddHarvestAddressViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *provinceTf;
@property (weak, nonatomic) IBOutlet UITextField *cityTf;
@property (weak, nonatomic) IBOutlet UITextField *areaTf;
@property (weak, nonatomic) IBOutlet UITextField *detailTf;
@property (weak, nonatomic) IBOutlet UIButton *selectbt;
@property (strong, nonatomic)UIButton *buttonedt;

@end

@implementation LBAddHarvestAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    if (self.type == 1) {
        self.navigationItem.title = @"添加收获地址";
    }else{
        self.navigationItem.title = @"修改收获地址";
    }
    
    
    _buttonedt=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 60)];
    [_buttonedt setTitle:@"完成" forState:UIControlStateNormal];
    [_buttonedt setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    _buttonedt.titleLabel.font = [UIFont systemFontOfSize:14];
    [_buttonedt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonedt addTarget:self action:@selector(clickDone) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_buttonedt];
    
     [self.selectbt horizontalCenterImageAndTitle:5];
    
}
//设为默认
- (IBAction)setDefualt:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}
//完成
-(void)clickDone{


}
//选择省
- (IBAction)chooseProvince:(UITapGestureRecognizer *)sender {
    
}
//选择市
- (IBAction)choosecity:(UITapGestureRecognizer *)sender {
    
}
//选择区
- (IBAction)chooseArea:(UITapGestureRecognizer *)sender {
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.nameTf && [string isEqualToString:@"\n"]) {
        [self.phoneTf becomeFirstResponder];
        return NO;
        
    }else if (textField == self.phoneTf && [string isEqualToString:@"\n"]){
        
        [self.detailTf becomeFirstResponder];
        return NO;
    }else if (textField == self.detailTf && [string isEqualToString:@"\n"]){
        
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

@end
