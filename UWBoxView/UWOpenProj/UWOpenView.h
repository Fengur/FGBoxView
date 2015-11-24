//
//  UWOpenView.h
//  UWTestNav
//
//  Created by 王智超 on 15/11/18.
//  Copyright © 2015年 com.FengurDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UWOpenListView.h"
#import "UWBoxBtn.h"
@protocol UWOpenViewDelegate<NSObject>

- (void)checkSelectArray:(NSMutableArray *)selectStringArray;

@end
@interface UWOpenView : UIView

@property (nonatomic, strong) UIButton *openBtn;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UWOpenListView *listView;

@property (nonatomic, weak) id delegate;

@property (nonatomic, assign) float tableHeight;

- (id)initWithFrame:(CGRect)frame
         titleArray:(NSMutableArray *)titleArray
        tableHeight:(float)tableHeight
     containerArray:(NSMutableArray *)containerArray;

@end
