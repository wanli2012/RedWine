//
//  TableViewController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/8/10.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSString *cellName;

@end


@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (instancetype)initWithTableViewCell:(NSString *)cellName{
    
    if (self = [super init]) {
        
        self.cellName = cellName;
        
        [self.tableView registerNib:[UINib nibWithNibName:self.cellName bundle:nil] forCellReuseIdentifier:self.cellName];
    }

    return self;
}

#pragma mark UItableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellName];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
