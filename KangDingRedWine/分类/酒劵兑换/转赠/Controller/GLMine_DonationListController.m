//
//  GLMine_DonationController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_DonationListController.h"
#import "GLMine_DonationListCell.h"

@interface GLMine_DonationListController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLMine_DonationListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"转赠列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_DonationListCell" bundle:nil] forCellReuseIdentifier:@"GLMine_DonationListCell"];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}


#pragma mark UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLMine_DonationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_DonationListCell"];

//    cell.delegate = self;
//    cell.index = indexPath.row;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    tableView.estimatedRowHeight = 44;
//    tableView.rowHeight = UITableViewAutomaticDimension;
    
    return 50;
}

@end
