//
//  GLHome_GoodsDetailController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/2.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_GoodsDetailController.h"
#import "GLHome_GoodsDetailCellCell.h"

#define kPIC_HEIGHT  200

@interface GLHome_GoodsDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;

@property (weak, nonatomic) IBOutlet UIView *acountView;//销量View

@end

@implementation GLHome_GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"商品详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_GoodsDetailCellCell" bundle:nil] forCellReuseIdentifier:@"GLHome_GoodsDetailCellCell"];

}

- (void)setUI{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.acountView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(13, 13)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.acountView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.acountView.layer.mask = maskLayer;

//    
//    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 100, kPIC_HEIGHT + 13, 100, 26)];
//    accountView.backgroundColor = [UIColor blackColor];
//    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 20, 20)];
//    imageV.image = [UIImage imageNamed:@"火"];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 3, 60, 20)];
//    label.text = @"销量:100";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:12 * autoSizeScaleX];
//    
//    [accountView addSubview:imageV];
//    [accountView addSubview:label];
    
    
//    self.tableView.contentInset = UIEdgeInsetsMake(kPIC_HEIGHT, 0, 0, 0);
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -kPIC_HEIGHT, kSCREEN_WIDTH + 1, kPIC_HEIGHT)];
//    imageView.layer.masksToBounds = YES;
//    
//    imageView.image = [UIImage imageNamed:@"timg"];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.tag = 101;
//    
//    self.backBtn.layer.cornerRadius = 20.f;
//    
//    [imageView addSubview:accountView];
//    [self.tableView addSubview:imageView];
    
//    [self.headerView addSubview:accountView];
    
//    self.navView.backgroundColor = [UIColor blackColor];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHome_GoodsDetailCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_GoodsDetailCellCell"];
    
    cell.selectionStyle = 0;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    
    return tableView.rowHeight;
}

//滚动代理事件 图片放大 以及 导航栏颜色渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    //图片放大
//    CGPoint point = scrollView.contentOffset;
//    if (point.y < - kPIC_HEIGHT) {
//        CGRect rect = self.headerImageV.frame;
//        rect.origin.y = point.y;
//        rect.size.height = -point.y;
//        self.headerImageV.frame = rect;
//    }
//    
    //导航栏颜色渐变
    UIColor *color=[UIColor blackColor];
    CGFloat offset = scrollView.contentOffset.y - 40;
    if (offset < 0) {
        
        self.navView.backgroundColor = [color colorWithAlphaComponent:0];
        self.acountView.x = kSCREEN_WIDTH - 100;
        
    }else {
        
        CGFloat alpha = 1-((64-offset)/64);
        self.navView.backgroundColor= [color colorWithAlphaComponent:alpha];
        self.acountView.x = kSCREEN_WIDTH - 100 + offset;
        
    }
    
}
@end
