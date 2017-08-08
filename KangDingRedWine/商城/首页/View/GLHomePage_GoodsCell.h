//
//  GLHomePage_GoodsCell.h
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/28.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLHomePage_GoodsCellDelegate <NSObject>

- (void)didSelectedItem:(NSInteger )section row:(NSInteger)row;

@end

@interface GLHomePage_GoodsCell : UITableViewCell

@property (nonatomic, weak)id <GLHomePage_GoodsCellDelegate> delegate;

//@property (nonatomic, assign)NSInteger number;

@property (nonatomic, assign)NSInteger index;

//@property (nonatomic, assign)NSInteger row;

@property (nonatomic, copy)NSArray *models;

@end
