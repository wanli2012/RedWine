//
//  GLHomePageController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/28.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHomePageController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "GLHomePage_GoodsCell.h"
#import "GLHomePage_AllController.h"
#import "GLHome_GoodsDetailController.h"
#import "GLHome_GoodsModel.h"


@interface GLHomePageController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,GLHomePage_GoodsCellDelegate>
{
    CGFloat _headerImageHeight;
    NSInteger _number;
    CGFloat _headerHeight;
    
    //测试数据
    NSArray *_imageArr;
    NSArray *_titleArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *headerV;
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cycleScrollViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *newsViewHeight;//头条部分高度

@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel2;

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;

@property (nonatomic, strong)NSMutableArray *models;

@property (nonatomic, strong)NSArray *goodsArr;//四部分的所有数据

@end

@implementation GLHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerImageHeight = 200 * autoSizeScaleX; //banner 高度
    self.newsViewHeight.constant = 70 * autoSizeScaleX;
    self.cycleScrollViewHeight.constant = _headerImageHeight;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setHeaderView];
    
    [self.tableView registerClass:[GLHomePage_GoodsCell class] forCellReuseIdentifier:@"GLHomePage_GoodsCell"];


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
    [NetworkManager requestPOSTWithURLStr:SHOPMAIN paramDic:@{} finish:^(id responseObject) {
        
        [self endRefresh];
        [self.loadV removeloadview];
        
        if([responseObject[@"code"] integerValue] == 1){
            
            if ([responseObject[@"data"] count] == 0) {
                [MBProgressHUD showError:@"没有数据"];
                return;
            }
            
            for (NSDictionary *dict in responseObject[@"data"][@"goods"]) {
                
                NSMutableArray *models = [NSMutableArray array];
                
                for (NSDictionary *dic in dict[@"datas"]) {
                    
                    GLHome_GoodsModel *model = [GLHome_GoodsModel mj_objectWithKeyValues:dic];
                    [models addObject:model];
                    
                }
                
                [self.models addObject:models];
                
            }
            
            self.goodsArr = responseObject[@"data"][@"goods"];
            
            self.newsLabel.text = responseObject[@"data"][@"header"][0][@"content"];
            self.newsLabel2.text = responseObject[@"data"][@"header"][1][@"content"];
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

//设置headerView
- (void)setHeaderView {
    
    NSInteger number = 4;//总个数
    NSInteger rowCount = 4;//一行的个数
    CGFloat width = 50 * autoSizeScaleX;
    CGFloat height = 100 * autoSizeScaleX;
    CGFloat space = (kSCREEN_WIDTH - rowCount * width ) / rowCount;//间距
    
    [self.headerV addSubview:self.cycleScrollView];
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    
    self.newsLabel.font = [UIFont systemFontOfSize:12 * autoSizeScaleX];
    self.newsLabel2.font = [UIFont systemFontOfSize:12 * autoSizeScaleX];
    
    if (number <= rowCount) {
        
        self.contentViewHeight.constant = height;
        self.scrollViewHeight.constant = height;

    }else if (number > rowCount && number <= rowCount * 2) {
        
        self.contentViewHeight.constant = 2 * height;
        self.scrollViewHeight.constant =  2 * height;
        
    }else if(number > rowCount * 2 && number < rowCount * 3){
        
        self.contentViewHeight.constant = 3 * height;
        self.scrollViewHeight.constant = 3 * height;

    }
    
    _headerHeight = _headerImageHeight + self.contentViewHeight.constant + self.newsViewHeight.constant;
    self.headerV.height = _headerHeight;
    
    _imageArr = @[@"购买代理",@"复销商城",@"酒劵兑换",@"私人订制",@"购买代理",@"复销商城",@"酒劵兑换",@"私人订制"];
    _titleArr = @[@"购买代理",@"复销商城",@"酒劵兑换",@"私人订制",@"购买代理",@"复销商城",@"酒劵兑换",@"私人订制"];
    
    for (int i = 0; i < number; i ++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(space /2 + i % rowCount * (space + width), 0 + (i / rowCount) % 2 * height, width, height)];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, width, width)];
        imageV.image = [UIImage imageNamed:_imageArr[i]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame) + 10, width, 20)];
        label.text = _titleArr[i];
        label.font = [UIFont systemFontOfSize:12 * autoSizeScaleX];
        label.textColor = [UIColor darkGrayColor];
        
        [view addSubview:imageV];
        [view addSubview:label];
        
        [self.contentV addSubview:view];
    }

}

//全部分类
- (IBAction)allClassify:(id)sender {
   
     self.hidesBottomBarWhenPushed = YES;
    GLHomePage_AllController * allVC = [[GLHomePage_AllController alloc] init];
    [self.navigationController pushViewController:allVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}

//更多
- (void)more:(UITapGestureRecognizer *)tap {
    
    switch (tap.view.tag) {
        case 0:
        {
            NSLog(@"%@",_titleArr[tap.view.tag]);
        }
            break;
        case 1:
        {
            NSLog(@"%@",_titleArr[tap.view.tag]);
        }
            break;
        case 2:
        {
            NSLog(@"%@",_titleArr[tap.view.tag]);
        }
            break;
        case 3:
        {
            NSLog(@"%@",_titleArr[tap.view.tag]);
            
        }
            break;
            
        default:
            break;
    }
}

//商品详情
- (void)didSelectedItem:(NSInteger)section row:(NSInteger)row{
    
    GLHome_GoodsModel *model = self.models[section][row];
    
     self.hidesBottomBarWhenPushed = YES;
    
    GLHome_GoodsDetailController *detailVC = [[GLHome_GoodsDetailController alloc] init];
    detailVC.goodsID = model.goods_id;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.goodsArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.goodsArr.count ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHomePage_GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHomePage_GoodsCell"];

    cell.delegate = self;
    
    cell.index= indexPath.section;
    
    cell.models = self.models[indexPath.section];

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
    headerV.backgroundColor = [UIColor whiteColor];
    headerV.tag = section;
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kSCREEN_WIDTH - 20, 1)];
    lineV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *lineV2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kSCREEN_WIDTH - 20, 1)];
    lineV2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 80, 30)];
    
    UIImage *img = [UIImage imageNamed:@"复消商城标题装饰"];
    img = [img stretchableImageWithLeftCapWidth:floorf(img.size.width /2 ) topCapHeight:floorf(img.size.height/2)];

    leftBtn.enabled = NO;
    
    [leftBtn setBackgroundImage:img forState:UIControlStateNormal];
    [leftBtn setTitle:_titleArr[section] forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 90, 20, 80, 30)];
    label.text = @"查看更多";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentRight;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(more:)];
    [headerV addGestureRecognizer:tap];
    
    if(section != 0){
        
        [headerV addSubview:lineV2];
    }
    
    [headerV addSubview:leftBtn];
    [headerV addSubview:label];
    
    return headerV;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //确定图片宽高比为: 335:260 计算高度
    CGFloat width = (kSCREEN_WIDTH - 1) / 2 - 20;
    CGFloat height = width * 260 / 335 + 75;
    
    return height;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark lazy

-(SDCycleScrollView*)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, _headerImageHeight)
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
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}


@end
