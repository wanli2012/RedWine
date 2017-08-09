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

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;

@property (nonatomic, strong)NSMutableArray *models;
@property (nonatomic, strong)NSMutableArray *selectedArr;//选中的商品 数组

@end

@implementation GLShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"LBShopingCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBShopingCarTableViewCell"];

    [self.allChoseBt horizontalCenterImageAndTitle:10];
  
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self initDataSource];
    
}
- (void)initDataSource{
    
    [self.models removeAllObjects];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
//    dict[@"page"] = @"1";

    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:CARTLIST paramDic:dict finish:^(id responseObject) {
        
        [self endRefresh];
        [self.loadV removeloadview];
        
        if([responseObject[@"code"] integerValue] == 1){
            
            if ([responseObject[@"data"] count] == 0) {
                
                [MBProgressHUD showError:responseObject[@"message"]];
                return;
            }

            for (NSDictionary *dic in responseObject[@"data"]) {
                
                shopingModel *model = [shopingModel mj_objectWithKeyValues:dic];
                
                model.isSelect = NO;
                
                [self.models addObject:model];
           
            }
        }
        
        [self.tableview reloadData];
        
    } enError:^(NSError *error) {
        [self endRefresh];
        [self.loadV removeloadview];
        
    }];

}
- (void)endRefresh {
    [self.tableview.mj_header endRefreshing];
}

-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-50-49);
    }
    return _nodataV;
    
}
#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.models.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBShopingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBShopingCarTableViewCell"];
    cell.selectionStyle = 0;
    cell.delegete = self;
    cell.row = indexPath.row;
    cell.model = self.models[indexPath.row];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
//设置可删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//滑动删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.tableview.isEditing)
    {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleDelete;
}

//修改左滑的按钮的字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) { //删除事件
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除" message:@"你确定要删除该项?" preferredStyle:UIAlertControllerStyleAlert];
  
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
//            NSLog(@"点击取消");
            
        }]];

        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            shopingModel *model = self.models[indexPath.row];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"uid"] = [UserModel defaultUser].uid;
            dict[@"token"] = [UserModel defaultUser].token;
            dict[@"cart_id"] = model.cart_id;
            
            _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
            [NetworkManager requestPOSTWithURLStr:CARTDELETE paramDic:dict finish:^(id responseObject) {
                
                [self.loadV removeloadview];
                
                if([responseObject[@"code"] integerValue] == 1){
                    
                    [MBProgressHUD showError:responseObject[@"message"]];
                    
                    //本地删除数据源
                    [self.models removeObjectAtIndex:indexPath.row];//tableview数据源
                   
                    [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                }

            } enError:^(NSError *error) {

                [self.loadV removeloadview];
                
            }];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
  
}

//全部选中
- (IBAction)ChooseAllEvent:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSInteger  num = 0;
    if (sender.selected) {
        for (int i = 0; i < self.models.count; i++) {
            shopingModel *model = self.models[i];
            model.isSelect = YES;
            num = num + [model.goods_price integerValue] * [model.num integerValue];
        }
    }else{
        for (int i = 0; i < self.models.count; i++) {
            shopingModel *model = self.models[i];
            model.isSelect = NO;
        }
        
    }
    
    self.totalLb.text = [NSString stringWithFormat:@"总计:%ld/酒券",(long)num];
    [self.tableview reloadData];
    
}

//去结算
- (IBAction)GoBuying:(UIButton *)sender {
    
    if (self.selectedArr.count == 0) {
        [MBProgressHUD showError:@"还未选择商品"];
        return;
    }
    
    self.hidesBottomBarWhenPushed = YES;
    GLShoppingCart_OrderController *orderVC = [[GLShoppingCart_OrderController alloc] init];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    NSMutableArray *tempArr2 = [NSMutableArray array];
    
    for (int i = 0; i < self.selectedArr.count; i ++) {
        shopingModel *model = self.models[i];
        [tempArr addObject:model.goods_id];
        [tempArr2 addObject:model.num];
    }
    orderVC.goods_id = [tempArr componentsJoinedByString:@","];;
    orderVC.goods_count = [tempArr2 componentsJoinedByString:@","];
    
    [self.navigationController pushViewController:orderVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
#pragma mark -------- LBShopingCarTableViewCelldelegete
//减号代理
-(void)divideEvent:(int)num row:(NSInteger)row{

    NSInteger  numa = 0;
    
    for (int i = 0; i < self.models.count; i++) {
        shopingModel *model = self.models[i];
        if (model.isSelect == YES) {
                numa = numa + [model.goods_price integerValue] * [model.num integerValue];
        }
    }
    
     self.totalLb.text = [NSString stringWithFormat:@"总计:%ld/酒券",(long)numa];
    
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}
//加号代理
-(void)AddEvent:(int)num row:(NSInteger)row{
    
    NSInteger  numa = 0;
    
    for (int i = 0; i < self.models.count; i++) {
        shopingModel *model = self.models[i];
        if (model.isSelect == YES) {
            numa = numa + [model.goods_price integerValue] * [model.num integerValue];
        }
    }
    
    self.totalLb.text = [NSString stringWithFormat:@"总计:%ld/酒券",(long)numa];
    
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

//点击选中按钮代理
-(void)seletedEventRow:(NSInteger)row{

    [self.selectedArr removeAllObjects];
    
    BOOL  b = NO;
    NSInteger  num = 0;
    
    for (int i = 0; i < self.models.count; i++) {
        shopingModel *model = self.models[i];
        
        if (model.isSelect == NO) {
            b = YES;
            
        }else{
            num = num + [model.goods_price integerValue] * [model.num integerValue];
            [self.selectedArr addObject:model];
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

-(NSMutableArray*)models{

    if (!_models) {
        _models = [NSMutableArray array];
    }
    
    return _models;

}
-(NSMutableArray*)selectedArr{
    
    if (!_selectedArr) {
        _selectedArr = [NSMutableArray array];
    }
    
    return _selectedArr;
    
}

@end
