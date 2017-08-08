//
//  GLMine_DonationListCell.h
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLMine_DonationListCellDelegate <NSObject>

- (void)showReason:(NSInteger)index;

@end


@interface GLMine_DonationListCell : UITableViewCell

@property (nonatomic, weak)id <GLMine_DonationListCellDelegate> delegate;

@property (nonatomic, assign)NSInteger index;

@end
