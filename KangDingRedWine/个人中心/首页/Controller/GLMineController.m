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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GLMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
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
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GLMineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLMineCollectionCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 50.f;
    cell.clipsToBounds = YES;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 2.f;
  
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *curIndexPath = [self curIndexPath];
    if (indexPath.row == curIndexPath.row) {
        return YES;
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
        HJCarouselViewLayout *layout = (HJCarouselViewLayout *)collectionView.collectionViewLayout;
        CGFloat cellHeight = layout.itemSize.height;
        CGRect visibleRect = CGRectZero;
        if (indexPath.row > curIndexPath.row) {
            visibleRect = CGRectMake(0, cellHeight * indexPath.row + cellHeight / 2, CGRectGetWidth(collectionView.frame), cellHeight / 2);
        } else {
            visibleRect = CGRectMake(0, cellHeight * indexPath.row, CGRectGetWidth(collectionView.frame), CGRectGetHeight(collectionView.frame));
        }
        [self.collectionView scrollRectToVisible:visibleRect animated:YES];
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld", indexPath.row);
}

@end
