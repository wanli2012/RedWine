//
//  GLHome_ReSellingMallCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/31.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_ReSellingMallCell.h"
#import "GLHome_ResellingMallCollectionCell.h"

@interface GLHome_ReSellingMallCell ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation GLHome_ReSellingMallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLHome_ResellingMallCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GLHome_ResellingMallCollectionCell"];
    
}

#pragma mark UICollectionViewDelegate,dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.models.count;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHome_ResellingMallCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLHome_ResellingMallCollectionCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.models[indexPath.row];
//    cell.isSelected = self.isSelectedArr[indexPath.row];
    
    if ([self.isSelectedArr[indexPath.row] boolValue]) {
        
        cell.titleLabel.textColor =  YYSRGBColor(255, 50, 50, 1);//红色
        
    }else{
        cell.titleLabel.textColor = [UIColor whiteColor];
    }
    
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (kSCREEN_WIDTH - 1) / 3;
    CGFloat height = 40;
    
    return CGSizeMake(width, height);
    
}

//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.block(indexPath.row,self.models[indexPath.row]);

//    [self.isSelectedArr replaceObjectAtIndex:indexPath.row withObject:@(![self.isSelectedArr[indexPath.row] boolValue])];
//    
//    [self.collectionView reloadData];

    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    

//    [self.isSelectedArr replaceObjectAtIndex:indexPath.row withObject:@(NO)];
//    
//    [self.collectionView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


@end
