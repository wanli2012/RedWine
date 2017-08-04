//
//  LBShopingCarTableViewCell.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBShopingCarTableViewCell.h"
#import "shopingModel.h"

@implementation LBShopingCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imagev.layer.borderWidth = 1;
    self.imagev.layer.borderColor = YYSRGBColor(243, 243, 243, 1).CGColor;
   
}

-(void)setModel:(shopingModel *)model{
    _model = model;
    self.selectedBt.selected = _model.isSelect;
    self.numLb.text = _model.num;
    
}
//单选按钮
- (IBAction)clickSelectdButton:(UIButton *)sender {
    
    _model.isSelect = !_model.isSelect;
    [self.delegete seletedEventRow:self.row];
    
}
//减少
- (IBAction)clickdivideBt:(UIButton *)sender {
    
    if ([self.numLb.text intValue] <= 1) {
        return;
    }
    
    int  num = [self.numLb.text intValue];
    num--;
    
    _model.num = [NSString stringWithFormat:@"%d",num];
    
    [self.delegete divideEvent:num row:self.row];
    
}
//添加
- (IBAction)clickAddbt:(UIButton *)sender {
    
    int  num = [self.numLb.text intValue];
    num++;
    _model.num = [NSString stringWithFormat:@"%d",num];
    
    [self.delegete AddEvent:num row:self.row];
}

@end
