//
//  GLShoppingCart_AllGoodsController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/9.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLShoppingCart_AllGoodsController.h"
#import "GLShoppineCart_GoodsCell.h"

@interface GLShoppingCart_AllGoodsController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLShoppingCart_AllGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品清单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLShoppineCart_GoodsCell" bundle:nil] forCellReuseIdentifier:@"GLShoppineCart_GoodsCell"];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.models.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GLShoppineCart_GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLShoppineCart_GoodsCell"];
    
    cell.model = self.models[indexPath.row];
    
    cell.selectionStyle = 0;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

@end
