//
//  LBShopingCarTableViewCell.m
//  KangDingRedWine
//
//  Created by 四川三君科技有限公司 on 2017/8/4.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBShopingCarTableViewCell.h"
#import "shopingModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LBShopingCarTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imagev;//商品图片
@property (weak, nonatomic) IBOutlet UIButton *selectedBt;//选中button
@property (weak, nonatomic) IBOutlet UILabel *infoLb;//描述
@property (weak, nonatomic) IBOutlet UILabel *priceLb;//价格
@property (weak, nonatomic) IBOutlet UILabel *numLb;//数量

@end

@implementation LBShopingCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imagev.layer.borderWidth = 1;
    self.imagev.layer.borderColor = YYSRGBColor(243, 243, 243, 1).CGColor;
   
}

//模型赋值
-(void)setModel:(shopingModel *)model{
    _model = model;
    
    self.selectedBt.selected = _model.isSelect;
    self.numLb.text = _model.num;
    self.infoLb.text = _model.info;
    self.priceLb.text = _model.goods_price;
    
    [self.imagev sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:[UIImage imageNamed:kGOODS_PlaceHolder]];
    
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
