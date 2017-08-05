//
//  GLMine_OrderListController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_OrderListController.h"
#import "GLMine_OrderListCell.h"

@interface GLMine_OrderListController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLMine_OrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单成功";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_OrderListCell" bundle:nil] forCellReuseIdentifier:@"GLMine_OrderListCell"];
    
  
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_OrderListCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.estimatedRowHeight = 44;
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    return tableView.rowHeight;
}


@end
