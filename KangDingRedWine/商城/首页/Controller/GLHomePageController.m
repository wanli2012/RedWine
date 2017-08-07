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

@end

@implementation GLHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _number = 4;
    _headerImageHeight = 200 * autoSizeScaleX; //banner 高度
    self.newsViewHeight.constant = 70 * autoSizeScaleX;
    self.cycleScrollViewHeight.constant = _headerImageHeight;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setHeaderView];
    
    [self.tableView registerClass:[GLHomePage_GoodsCell class] forCellReuseIdentifier:@"GLHomePage_GoodsCell"];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
   
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
     self.hidesBottomBarWhenPushed = YES;
    GLHome_GoodsDetailController *detailVC = [[GLHome_GoodsDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
            
        default:
        {
            return 4;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHomePage_GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHomePage_GoodsCell"];
    
    cell.number = _number;
    cell.delegate = self;
    cell.section = indexPath.section;
    
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

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
//    footerV.backgroundColor = [UIColor whiteColor];
//    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kSCREEN_WIDTH, 1)];
//    lineV.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    
//    [footerV addSubview:lineV];
//    
//    return footerV;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //确定图片宽高比为: 335:260 计算高度
    CGFloat width = (kSCREEN_WIDTH - 1) / 2 - 20;
    CGFloat height = width * 260 / 335 + 75;
    
    if(_number == 0){
        
        return 0;
        
    }else if(_number <= 2 && _number >0) {
        
        return height;
        
    }else if(_number > 2 && _number <= 4){
        
        return height * 2 ;
        
    }else{
        
        return height * 3 ;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 20;
//}
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
@end
