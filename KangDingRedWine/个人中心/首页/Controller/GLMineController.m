//
//  GLMineController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/28.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMineController.h"
#import "GLMineCollectionCell.h"
#import "HJCarouselViewLayout.h"
#import "GLMine_PersonInfoController.h"
#import "LBHarvestAddressListViewController.h"
#import "GLMine_OrderListController.h"
#import "GLMine_DonationListController.h"
#import "GLMine_AccountSafetyController.h"

@interface GLMineController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_titleArr;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//适配间距 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceHeight2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceHeight3;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名字Label
@property (weak, nonatomic) IBOutlet UILabel *myOrderLabel;//我的订单
@property (weak, nonatomic) IBOutlet UILabel *checkAllOrderLabel;//查看全部订单
@property (weak, nonatomic) IBOutlet UILabel *pendingPayLabel;//待付款
@property (weak, nonatomic) IBOutlet UILabel *toBeReceivedLabel;//待收货
@property (weak, nonatomic) IBOutlet UILabel *pendingEvaluationLabel;//待评价
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;//已完成

@property (weak, nonatomic) IBOutlet UIButton *mySuperiorBtn;//我的上级 按钮
@property (weak, nonatomic) IBOutlet UIButton *myJuniorBtn;//我的下级
@property (weak, nonatomic) IBOutlet UIButton *salesAcountBtn;//销售额

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pendingPayImageVWidth;//待付款图片宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toBeReceivedImageVWidth;//待收货图片宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pendingEvaluationImageVWidth;//待评价图片宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *completeImageVWidth;//已完成图片宽度

@end

@implementation GLMineController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self adaptUI];//适配UI
    
    _titleArr = @[@"理财积分",@"余额",@"余额4",@"余额3",@"余额2",@"1"];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GLMineCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"GLMineCollectionCell"];
    
    //自定义布局
    HJCarouselViewLayout *layout = nil;
    layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimCarousel];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100 * autoSizeScaleY, 100 * autoSizeScaleY);
    self.collectionView.collectionViewLayout = layout;
    
    

}

//适配UI
- (void)adaptUI{
    
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    self.contentViewHeight.constant = kSCREEN_HEIGHT - 64 - 49;
    self.topViewHeight.constant = 230 * autoSizeScaleY;
    
    self.collectionViewHeight.constant = 100 * autoSizeScaleY;
    self.middleViewHeight.constant = 80 * autoSizeScaleY;
    
    self.spaceHeight.constant = 15 * autoSizeScaleY;
    self.spaceHeight2.constant = self.spaceHeight.constant;
    self.spaceHeight3.constant = self.spaceHeight.constant;
    
    self.pendingEvaluationImageVWidth.constant = 30 *autoSizeScaleX;
    self.toBeReceivedImageVWidth.constant = self.pendingEvaluationImageVWidth.constant;
    self.pendingPayImageVWidth.constant = self.pendingEvaluationImageVWidth.constant;
    self.completeImageVWidth.constant = self.pendingEvaluationImageVWidth.constant;

    self.nameLabel.font = [UIFont systemFontOfSize:14 * autoSizeScaleX];
    self.myOrderLabel.font = [UIFont systemFontOfSize:15 * autoSizeScaleX];
    self.checkAllOrderLabel.font = [UIFont systemFontOfSize:13 * autoSizeScaleX];
    
    self.pendingPayLabel.font = [UIFont systemFontOfSize:13 * autoSizeScaleX];
    self.toBeReceivedLabel.font = [UIFont systemFontOfSize:13 * autoSizeScaleX];
    self.pendingEvaluationLabel.font = [UIFont systemFontOfSize:13 * autoSizeScaleX];
    self.completeLabel.font = [UIFont systemFontOfSize:13 * autoSizeScaleX];
    
    [self.mySuperiorBtn.titleLabel setFont:[UIFont systemFontOfSize:15 * autoSizeScaleY]];
    [self.myJuniorBtn.titleLabel setFont:[UIFont systemFontOfSize:15 * autoSizeScaleY]];
    [self.salesAcountBtn.titleLabel setFont:[UIFont systemFontOfSize:15 * autoSizeScaleY]];
    
}
//消息
- (IBAction)infomation:(id)sender {
    
    NSLog(@"消息");
    self.hidesBottomBarWhenPushed = YES;
    LBHarvestAddressListViewController *vc = [[LBHarvestAddressListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//设置界面
- (IBAction)set:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLMine_AccountSafetyController *set = [[GLMine_AccountSafetyController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

//个人信息
- (IBAction)personInfo:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLMine_PersonInfoController *personVC = [[GLMine_PersonInfoController alloc] init];
    [self.navigationController pushViewController:personVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

//全部订单
- (IBAction)allOrderList:(id)sender {
    NSLog(@"全部订单");
}

//四种订单界面
- (IBAction)pushToOrder:(UITapGestureRecognizer *)tap {
    
    NSLog(@"四种订单");
    
    self.hidesBottomBarWhenPushed = YES;
    
    switch (tap.view.tag) {
            
        case 11://待付款
        {
            GLMine_OrderListController *orderListVC = [[GLMine_OrderListController alloc] init];
            [self.navigationController pushViewController:orderListVC animated:YES];
        }
            break;
        case 12://待收货
        {
            
        }
            break;
        case 13://待评价
        {
            
        }
            break;
        case 14://已完成
        {
            
        }
            break;
            
        default:
            break;
    }
    self.hidesBottomBarWhenPushed = NO;
}

//我的上级
- (IBAction)pushToMySuperior:(id)sender {
    
}

//我的下级
- (IBAction)pushToMyJunior:(id)sender {
    
}

//销售额
- (IBAction)pushToSalesAcount:(id)sender {
    
    self.hidesBottomBarWhenPushed =YES;
    GLMine_DonationListController *donationVC = [[GLMine_DonationListController alloc] init];
    [self.navigationController pushViewController:donationVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}

- (NSIndexPath *)curIndexPath {
    
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *curIndexPath = nil;
    NSInteger curzIndex = 0;
    
    for (NSIndexPath *path in indexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:path];
        if (!curIndexPath) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
            continue;
        }
        
        if (attributes.zIndex > curzIndex) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
        }
    }
    
    return curIndexPath;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 
    return _titleArr.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GLMineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLMineCollectionCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 50 * autoSizeScaleY;
    cell.clipsToBounds = YES;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 2 * autoSizeScaleY;
    
    cell.titleLabel.text = _titleArr[indexPath.row];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *curIndexPath = [self curIndexPath];
    if (indexPath.row == curIndexPath.row) {
        return YES;
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];

    return NO;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"click %ld", indexPath.row);
    
}

@end
