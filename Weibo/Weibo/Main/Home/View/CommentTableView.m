//
//  CommentTableView.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
@implementation CommentTableView

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
//    UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
//    [self registerNib:nib forCellReuseIdentifier:@"cell"];
    [self registerClass:[CommentCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - UITableViewDataSoure
//cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.commentModelArray.count;
//    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
//    NSLog(@"%@",self.commentModelArray);
    cell.commentModel = self.commentModelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITableViewDelegate
//设置tableView的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    WeiboViewLaoutFrame *layoutFrame = self.commentModelArray[indexPath.row];
//    CGRect frame = layoutFrame.frame;
//    CGFloat height = frame.size.height;
//    return height + 72;
    CommentModel *model = self.commentModelArray[indexPath.row];
    CGFloat height = [WXLabel getTextHeight:14 width:KWidth-55 text:model.text linespace:10.0f];
    return height +50;
}
//设置组的头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textColor = [UIColor blackColor];
    
    NSNumber *total = [self.commentDic objectForKey:@"total_number"];
    label.text = [NSString stringWithFormat:@"评论:%@",total];
    [sectionHeaderView addSubview:label];
    return sectionHeaderView;
}


@end
