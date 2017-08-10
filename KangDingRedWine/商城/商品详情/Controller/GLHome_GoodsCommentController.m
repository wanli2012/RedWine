//
//  GLHome_GoodsCommentController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/10.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_GoodsCommentController.h"
#import "GLHome_GoodsDetailCellCell.h"

@interface GLHome_GoodsCommentController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLHome_GoodsCommentController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"全部评论";
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_GoodsDetailCellCell" bundle:nil] forCellReuseIdentifier:@"GLHome_GoodsDetailCellCell"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark UItableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHome_GoodsDetailCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_GoodsDetailCellCell"];
    
    cell.model = self.models[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    
    return tableView.rowHeight;}

@end
