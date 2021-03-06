//
//  GLMine_AccountSafetyController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_AccountSafetyController.h"
#import "GLMine_PersonInfoCell.h"
#import "GLMine_BankListController.h"
#import "GLMine_RealNameController.h"

@interface GLMine_AccountSafetyController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy)NSArray *titlesArr;
@property (nonatomic, copy)NSArray *titlesArr2;

@end

@implementation GLMine_AccountSafetyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_PersonInfoCell" bundle:nil] forCellReuseIdentifier:@"GLMine_PersonInfoCell"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.titlesArr.count;
    }else{
        return self.titlesArr2.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLMine_PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_PersonInfoCell"];
    
    cell.imageV.hidden = YES;
    cell.detailLabel.hidden = YES;
    cell.arrowImageV.hidden = NO;

    if (indexPath.section == 0) {
        
        cell.titleLabel.text = self.titlesArr[indexPath.row];
   
    }else{
        
        cell.titleLabel.text = self.titlesArr2[indexPath.row];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 10)];
    headerV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if (section != 0) {
        
        return headerV;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return 40;
  
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0://登录密码
            {
                NSLog(@"登录密码");
            }
                break;
            case 1://支付密码
            {
                NSLog(@"支付密码");
            }
                break;
                
            default:
                
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0://绑定手机
            {
                NSLog(@"绑定手机");
            }
                break;
            case 1://实名认证
            {
                
                GLMine_RealNameController *realVC = [[GLMine_RealNameController alloc] init];
                [self.navigationController pushViewController:realVC animated:YES];
            }
                break;
            case 2://银行卡
            {

                GLMine_BankListController *bankVC = [[GLMine_BankListController alloc] init];
                [self.navigationController pushViewController:bankVC animated:YES];
                
            }
                break;
            case 3://退出登录
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    //            NSLog(@"点击取消");
                    
                }]];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [UserModel defaultUser].loginstatus = NO;
                    
                    [usermodelachivar achive];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshInterface" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];

                }]];

                [self presentViewController:alertController animated:YES completion:nil];
                
            }
                break;
                
            default:
                break;
                
        }

    }
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    if (buttonIndex==1) {
//        
////        if (alertView.tag == 10) {
//        
//            [UserModel defaultUser].loginstatus = NO;
//
//            [usermodelachivar achive];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshInterface" object:nil];
//            [self.navigationController popViewControllerAnimated:YES];
//            
////        }else if (alertView.tag == 11){
//            
////            [self clearFile];//清楚缓存
////        }
//        
//    }
//    
//}
#pragma mark 懒加载
- (NSArray *)titlesArr{
    if (!_titlesArr) {
        _titlesArr = [NSArray arrayWithObjects:@"登录密码",@"支付密码", nil];
    }
    return _titlesArr;
}
- (NSArray *)titlesArr2{
    if (!_titlesArr2) {
        _titlesArr2 = [NSArray arrayWithObjects:@"绑定手机",@"实名认证",@"银行卡",@"退出登录", nil];
    }
    return _titlesArr2;
}


@end
