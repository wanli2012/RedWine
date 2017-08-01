//
//  GLHomePage_GoodsCell.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/28.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHomePage_GoodsCell.h"
#import "GLHome_GoodsCollectionViewCell.h"

@interface GLHomePage_GoodsCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GLHomePage_GoodsCell

- (void)awakeFromNib {
    
    [super awakeFromNib];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.collectionView];

    [self.collectionView registerNib:[UINib nibWithNibName:@"GLHome_GoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GLHome_GoodsCollectionViewCell"];
}


#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CGFloat width = (kSCREEN_WIDTH - 1) / 2;
    CGFloat height = (width - 20) * 260 / 335 + 75;
    if(_number == 0){
        
        _collectionView.height = 0;
    }else if(_number <= 2 && _number >0) {
        
        _collectionView.height = height;
        
    }else if(_number > 2 && _number <=4){
        
        _collectionView.height = height * 2;
        
    }else{
        
        _collectionView.height = height * 3;
    }
    
    return self.number;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GLHome_GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLHome_GoodsCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (kSCREEN_WIDTH - 1) / 2;
    CGFloat height = (width - 20) * 260 / 335 + 75;
    
    return CGSizeMake(width, height);
    
}

#pragma mark lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 155) collectionViewLayout:layout];
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
@end
