//
//  LBHarvestAddressListViewController.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBHarvestAddressListViewController.h"
#import "LBAddHarvestAddressViewController.h"
#import "LBAddHarvestAddressTableViewCell.h"

@interface LBHarvestAddressListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)NSMutableArray *dataArr;

@end

@implementation LBHarvestAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"LBAddHarvestAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBAddHarvestAddressTableViewCell"];
    
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBAddHarvestAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBAddHarvestAddressTableViewCell"];
    cell.selectionStyle = 0;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

-(NSMutableArray*)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
    
}

@end
