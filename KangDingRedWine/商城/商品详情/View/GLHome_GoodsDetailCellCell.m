//
//  GLHome_GoodsDetailCellCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/2.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_GoodsDetailCellCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GLHome_GoodsDetailCellCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation GLHome_GoodsDetailCellCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GLHome_GoodsCommentModel *)model{
    _model = model;
    self.nameLabel.text = _model.user_name;
    self.contentLabel.text = _model.comment;
    [self.picImageV sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:kPic_HolderImage]];
    
}

@end
