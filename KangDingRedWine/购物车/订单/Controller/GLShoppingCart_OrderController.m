//
//  GLShoppingCart_OrderController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLShoppingCart_OrderController.h"
#import "GLShoppingCart_OrderCell.h"
#import "LBHarvestAddressListViewController.h"
#import "GLCart_OrderModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GLShoppingCart_AllGoodsController.h"

@interface GLShoppingCart_OrderController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@property (weak, nonatomic) IBOutlet UIView *messageView;//留言view
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;//提交
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;//留言textView
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;//留言中的label
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;//合计

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;

@property (nonatomic, strong)NSMutableArray *models;


@end

@implementation GLShoppingCart_OrderController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"确认订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    self.contentViewHeight.constant = kSCREEN_HEIGHT - 64;
    
    self.messageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.messageView.layer.borderWidth = 1.f;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLShoppingCart_OrderCell" bundle:nil] forCellWithReuseIdentifier:@"GLShoppingCart_OrderCell"];
    
    [self initDataSource];
    
}

- (void)initDataSource{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"goods_id"] = self.goods_id;
    dict[@"goods_count"] = self.goods_count;
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:PLACEORDER_BEFORE paramDic:dict finish:^(id responseObject) {

        [self.loadV removeloadview];
        
        if([responseObject[@"code"] integerValue] == 1){
            
            if ([responseObject[@"data"] count] == 0) {
                
                [MBProgressHUD showError:responseObject[@"message"]];
                
                return;
            }
            
            for (NSDictionary *dic in responseObject[@"data"][@"goods_info"]) {
                GLCart_OrderModel *model = [GLCart_OrderModel mj_objectWithKeyValues:dic];
                [self.models addObject:model];
            }
    
        }

        [self.collectionView reloadData];
        
    } enError:^(NSError *error) {

        [self.loadV removeloadview];
        
    }];
    
}

-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-50-49);
    }
    return _nodataV;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}
//更换地址
- (IBAction)changeAddress:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    LBHarvestAddressListViewController *addressListVC = [[LBHarvestAddressListViewController alloc] init];
    [self.navigationController pushViewController:addressListVC animated:YES];
    
}
//所有商品
- (IBAction)allGoods:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLShoppingCart_AllGoodsController *allVC = [[GLShoppingCart_AllGoodsController alloc] init];
    allVC.models = self.models;
    
    [self.navigationController pushViewController:allVC animated:YES];
    
}
//快递配送
- (IBAction)express:(id)sender {
    NSLog(@"快递配送");
}
//发票信息
- (IBAction)billInfo:(id)sender {
    NSLog(@"发票信息");
}
//运费
- (IBAction)freight:(id)sender {
    NSLog(@"运费");
}

//提交
- (IBAction)submit:(id)sender {
    
    NSLog(@"提交订单");
    
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    self.messageLabel.hidden = YES;
    
    return YES;
}

#pragma UICollectionViewDelegate UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GLCart_OrderModel *model = self.models[indexPath.row];
    GLShoppingCart_OrderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLShoppingCart_OrderCell" forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:kGOODS_PlaceHolder]];
    
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 80);
}

- (NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
@end
