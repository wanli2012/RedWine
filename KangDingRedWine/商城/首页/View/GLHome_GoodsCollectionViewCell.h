//
//  GLHome_GoodsCollectionViewCell.h
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/28.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLHome_GoodsModel.h"
#import "GLHome_agentModel.h"

@interface GLHome_GoodsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)GLHome_GoodsModel *model;

@property (nonatomic, strong)GLHome_agentModel *agentModel;

@end
