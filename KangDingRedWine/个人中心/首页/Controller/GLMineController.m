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


@interface GLMineController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_titleArr;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceHeight2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceHeight3;


@end

@implementation GLMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    self.contentViewHeight.constant = kSCREEN_HEIGHT;
    
    self.topViewHeight.constant = 240 * autoSizeScaleY;
    self.collectionView.height = 100 * autoSizeScaleY;
    self.middleViewHeight.constant = 80 * autoSizeScaleY;
    
    self.spaceHeight.constant = 10 * autoSizeScaleY;
    
    self.spaceHeight2.constant = self.spaceHeight.constant;
    self.spaceHeight3.constant = self.spaceHeight.constant;
    
    _titleArr = @[@"理财积分",@"余额",@"余额4",@"余额3",@"余额2",@"1"];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GLMineCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"GLMineCollectionCell"];
    
    HJCarouselViewLayout *layout = nil;

    layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimCarousel];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100, 100);
    self.collectionView.collectionViewLayout = layout;

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
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
    cell.layer.cornerRadius = 50.f;
    cell.clipsToBounds = YES;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 2.f;
    
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
