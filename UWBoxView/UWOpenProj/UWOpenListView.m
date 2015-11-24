//
//  UWOpenListView.m
//  UWTestNav
//
//  Created by 王智超 on 15/11/19.
//  Copyright © 2015年 com.FengurDev. All rights reserved.
//

#define PartLineHeight 1
#define PartLineColor [UIColor blackColor]
#define TextClolr [UIColor blackColor]
#define TextFont [UIFont systemFontOfSize:10.f]
#define TopPartLineColor [UIColor redColor]
#define CellHeight 35
#define HeaderHeight 2
#import "UWOpenListView.h"

@implementation UWOpenListView {
    UITableView *_listTableView;
    UIView *_topView;
}

- (id)initWithFrame:(CGRect)frame Array:(NSMutableArray *)array {
    if (self = [super init]) {
        self.frame = frame;
        self.sourceArray = array;
        [self createTableView];
    }
    return self;
}

- (void)createTableView {
    _listTableView = [[UITableView alloc]
        initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_listTableView];
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, HeaderHeight)];
    _topView.backgroundColor = TopPartLineColor;
    _listTableView.tableHeaderView = _topView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellString = @"cellString";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:cellString];
    cell.textLabel.text = self.sourceArray[indexPath.row];
    cell.backgroundColor = [self randomColor];
    cell.layer.cornerRadius = 2.f;
    cell.textLabel.font = TextFont;
    UIView *partLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CellHeight-PartLineHeight, self.frame.size.width, PartLineHeight)];
    partLineView.backgroundColor = PartLineColor;
    [cell addSubview:partLineView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_listTableView removeFromSuperview];
    _listTableView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(hasSelectWithString:)]) {
        [self.delegate hasSelectWithString:_sourceArray[indexPath.row]];
    }
}
- (void)reloadListDataSourceWithArray:(NSMutableArray *)array {
    self.sourceArray = array;
    [_listTableView reloadData];
}

- (UIColor *)randomColor{
    static BOOL seed = NO;
    if (!seed) {
        seed = YES;
        srandom(time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
