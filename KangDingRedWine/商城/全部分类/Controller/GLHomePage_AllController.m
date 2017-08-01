//
//  GLHomePage_AllController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/1.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHomePage_AllController.h"
#import "GLHomePage_AllOneCell.h"
#import "GLHomePage_AllTwoCell.h"

@interface GLHomePage_AllController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (weak, nonatomic) IBOutlet UIButton *styleBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong)UICollectionViewFlowLayout *tableFlowLayout;
@property (nonatomic, strong)UICollectionViewFlowLayout *collectionFlowyout;


@property (nonatomic, assign)BOOL isTable;

@end

@implementation GLHomePage_AllController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;// 推荐使用
    [self.defaultBtn setTitle:@"默认" forState:UIControlStateNormal];
    [self.defaultBtn setImage:[UIImage imageNamed:@"三角向下筛选"] forState:UIControlStateNormal];
    
    [self.countBtn setTitle:@"销量" forState:UIControlStateNormal];
    [self.countBtn setImage:[UIImage imageNamed:@"三角向下筛选"] forState:UIControlStateNormal];
    
    [self.priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    [self.priceBtn setImage:[UIImage imageNamed:@"三角向下筛选"] forState:UIControlStateNormal];
    
    [self.filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [self.filterBtn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];

    [self.styleBtn setImage:[UIImage imageNamed:@"列表式"] forState:UIControlStateNormal];

    [self refreshTheTopBtn];
    
//    self.isTable = YES;
    [self changeStyle:self.styleBtn];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLHomePage_AllOneCell" bundle:nil] forCellWithReuseIdentifier:@"GLHomePage_AllOneCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLHomePage_AllTwoCell" bundle:nil] forCellWithReuseIdentifier:@"GLHomePage_AllTwoCell"];
    
}

//刷新图文位置  (顶部按钮)
- (void)refreshTheTopBtn {
    
    [self setTopButton:self.defaultBtn];
    [self setTopButton:self.countBtn];
    [self setTopButton:self.priceBtn];
    [self setTopButton:self.filterBtn];
    
}

- (void)setTopButton:(UIButton *)btn {
    
    CGFloat imageWidth = btn.imageView.bounds.size.width + 2;
    CGFloat labelWidth = btn.titleLabel.bounds.size.width + 2;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
}

//改变显示样式
- (IBAction)changeStyle:(UIButton *)sender {
    
    self.isTable = !self.isTable;
    
    if (!self.isTable) {
        
        [self.collectionView setCollectionViewLayout:self.collectionFlowyout];
        
    }else{
        
        [self.collectionView setCollectionViewLayout:self.tableFlowLayout];

    }
    
    self.collectionView.mj_offsetY = 0;
    [self.collectionView reloadData];
    
}

//返回
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 8;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.isTable) {
        
        GLHomePage_AllTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLHomePage_AllTwoCell" forIndexPath:indexPath];
        
        return cell;
        
    }else{
        
        GLHomePage_AllOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLHomePage_AllOneCell" forIndexPath:indexPath];
        return cell;
    }
    
}

-(UICollectionViewFlowLayout *)tableFlowLayout{
    
    if (_tableFlowLayout == nil) {
        
        _tableFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _tableFlowLayout.itemSize = CGSizeMake(kSCREEN_WIDTH, 120);
        
        _tableFlowLayout.minimumInteritemSpacing = 0;
        
        _tableFlowLayout.minimumLineSpacing = 0;
        
        [_tableFlowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    
    return _tableFlowLayout;
    
}

-(UICollectionViewFlowLayout *)collectionFlowyout{
    
    if (_collectionFlowyout == nil) {
        
        _collectionFlowyout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionFlowyout.itemSize = CGSizeMake(kSCREEN_WIDTH * 0.5 - 15, 180);
        
        _collectionFlowyout.minimumLineSpacing = 10;
        
        _collectionFlowyout.minimumInteritemSpacing = 10;
        
        [_collectionFlowyout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        
    }
    
    return _collectionFlowyout;
    
}



@end
