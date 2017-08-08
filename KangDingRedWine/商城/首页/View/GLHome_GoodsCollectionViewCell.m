//
//  GLHome_GoodsCollectionViewCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/28.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_GoodsCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GLHome_GoodsCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;//商品图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//商品名字
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//销量

@end

@implementation GLHome_GoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GLHome_GoodsModel *)model{
    _model = model;
    self.nameLabel.text = model.goods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.discount];
    self.countLabel.text = [NSString stringWithFormat:@"销量:%@",model.salenum];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    
}
@end
