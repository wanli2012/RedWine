//
//  GLShoppingCart_OrderController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/5.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLShoppingCart_OrderController.h"
#import "GLShoppingCart_OrderCell.h"
#import "LBHarvestAddressListViewController.h"

@interface GLShoppingCart_OrderController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@property (weak, nonatomic) IBOutlet UIView *messageView;//留言view
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;//提交
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;//留言textView
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;//留言中的label
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;//合计


@end

@implementation GLShoppingCart_OrderController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"确认订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentViewWidth.constant = kSCREEN_WIDTH;
    self.contentViewHeight.constant = kSCREEN_HEIGHT - 64;
    
    self.messageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.messageView.layer.borderWidth = 1.f;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLShoppingCart_OrderCell" bundle:nil] forCellWithReuseIdentifier:@"GLShoppingCart_OrderCell"];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}
//更换地址
- (IBAction)changeAddress:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    LBHarvestAddressListViewController *addressListVC = [[LBHarvestAddressListViewController alloc] init];
    [self.navigationController pushViewController:addressListVC animated:YES];
    
}
//所有商品
- (IBAction)allGoods:(id)sender {
    NSLog(@"所有商品");
}
//快递配送
- (IBAction)express:(id)sender {
    NSLog(@"快递配送");
}
//发票信息
- (IBAction)billInfo:(id)sender {
    NSLog(@"发票信息");
}
//运费
- (IBAction)freight:(id)sender {
    NSLog(@"运费");
}

//提交
- (IBAction)submit:(id)sender {
    
    NSLog(@"提交订单");
    
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    self.messageLabel.hidden = YES;
    
    return YES;
}

#pragma UICollectionViewDelegate UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GLShoppingCart_OrderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLShoppingCart_OrderCell" forIndexPath:indexPath];
    
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 80);
}

@end
