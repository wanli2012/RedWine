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

@end

@implementation GLHome_GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_GoodsDetailCellCell" bundle:nil] forCellReuseIdentifier:@"GLHome_GoodsDetailCellCell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kPIC_HEIGHT, 0, 0, 0);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -kPIC_HEIGHT, kSCREEN_WIDTH + 1, kPIC_HEIGHT)];
    imageView.layer.masksToBounds = YES;
    
    imageView.image = [UIImage imageNamed:@"timg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.tag = 101;
    
    self.backBtn.layer.cornerRadius = 20.f;

    [self.tableView addSubview:imageView];

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
    //图片放大
    CGPoint point = scrollView.contentOffset;
    if (point.y < - kPIC_HEIGHT) {
        CGRect rect = [self.tableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:101].frame = rect;
    }
    
    //导航栏颜色渐变
    UIColor *color=[UIColor whiteColor];
    CGFloat offset = scrollView.contentOffset.y + 20;
    if (offset < 0) {
        self.navView.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha = 1-((64-offset)/64);
        self.navView.backgroundColor= [color colorWithAlphaComponent:alpha];
    }
    
}
@end
