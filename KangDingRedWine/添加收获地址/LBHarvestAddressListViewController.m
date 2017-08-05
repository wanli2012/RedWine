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
#import "HarvestAddressModel.h"
#import "LBAddHarvestAddressViewController.h"

@interface LBHarvestAddressListViewController ()<UITableViewDelegate,UITableViewDataSource,LBAddHarvestAddressTableViewCelldelegete>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)NSMutableArray *dataArr;
@property (assign, nonatomic)NSInteger isSelct;//记录设为默认的索引

@end

@implementation LBHarvestAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"LBAddHarvestAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBAddHarvestAddressTableViewCell"];
    self.navigationItem.title = @"收获地址";
    
    for (int i = 0; i < 10; i++) {
        
        HarvestAddressModel *model = [[HarvestAddressModel alloc]init];
        if (i==0) {
            model.isSelect = YES;
            self.isSelct = i;
        }else{
          model.isSelect = NO;
        }
        model.phone = @"15228988355";
        model.name = @"哈麻批";
        model.address = @"四川省成都市人民北路二段哈哈哈哈哈哈哈哈哈哈";
        [self.dataArr addObject:model];
    }
    
    [self.tableview reloadData];
    
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBAddHarvestAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBAddHarvestAddressTableViewCell"];
    cell.selectionStyle = 0;
    cell.model = self.dataArr[indexPath.row];
    cell.row = indexPath.row;
    cell.delegete = self;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableview.estimatedRowHeight = 120;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
//添加
- (IBAction)AddAdress:(UITapGestureRecognizer *)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    LBAddHarvestAddressViewController *vc = [[LBAddHarvestAddressViewController alloc]init];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];

    
}


#pragma mark --------- LBAddHarvestAddressTableViewCelldelegete

-(void)SetAsDefaultRow:(NSInteger)row{
    
    if (self.isSelct == row) {
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        HarvestAddressModel *model = self.dataArr[self.isSelct];
        model.isSelect = NO;
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.isSelct inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
     self.isSelct = row;

}
//删除
-(void)deleteRow:(NSInteger)row{
    [self.dataArr removeObjectAtIndex:row];
    [self.tableview reloadData];

}
//修改
-(void)modifyRow:(NSInteger)row{

    self.hidesBottomBarWhenPushed = YES;
    LBAddHarvestAddressViewController *vc = [[LBAddHarvestAddressViewController alloc]init];
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSMutableArray*)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
    
}

@end
