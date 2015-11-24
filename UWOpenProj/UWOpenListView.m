//
//  UWOpenListView.m
//  UWTestNav
//
//  Created by 王智超 on 15/11/19.
//  Copyright © 2015年 com.FengurDev. All rights reserved.
//

#import "UWOpenListView.h"

@implementation UWOpenListView {
    UITableView *_listTableView;
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
    _listTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_listTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
    cell.backgroundColor = [UIColor yellowColor];
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
@end
