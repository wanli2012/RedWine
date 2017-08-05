//
//  GLShoppingCartController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLShoppingCartController.h"
#import "LBShopingCarTableViewCell.h"
#import "UIButton+SetEdgeInsets.h"
#import "shopingModel.h"
#import "GLShoppingCart_OrderController.h"

@interface GLShoppingCartController ()<UITableViewDataSource,UITableViewDelegate,LBShopingCarTableViewCelldelegete>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *allChoseBt;//全选按钮
@property (weak, nonatomic) IBOutlet UILabel *totalLb;//总计
@property (strong, nonatomic)NSMutableArray *dataArr;

@end

@implementation GLShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"LBShopingCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBShopingCarTableViewCell"];

    [self.allChoseBt horizontalCenterImageAndTitle:10];
    
    for (int i = 0; i < 10 ; i++) {
        
        shopingModel *model = [[shopingModel alloc]init];
        model.isSelect = NO;
        model.imagev = @"";
        model.info = @"[康定红酒]哇哈哈AD钙奶哇哈哈AD钙奶";
        model.num = @"1";
        model.price = @"300";
        [self.dataArr addObject:model];
        
    }
    
    [self.tableview reloadData];
    
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBShopingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBShopingCarTableViewCell"];
    cell.selectionStyle = 0;
    cell.delegete = self;
    cell.row = indexPath.row;
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

//全部选中
- (IBAction)ChooseAllEvent:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSInteger  num = 0;
    if (sender.selected) {
        for (int i = 0; i < self.dataArr.count; i++) {
            shopingModel *model = self.dataArr[i];
            model.isSelect = YES;
            num = num + [model.price integerValue] * [model.num integerValue];
        }
    }else{
        for (int i = 0; i < self.dataArr.count; i++) {
            shopingModel *model = self.dataArr[i];
            model.isSelect = NO;
        }
        
    }
    
    self.totalLb.text = [NSString stringWithFormat:@"总计:%ld/酒券",(long)num];
    [self.tableview reloadData];
    
}
//去结算
- (IBAction)GoBuying:(UIButton *)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLShoppingCart_OrderController *orderVC = [[GLShoppingCart_OrderController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
#pragma mark -------- LBShopingCarTableViewCelldelegete
-(void)divideEvent:(int)num row:(NSInteger)row{

    NSInteger  numa = 0;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        shopingModel *model = self.dataArr[i];
        if (model.isSelect == YES) {
                numa = numa + [model.price integerValue] * [model.num integerValue];
        }
    }
    
     self.totalLb.text = [NSString stringWithFormat:@"总计:%ld/酒券",(long)numa];
    
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)AddEvent:(int)num row:(NSInteger)row{
    
    NSInteger  numa = 0;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        shopingModel *model = self.dataArr[i];
        if (model.isSelect == YES) {
            numa = numa + [model.price integerValue] * [model.num integerValue];
        }
    }
    
    self.totalLb.text = [NSString stringWithFormat:@"总计:%ld/酒券",(long)numa];
    
 [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

-(void)seletedEventRow:(NSInteger)row{

    BOOL  b = NO;
    NSInteger  num = 0;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        shopingModel *model = self.dataArr[i];
        if (model.isSelect == NO) {
            b = YES;
        }else{
            num = num + [model.price integerValue] * [model.num integerValue];
        }
    }
    
    if (b == YES) {
        self.allChoseBt.selected = NO;
    }else{
        self.allChoseBt.selected = YES;
    }
    
    self.totalLb.text = [NSString stringWithFormat:@"总计:%ld/酒券",(long)num];
    
   [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];

}

-(NSMutableArray*)dataArr{

    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;

}

@end
