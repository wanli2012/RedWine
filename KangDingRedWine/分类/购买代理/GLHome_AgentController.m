//
//  GLHome_AgentController.m
//  KangDingRedWine
//
//  Created by 龚磊 on 2017/7/31.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_AgentController.h"
#import "GLHome_AgentCell.h"

@interface GLHome_AgentController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLHome_AgentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_AgentCell" bundle:nil] forCellReuseIdentifier:@"GLHome_AgentCell"];

}

#pragma mark UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHome_AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_AgentCell"];
    cell.selectionStyle = 0;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.estimatedRowHeight = 44;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    return tableView.rowHeight;
}

@end
