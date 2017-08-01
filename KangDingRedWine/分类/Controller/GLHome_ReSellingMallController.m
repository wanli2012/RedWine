//
//  GLHome_ReSellingMallController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/31.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_ReSellingMallController.h"
#import "GLHome_ReSellingMallCell.h"
#import "GLHome_ResellingEnsurelCell.h"

@interface GLHome_ReSellingMallController ()<UITableViewDelegate,UITableViewDataSource,GLHome_ResellingEnsurelCellDelegate>
{
//    NSArray *_titleArr;
//    
//    NSMutableArray *_isOpenArr;
    
    NSString *_value;
    NSString *_value2;
    NSString *_value3;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)UIView *headerV;

@property (nonatomic, strong)NSArray *titleArr;

@property (nonatomic, strong)NSArray *titleArr2;

@property (nonatomic, strong)NSArray *titleArr3;

@property (nonatomic, strong)NSMutableArray *isSelectedArr;
@property (nonatomic, strong)NSMutableArray *isSelectedArr2;
@property (nonatomic, strong)NSMutableArray *isSelectedArr3;

@property (nonatomic, strong)NSMutableArray *isOpenArr;


@end

@implementation GLHome_ReSellingMallController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_ReSellingMallCell" bundle:nil] forCellReuseIdentifier:@"GLHome_ReSellingMallCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_ResellingEnsurelCell" bundle:nil] forCellReuseIdentifier:@"GLHome_ResellingEnsurelCell"];
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

- (void)ensure{

    NSLog(@"你点击确定了,你想干嘛,说 ---- %@,%@,%@",_value,_value2,_value3);
}

#pragma mark UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        
        GLHome_ResellingEnsurelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_ResellingEnsurelCell"];
        cell.delegate = self;
        return cell;
        
    }else{
        
        GLHome_ReSellingMallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_ReSellingMallCell"];
        
        if (indexPath.section == 0) {
            
            cell.models = self.titleArr;
            cell.isSelectedArr = self.isSelectedArr;
            
        }else if(indexPath.section == 1){
            
            cell.models = self.titleArr2;
            cell.isSelectedArr = self.isSelectedArr2;
        }else{
            cell.models = self.titleArr3;
            cell.isSelectedArr = self.isSelectedArr3;
        }
        
        //    cell.section = indexPath.section;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.collectionView reloadData];
        
        __weak __typeof(self)weakSelf = self;
        cell.block = ^(NSInteger index,NSString * name){
            
            NSLog(@"indexpath.row = %zd, cell = %@",index,name);
            
            if (indexPath.section == 0) {
      
                for (int i = 0; i < self.isSelectedArr.count; i ++) {
                    [weakSelf.isSelectedArr replaceObjectAtIndex:i withObject:@NO];
                }
                _value = weakSelf.titleArr[index];
                [weakSelf.isSelectedArr replaceObjectAtIndex:index withObject:@(![weakSelf.isSelectedArr[index] boolValue])];
                
            }else if(indexPath.section == 1){
                for (int i = 0; i < self.isSelectedArr2.count; i ++) {
                    [weakSelf.isSelectedArr2 replaceObjectAtIndex:i withObject:@NO];
                }
                _value2 = weakSelf.titleArr2[index];
                [weakSelf.isSelectedArr2 replaceObjectAtIndex:index withObject:@(![weakSelf.isSelectedArr[index] boolValue])];
            }else{
                for (int i = 0; i < self.isSelectedArr3.count; i ++) {
                    [weakSelf.isSelectedArr3 replaceObjectAtIndex:i withObject:@NO];
                }
                _value3 = weakSelf.titleArr3[index];
                [weakSelf.isSelectedArr3 replaceObjectAtIndex:index withObject:@(![weakSelf.isSelectedArr[index] boolValue])];
            }

            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        
        return cell;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section != 3) {
        
        UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
        headerV.backgroundColor = [UIColor blackColor];
        headerV.tag = section;
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kSCREEN_WIDTH - 20, 1)];
        lineV.backgroundColor = [UIColor whiteColor];
        
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 60, 30)];
        
        UIImage *img = [UIImage imageNamed:@"复消商城标题装饰白"];
        img = [img stretchableImageWithLeftCapWidth:floorf(img.size.width /2 ) topCapHeight:floorf(img.size.height/2)];
        [leftBtn setBackgroundImage:img forState:UIControlStateNormal];
        leftBtn.enabled = NO;
        
        if (section == 0) {
            
            [leftBtn setTitle:@"品牌" forState:UIControlStateNormal];
            
        }else if(section == 1){
            
            [leftBtn setTitle:@"价格" forState:UIControlStateNormal];
            
        }else if(section == 2){
            
            [leftBtn setTitle:@"种类" forState:UIControlStateNormal];

        }
        
        [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 25, 20, 15, 10)];
//        imageV.backgroundColor = [UIColor whiteColor];
        imageV.image = [UIImage imageNamed:@"三角向下"];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(more:)];
        [headerV addGestureRecognizer:tap];
        
        if(section != 0){
            
            [headerV addSubview:lineV];
            
        }
        
        [headerV addSubview:leftBtn];
        [headerV addSubview:imageV];
        
        return headerV;
        
    }else{
        
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rows = 0.0;
    
    if (indexPath.section == 0) {
        
        rows = (self.titleArr.count - 1) / 3 + 1;
        
    }else if(indexPath.section == 1){
        
        rows = (self.titleArr2.count - 1) / 3 + 1;
        
    }else if(indexPath.section == 2){
        
        rows = (self.titleArr3.count - 1) / 3 + 1;
        
    }else if (indexPath.section == 3) {
        
        return 50;
    }
    
    if([self.isOpenArr[indexPath.section] boolValue]){
        
        return rows * 50;
        
    }else{
    
        return 2 * 50;
    }

    
    return rows * 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section != 3) {
        
        return 50;
        
    }else{
        
        return 0;
    }
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
        
        _titleArr2 = @[@"0 ~ 500",@"500 ~ 800",@"800 ~ 1000",@"1000 ~ 2000",@"2000 ~ 5000",@"5000 ~ 10000",@"10000 ~ 20000"];
    }
    
    return _titleArr2;
}
- (NSArray *)titleArr3{
    
    if (!_titleArr3) {
        
        _titleArr3 = @[@"零食",@"麻将",@"生活用品",@"字画",@"矿产",@"首饰",@"古董"];
    }
    
    return _titleArr3;
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
- (NSMutableArray *)isSelectedArr2{
    
    if (!_isSelectedArr2) {
        _isSelectedArr2 = [NSMutableArray array];
        
        for (int i = 0; i < self.titleArr2.count; i ++) {
            
            [_isSelectedArr2 addObject:@NO];
        }
    }
    return _isSelectedArr2;
}
- (NSMutableArray *)isSelectedArr3{
    
    if (!_isSelectedArr3) {
        _isSelectedArr3 = [NSMutableArray array];
        
        for (int i = 0; i < self.titleArr3.count; i ++) {
            
            [_isSelectedArr3 addObject:@NO];
        }
    }
    return _isSelectedArr3;
}

- (NSMutableArray *)isOpenArr{
    
    if (!_isOpenArr) {
        _isOpenArr = [NSMutableArray arrayWithObjects:@NO,@NO,@NO, nil];
    }
    return _isOpenArr;
}


@end
