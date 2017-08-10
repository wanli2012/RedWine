//
//  GLHome_GoodsDetailController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/2.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_GoodsDetailController.h"
#import "GLHome_GoodsDetailCellCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "PYArcMenuView.h"
#import "GLHome_GoodsCommentController.h"
#import "GLShoppingCartController.h"
#import "GLShoppingCart_OrderController.h"

#define kPIC_HEIGHT  200

@interface GLHome_GoodsDetailController ()<UITableViewDataSource,UITableViewDelegate,PYArcMenuViewDelegate,SDCycleScrollViewDelegate>
{
    CGFloat _headerImageHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UIView *headerView;//头视图
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//商品名字
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格
@property (weak, nonatomic) IBOutlet UIButton *commentCountBtn;//评论数

@property (weak, nonatomic) IBOutlet UIView *acountView;//销量View
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//销量Label

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;

@property (nonatomic, strong)NSDictionary *goodsDetailDic;

@property (strong, nonatomic) NSArray<PYArcMenuView *> *menuArray;
@property (strong, nonatomic) NSArray<UIImage *> *menuImageArray;

@property (nonatomic, strong)NSMutableArray *models;
@property (weak, nonatomic) IBOutlet UIButton *addToCartBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyNowBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation GLHome_GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_GoodsDetailCellCell" bundle:nil] forCellReuseIdentifier:@"GLHome_GoodsDetailCellCell"];

    [self updateData:YES];
    
}

- (void)updateData:(BOOL)status {
    
    [self.models removeAllObjects];
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:GOODSDETAIL paramDic:@{@"goods_id":self.goodsID} finish:^(id responseObject) {
        
        [self endRefresh];
        [self.loadV removeloadview];
        
        if([responseObject[@"code"] integerValue] == 1){
            
            if ([responseObject[@"data"] count] == 0) {
                
                [MBProgressHUD showError:@"没有数据"];
                
                return;
                
            }
            
            if ([responseObject[@"data"][@"goods_detail"] count] == 0) {
                
                [MBProgressHUD showError:responseObject[@"message"]];
                
                return;
                
            }
            
            self.goodsDetailDic = responseObject[@"data"][@"goods_detail"];
            
            self.nameLabel.text = self.goodsDetailDic[@"goods_info"];
            self.priceLabel.text = [NSString stringWithFormat:@"%@酒劵",self.goodsDetailDic[@"discount"]];
            self.countLabel.text = [NSString stringWithFormat:@"销量: %@",self.goodsDetailDic[@"salenum"]];
            [self.commentCountBtn setTitle:[NSString stringWithFormat:@"评论:(%@)",responseObject[@"data"][@"comment"][@"count"]] forState:UIControlStateNormal];
            
            if ([responseObject[@"data"][@"comment"][@"datas"] count] == 0) {
                
                return;
                
            }
            
            for (NSDictionary *dic in responseObject[@"data"][@"comment"][@"datas"]) {
                GLHome_GoodsCommentModel *model = [GLHome_GoodsCommentModel mj_objectWithKeyValues:dic];
                [self.models addObject:model];
            }

        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        
        [self endRefresh];
        [self.loadV removeloadview];
        
    }];
}

- (void)endRefresh {
    
    [self.tableView.mj_header endRefreshing];
    
}

-(NodataView*)nodataV{
    
    if (!_nodataV) {
        
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-114-49);
        
    }
    return _nodataV;
    
}

- (void)setUI{
    
    _headerImageHeight = 250;
    [self.tableView addSubview:self.cycleScrollView];
    self.cycleScrollView.tag = 101;
    self.tableView.contentInset = UIEdgeInsetsMake(_headerImageHeight, 0, 0, 0);

    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.acountView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(13, 13)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.acountView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.acountView.layer.mask = maskLayer;
    
    self.titleLabel.alpha = 0;
    
    self.addToCartBtn.layer.cornerRadius = 5.f;
    self.buyNowBtn.layer.cornerRadius = 5.f;
    
    self.bottomView.layer.shadowColor=[UIColor darkGrayColor].CGColor;
    self.bottomView.layer.shadowOpacity=0.5;
    self.bottomView.layer.shadowOffset = CGSizeMake(0,0);
    
    
//    PYArcMenuView *arcMenuViewRightBottom = [[PYArcMenuView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) withPosition:PYArcMenuViewPositionRightBottom];
//    arcMenuViewRightBottom.backgroundColor = [UIColor clearColor];
//    arcMenuViewRightBottom.delegate = self;
//    [self.view addSubview:arcMenuViewRightBottom];
//    
//    self.menuArray = @[arcMenuViewRightBottom];
//    
//    self.menuImageArray = @[[UIImage imageNamed:@"购物车1"], [UIImage imageNamed:@"购物车1"], [UIImage imageNamed:@"购物车1"]];
//    
//    for (int i=0; i<self.menuArray.count; i++) {
//        [self.menuArray[i] addMenuItemsWithUIImages:self.menuImageArray];
//    }
    
}

//购物车
- (IBAction)shoppingCart:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLShoppingCartController *cartVC = [[GLShoppingCartController alloc] init];
    cartVC.pushIndex = 1;
    [self.navigationController pushViewController:cartVC animated:YES];
    
}
//加入购物车
- (IBAction)addToCart:(id)sender {
    NSString *url;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    url = ADDTOCART;
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"goods_id"] = self.goodsID;
    dict[@"count"] = @1;
    
    [self requestWithUrl:url andDict:dict];

}
//立即购买
- (IBAction)buyNow:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLShoppingCart_OrderController * orderVC = [[GLShoppingCart_OrderController alloc] init];
    
    orderVC.goods_id = self.goodsID;
    orderVC.goods_count = @"1";
    
    [self.navigationController pushViewController:orderVC animated:YES];
}

//请求
- (void)requestWithUrl:(NSString *)url andDict:(NSMutableDictionary *)dict {

    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:url paramDic:dict finish:^(id responseObject) {
        
        [self endRefresh];
        [self.loadV removeloadview];
        
        if([responseObject[@"code"] integerValue] == 1){
            
            [MBProgressHUD showSuccess:responseObject[@"message"]];
            
        }else{
            
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        
        [self endRefresh];
        [self.loadV removeloadview];
        
    }];

}
- (void)PYArcMenuWillExpand:(PYArcMenuView *)menu {
    
}

- (void)PYArcMenuWillUnExpand:(PYArcMenuView *)menu {
    
}

- (void)PYArcMenuView:(PYArcMenuView *)menu didSelectedForIndex:(NSInteger)index {
    
    NSLog(@"%ld", index);
    
    if (![UserModel defaultUser].loginstatus) {
        [MBProgressHUD showError:@"请先登录!"];
        return;
    }
    
    NSString *url;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    switch (index) {
        case 0:
        {
            url = ADDTOCART;
            dict[@"uid"] = [UserModel defaultUser].uid;
            dict[@"token"] = [UserModel defaultUser].token;
            dict[@"goods_id"] = self.goodsID;
            dict[@"count"] = @1;
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:url paramDic:dict finish:^(id responseObject) {
        
        [self endRefresh];
        [self.loadV removeloadview];
        
        if([responseObject[@"code"] integerValue] == 1){
            
            [MBProgressHUD showSuccess:responseObject[@"message"]];
            
        }else{
            
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        
        [self endRefresh];
        [self.loadV removeloadview];
        
    }];

    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
  

}

//查看全部评论
- (IBAction)checkAllComment:(id)sender {
    
    if (self.models.count == 0) {
        [MBProgressHUD showError:@"没有更多评论"];
        return;
    }
    
    self.hidesBottomBarWhenPushed = YES;
    
    GLHome_GoodsCommentController *comment = [[GLHome_GoodsCommentController alloc] init];
    comment.models = self.models;
    [self.navigationController pushViewController:comment animated:YES];
    
}

//返回
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHome_GoodsDetailCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_GoodsDetailCellCell"];

    cell.selectionStyle = 0;
    
    cell.model = self.models.count == 0 ? 0 : self.models[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    
    return tableView.rowHeight;
}

//滚动代理事件 图片放大 以及 导航栏颜色渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGPoint point = scrollView.contentOffset;
    
    if (point.y < -_headerImageHeight) {
        CGRect rect = [self.tableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:101].frame = rect;
    }

    //导航栏颜色渐变
    UIColor *color=[UIColor blackColor];
    CGFloat offset = scrollView.contentOffset.y + 140;
    if (offset < 0) {
        
        self.navView.backgroundColor = [color colorWithAlphaComponent:0];
        self.titleLabel.alpha = 0;
        self.acountView.x = kSCREEN_WIDTH - 100;
        
    }else {
        
        CGFloat alpha = 1-((64-offset)/64);
        self.navView.backgroundColor= [color colorWithAlphaComponent:alpha];
        self.titleLabel.alpha = alpha;
        self.acountView.x = kSCREEN_WIDTH - 100 + offset;
        
    }
    
}

-(SDCycleScrollView*)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, -_headerImageHeight)
                                                              delegate:self
                                                      placeholderImage:[UIImage imageNamed:LUNBO_PlaceHolder]];
        
        _cycleScrollView.autoScrollTimeInterval = 5.f;
        _cycleScrollView.localizationImageNamesGroup = @[LUNBO_PlaceHolder,LUNBO_PlaceHolder,LUNBO_PlaceHolder];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        
        _cycleScrollView.placeholderImageContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;// 翻页 右下角
        _cycleScrollView.titleLabelBackgroundColor = YYSRGBColor(241, 242, 243, 1);// 图片对应的标题的 背景色。（因为没有设标题）
        
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"矩形-4-拷贝-2"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"矩形-4-拷贝"];
        _cycleScrollView.placeholderImage = [UIImage imageNamed:LUNBO_PlaceHolder];
        _cycleScrollView.pageControlDotSize = CGSizeMake(10, 2);
    }
    
    return _cycleScrollView;
    
}

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    return _models;
}
@end
