//
//  GLMine_PersonInfoController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_PersonInfoController.h"
#import "GLMine_PersonInfoCell.h"

@interface GLMine_PersonInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy)NSArray *titlesArr;
@property (nonatomic, copy)NSArray *titlesArr2;
@property (nonatomic, copy)NSArray *detailsArr;

@end

@implementation GLMine_PersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"会员信息";
    self.view.backgroundColor = [UIColor whiteColor];
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
        return 8;
    }else{
        return 2;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLMine_PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_PersonInfoCell"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        cell.detailLabel.hidden = YES;
        cell.arrowImageV.hidden = YES;
        cell.imageV.hidden = NO;
        
    }else{
        
        cell.detailLabel.hidden = NO;
        cell.arrowImageV.hidden = NO;
        cell.imageV.hidden = YES;
        
    }
    if (indexPath.section == 0) {
        
        cell.titleLabel.text = self.titlesArr[indexPath.row];
        if (indexPath.row != 0) {
            
            cell.detailLabel.text = self.detailsArr[indexPath.row - 1];
        }
        
    }else{
        
        cell.titleLabel.text = self.titlesArr2[indexPath.row];
        cell.detailLabel.text = @"";
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 70;
    }else{
        return 40;
    }
}


#pragma mark 懒加载
- (NSArray *)titlesArr{
    if (!_titlesArr) {
        _titlesArr = [NSArray arrayWithObjects:@"头像",@"用户ID",@"会员等级",@"昵称",@"性别",@"全团了ID",@"推荐人ID",@"实名认证信息",@"地址管理",@"账户安全", nil];
    }
    return _titlesArr;
}
- (NSArray *)titlesArr2{
    if (!_titlesArr2) {
        _titlesArr2 = [NSArray arrayWithObjects:@"地址管理",@"账户安全", nil];
    }
    return _titlesArr2;
}

- (NSArray *)detailsArr{
    if (!_detailsArr) {
        _detailsArr = [NSArray arrayWithObjects:@"33333",@"3级",@"没那么简单",@"男",@"339399393",@"HY8838",@"龚磊",nil];
    }
    return _detailsArr;
}
@end
