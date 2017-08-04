//
//  GLMine_BankListController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_BankListController.h"
#import "GLMine_BankListCell.h"
#import "GLMine_BankCardBlindingController.h"

@interface GLMine_BankListController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLMine_BankListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"银行卡";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_BankListCell" bundle:nil] forCellReuseIdentifier:@"GLMine_BankListCell"];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.backgroundColor = [UIColor redColor];
    rightBtn.frame = CGRectMake(0, 0, 80, 44);
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14 * autoSizeScaleX]];
    [rightBtn setTitle:@"绑定新卡" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(bindingCard) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)bindingCard {
    
    GLMine_BankCardBlindingController *blindingVC = [[GLMine_BankCardBlindingController alloc] init];
    [self.navigationController pushViewController:blindingVC animated:YES];
}


#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLMine_BankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_BankListCell"];
    
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}



@end
