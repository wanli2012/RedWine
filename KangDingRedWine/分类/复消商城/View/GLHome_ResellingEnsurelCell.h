//
//  GLHome_ResellingEnsurelCell.h
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/1.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLHome_ResellingEnsurelCellDelegate <NSObject>

- (void)ensure;

@end

@interface GLHome_ResellingEnsurelCell : UITableViewCell

@property (nonatomic, weak)id <GLHome_ResellingEnsurelCellDelegate> delegate;

@end
