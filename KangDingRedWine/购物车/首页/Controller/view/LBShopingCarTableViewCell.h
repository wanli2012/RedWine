//
//  LBShopingCarTableViewCell.h
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class shopingModel;

@protocol LBShopingCarTableViewCelldelegete <NSObject>

-(void)divideEvent:(int)num row:(NSInteger)row;
-(void)AddEvent:(int)num row:(NSInteger)row;
-(void)seletedEventRow:(NSInteger)row;

@end

@interface LBShopingCarTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagev;
@property (weak, nonatomic) IBOutlet UIButton *selectedBt;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *numLb;

@property(nonatomic,assign)id<LBShopingCarTableViewCelldelegete>  delegete;
@property(nonatomic,assign)NSInteger  row;
@property(nonatomic,strong)shopingModel  *model;

@end
