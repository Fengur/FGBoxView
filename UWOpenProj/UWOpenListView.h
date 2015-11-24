//
//  UWOpenListView.h
//  UWTestNav
//
//  Created by 王智超 on 15/11/19.
//  Copyright © 2015年 com.FengurDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UWOpenListViewDelegate<NSObject>

- (void)hasSelectWithString:(NSString *)selectString;

@end

@interface UWOpenListView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, weak) id delegate;

- (id)initWithFrame:(CGRect)frame Array:(NSMutableArray *)array;

- (void)reloadListDataSourceWithArray:(NSMutableArray *)array;

@end
