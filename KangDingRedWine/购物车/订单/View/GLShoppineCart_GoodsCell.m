//
//  GLShoppineCart_GoodsCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/10.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLShoppineCart_GoodsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GLShoppineCart_GoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;//图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名字
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;//描述
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//数量

@end

@implementation GLShoppineCart_GoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GLCart_OrderModel *)model {
    
    _model = model;
    self.nameLabel.text = _model.goods_name;
    self.detailLabel.text = _model.goods_info;
    self.priceLabel.text = _model.discount;
    self.countLabel.text = [NSString stringWithFormat:@"数量:%zd",_model.goods_num];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:[UIImage imageNamed:kGOODS_PlaceHolder]];
}

@end
