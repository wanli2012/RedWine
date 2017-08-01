
//
//  GLHome_ReSellingMallCell.h
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/31.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^block)(NSInteger indexPath,NSString *name);

@interface GLHome_ReSellingMallCell : UITableViewCell

@property (nonatomic, strong)NSArray *models;

@property (nonatomic, copy)block block;

@property (nonatomic, assign)NSInteger section;

@property (nonatomic, strong)NSMutableArray *isSelectedArr;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
