//
//  LBAddHarvestAddressTableViewCell.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBAddHarvestAddressTableViewCell.h"
#import "UIButton+SetEdgeInsets.h"
#import "HarvestAddressModel.h"

@implementation LBAddHarvestAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.selectBt horizontalCenterImageAndTitle:5];

}

-(void)setModel:(HarvestAddressModel *)model{
    _model = model;
    self.nameLb.text = _model.name;
    self.phoneLb.text = _model.phone;
    self.adressLb.text = _model.address;
    self.selectBt.selected = _model.isSelect;
  
}

- (IBAction)clickdelete:(UIButton *)sender {
    [self.delegete deleteRow:self.row];
}

- (IBAction)clickmodify:(UIButton *)sender {
    
    [self.delegete modifyRow:self.row];
}
- (IBAction)clickSelected:(UIButton *)sender {
    
    _model.isSelect = !_model.isSelect;
    
    [self.delegete SetAsDefaultRow:self.row];
    
    
}

@end
