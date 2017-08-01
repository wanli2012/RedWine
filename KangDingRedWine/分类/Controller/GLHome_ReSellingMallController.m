//
//  GLHome_ReSellingMallController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/31.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_ReSellingMallController.h"
#import "GLHome_ReSellingMallCell.h"

@interface GLHome_ReSellingMallController ()<UITableViewDelegate,UITableViewDataSource>
{
//    NSArray *_titleArr;
//    
//    NSMutableArray *_isOpenArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)UIView *headerV;

@property (nonatomic, strong)NSArray *titleArr;

@property (nonatomic, strong)NSArray *titleArr2;

@property (nonatomic, strong)NSMutableArray *isOpenArr;

@property (nonatomic, strong)NSMutableArray *isSelectedArr;

@end

@implementation GLHome_ReSellingMallController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_ReSellingMallCell" bundle:nil] forCellReuseIdentifier:@"GLHome_ReSellingMallCell"];

}

- (void)more:(UITapGestureRecognizer *)tap{
    
    BOOL selectec = ![self.isOpenArr[tap.view.tag] boolValue];
    
    [self.isOpenArr replaceObjectAtIndex:tap.view.tag withObject:@(selectec)];

    //刷新一行
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:tap.view.tag], nil] withRowAnimation:UITableViewRowAnimationNone];

}

//去掉sectionHeader 跟随效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHome_ReSellingMallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_ReSellingMallCell"];
    
    if (indexPath.section == 0) {
        
        cell.models = self.titleArr;
        cell.isSelectedArr = self.isSelectedArr;
        
    }else{
        
        cell.models = self.titleArr2;
        cell.isSelectedArr = self.isSelectedArr;
    }
    
    cell.section = indexPath.section;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.collectionView reloadData];
    
    __weak __typeof(self)weakSelf = self;
    cell.block = ^(NSInteger index,NSString * name){
        
        NSLog(@"indexpath.row = %zd, cell = %@",index,name);
        
        for (int i = 0; i < self.isSelectedArr.count; i ++) {
            [weakSelf.isSelectedArr replaceObjectAtIndex:i withObject:@NO];
        }
        
        [weakSelf.isSelectedArr replaceObjectAtIndex:index withObject:@(![weakSelf.isSelectedArr[index] boolValue])];

        [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];

        
    };
    
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
    headerV.backgroundColor = [UIColor blackColor];
    headerV.tag = section;
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kSCREEN_WIDTH - 20, 1)];
    lineV.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 80, 30)];
    
    UIImage *img = [UIImage imageNamed:@"复消商城标题装饰"];
    img = [img stretchableImageWithLeftCapWidth:floorf(img.size.width /2 ) topCapHeight:floorf(img.size.height/2)];
    
    leftBtn.enabled = NO;
    
    [leftBtn setTitle:@"品牌" forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 20, 20, 10, 10)];

    imageV.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(more:)];
    [headerV addGestureRecognizer:tap];
    
    if(section != 0){
        
        [headerV addSubview:lineV];
        
    }
    
    [headerV addSubview:leftBtn];
    [headerV addSubview:imageV];
    
    return headerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rows = (self.titleArr.count - 1) / 3 + 1;
    
    if([self.isOpenArr[indexPath.section] boolValue]){
        
        return rows * 50;
        
    }else{
    
        return 2 * 50;
    }

    
    return rows * 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

#pragma mark lazy

- (UIView *)headerV{
    
    if (!_headerV) {
        _headerV = [[UIView alloc] init];
    }
    return _headerV;
}

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液"];
    }
    
    return _titleArr;
}
- (NSArray *)titleArr2{
    
    if (!_titleArr2) {
        
        _titleArr2 = @[@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液",@"康定红酒",@"五粮液"];
    }
    
    return _titleArr2;
}
- (NSMutableArray *)isSelectedArr{
    if (!_isSelectedArr) {
        _isSelectedArr = [NSMutableArray array];
        
        for (int i = 0; i < self.titleArr.count; i ++) {
            [_isSelectedArr addObject:@NO];
        }
    }
    return _isSelectedArr;
}

- (NSMutableArray *)isOpenArr{
    
    if (!_isOpenArr) {
        _isOpenArr = [NSMutableArray arrayWithObjects:@NO,@NO,@NO,@NO,@NO, nil];
    }
    return _isOpenArr;
}


@end
