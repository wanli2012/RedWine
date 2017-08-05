//
//  LBAddHarvestAddressTableViewCell.h
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HarvestAddressModel;


@protocol LBAddHarvestAddressTableViewCelldelegete <NSObject>

-(void)SetAsDefaultRow:(NSInteger)row;
-(void)deleteRow:(NSInteger)row;
-(void)modifyRow:(NSInteger)row;

@end

@interface LBAddHarvestAddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneLb;
@property (weak, nonatomic) IBOutlet UILabel *adressLb;
@property (weak, nonatomic) IBOutlet UIButton *selectBt;
@property (weak, nonatomic) IBOutlet UIButton *modifyBt;
@property (weak, nonatomic) IBOutlet UIButton *deleteBt;
@property (strong , nonatomic)HarvestAddressModel *model;

@property(nonatomic,assign)id<LBAddHarvestAddressTableViewCelldelegete>  delegete;
@property(nonatomic,assign)NSInteger  row;

@end
