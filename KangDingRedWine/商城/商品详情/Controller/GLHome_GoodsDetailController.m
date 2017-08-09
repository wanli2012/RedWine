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
#import "PYArcMenuView.h"

#define kPIC_HEIGHT  200

@interface GLHome_GoodsDetailController ()<UITableViewDataSource,UITableViewDelegate,PYArcMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *headerView;//头视图
@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;//图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//商品名字
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格

@property (weak, nonatomic) IBOutlet UIView *acountView;//销量View
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//销量Label

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;

@property (nonatomic, strong)NSDictionary *goodsDetailDic;

@property (strong, nonatomic) NSArray<PYArcMenuView *> *menuArray;
@property (strong, nonatomic) NSArray<UIImage *> *menuImageArray;

@end

@implementation GLHome_GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_GoodsDetailCellCell" bundle:nil] forCellReuseIdentifier:@"GLHome_GoodsDetailCellCell"];
    
    [self.tableView addSubview:self.nodataV];
    
    //加载数据
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf updateData:YES];
        
    }];
    
    // 设置文字
    [header setTitle:@"快扯我，快点" forState:MJRefreshStateIdle];
    
    [header setTitle:@"数据要来啦" forState:MJRefreshStatePulling];
    
    [header setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_header = header;
    
    [weakSelf updateData:YES];
    
}

- (void)updateData:(BOOL)status {
    
    
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
                
                [MBProgressHUD showError:@"没有数据"];
                return;
                
            }
            
            self.goodsDetailDic = responseObject[@"data"][@"goods_detail"];
            
            self.nameLabel.text = self.goodsDetailDic[@"goods_info"];
            self.priceLabel.text = [NSString stringWithFormat:@"%@酒劵",self.goodsDetailDic[@"discount"]];
            self.countLabel.text = [NSString stringWithFormat:@"销量:%@",self.goodsDetailDic[@"salenum"]];
            
            NSString *urlStr = self.goodsDetailDic[@"thumb_url"][0];
            [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:kGOODS_PlaceHolder]];
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
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.acountView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(13, 13)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.acountView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.acountView.layer.mask = maskLayer;
    
    self.titleLabel.alpha = 0;
    
    PYArcMenuView *arcMenuViewRightBottom = [[PYArcMenuView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) withPosition:PYArcMenuViewPositionRightBottom];
    arcMenuViewRightBottom.backgroundColor = [UIColor clearColor];
    arcMenuViewRightBottom.delegate = self;
    [self.view addSubview:arcMenuViewRightBottom];
    
    self.menuArray = @[arcMenuViewRightBottom];
    
    self.menuImageArray = @[[UIImage imageNamed:@"购物车1"], [UIImage imageNamed:@"购物车1"], [UIImage imageNamed:@"购物车1"]];
    
    for (int i=0; i<self.menuArray.count; i++) {
        [self.menuArray[i] addMenuItemsWithUIImages:self.menuImageArray];
    }
    
}

- (void)PYArcMenuWillExpand:(PYArcMenuView *)menu {
    
}

- (void)PYArcMenuWillUnExpand:(PYArcMenuView *)menu {
    
}

- (void)PYArcMenuView:(PYArcMenuView *)menu didSelectedForIndex:(NSInteger)index {
    NSLog(@"%ld", index);
    NSString *url;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    switch (index) {
        case 0:
        {
            url = ADDTOCART;
//            dict[@"uid"] = ;
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
            
            if ([responseObject[@"data"] count] == 0) {
                
                [MBProgressHUD showError:@"没有数据"];
                return;
                
            }
            
            if ([responseObject[@"data"][@"goods_detail"] count] == 0) {
                
                [MBProgressHUD showError:@"没有数据"];
                return;
                
            }
            
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

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHome_GoodsDetailCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_GoodsDetailCellCell"];

    cell.selectionStyle = 0;
    
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

    //导航栏颜色渐变
    UIColor *color=[UIColor blackColor];
    CGFloat offset = scrollView.contentOffset.y - 40;
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
@end
