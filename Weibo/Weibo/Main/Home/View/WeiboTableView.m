//
//  WeiboTableView.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/22.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "DetailWeiboViewController.h"
@implementation WeiboTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self createTableView];
    }
    return self;
}
- (void)awakeFromNib {
    [self createTableView];
}
//创建tableView
- (void)createTableView {
    self.dataSource = self;
    self.delegate =self;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"cell"];
}
#pragma mark - UITableViewDataSoure
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layoutFrameArray.count;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    cell.layoutFrame = self.layoutFrameArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITableViewDelegate
//设置tableView的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    WeiboViewLaoutFrame *layoutFrame = self.layoutFrameArray[indexPath.row];
    CGRect frame = layoutFrame.frame;
    CGFloat height = frame.size.height;
    return height + 72;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailWeiboViewController *detailVc = [[DetailWeiboViewController alloc] init];
    UIViewController *vc = (UIViewController *)self.nextResponder.nextResponder;
    

    detailVc.layoutFrame = self.layoutFrameArray[indexPath.row];
        WeiboViewLaoutFrame *layoutFrame = self.layoutFrameArray[indexPath.row];
        WeiboModel *weiboModel = layoutFrame.weiboModel;
        detailVc.model = weiboModel;
    
    [vc.navigationController pushViewController:detailVc animated:YES];
}

@end
