//
//  UWOpenView.m
//  UWTestNav
//
//  Created by 王智超 on 15/11/18.
//  Copyright © 2015年 com.FengurDev. All rights reserved.
//

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define KBTNTAG 123
#define NAVHEIGHT 64
#define BACKALPHA 0.5
#define ANITIME 0.5
#import "UWOpenView.h"

@implementation UWOpenView {
    NSMutableArray *_allDataSoureArray;
    NSMutableArray *_listSourceArray;
    float _btnHeight;
    int btnIndex;
}

- (id)initWithFrame:(CGRect)frame
         titleArray:(NSMutableArray *)titleArray
        tableHeight:(float)tableHeight {
    if (self == [super init]) {
        self.frame = frame;
        self.titleArray = titleArray;
        self.tableHeight = tableHeight;
        _btnHeight = frame.size.height;
        [self createBtnsWithTitleArray:titleArray];
        [self createDataArrays];
    }
    return self;
}

- (void)createDataArrays {
    NSMutableArray *arr1 =
        [[NSMutableArray alloc] initWithObjects:@"1", @"11", @"111", @"1111", @"11111", nil];
    NSMutableArray *arr2 =
        [[NSMutableArray alloc] initWithObjects:@"2", @"22", @"222", @"2222", @"22222", nil];
    NSMutableArray *arr3 =
        [[NSMutableArray alloc] initWithObjects:@"3", @"33", @"333", @"3333", @"33333", nil];
    NSMutableArray *arr4 =
        [[NSMutableArray alloc] initWithObjects:@"4", @"44", @"444", @"4444", @"44444", nil];
    _allDataSoureArray = [[NSMutableArray alloc] initWithObjects:arr1, arr2, arr3, arr4, nil];
}

- (void)createBackGroundView {
    _backGroundView = [[UIView alloc]
        initWithFrame:CGRectMake(0, self.frame.size.height, ScreenWidth, self.tableHeight)];
    _backGroundView.backgroundColor = [UIColor blackColor];
    _backGroundView.alpha = 0;
    UITapGestureRecognizer *tapGester =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetViews)];
    [_backGroundView addGestureRecognizer:tapGester];
    [self addSubview:_backGroundView];
}
- (void)createBtnsWithTitleArray:(NSMutableArray *)titleArray {
    for (int i = 0; i < titleArray.count; i++) {
        float bWidth = ScreenWidth / titleArray.count;
        float bHeight = self.frame.size.height;
        _openBtn = [[UIButton alloc] init];
        [_openBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        _openBtn.tag = KBTNTAG + i;
        _openBtn.selected = NO;
        [_openBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_openBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _openBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _openBtn.backgroundColor = [UIColor purpleColor];
        _openBtn.frame = CGRectMake(bWidth * i, 0, bWidth, bHeight);
        [_openBtn addTarget:self
                      action:@selector(openBtnClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_openBtn];
    }
}

- (void)openBtnClicked:(UIButton *)openBtn {
    openBtn.selected = !openBtn.selected;
    btnIndex = openBtn.tag - KBTNTAG;
    _listSourceArray = [[NSMutableArray alloc] initWithArray:_allDataSoureArray[btnIndex]];
    NSUserDefaults *touchKey = [NSUserDefaults standardUserDefaults];
    NSInteger touchNum = [[touchKey objectForKey:@"touchKey"] integerValue];
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton *tempButton = [[UIButton alloc] init];
        tempButton = (UIButton *)[self viewWithTag:KBTNTAG + i];
        if (tempButton == openBtn) {
            openBtn.selected = YES;
        } else {
            tempButton.selected = NO;
        }
    }
    if (touchNum == 0) {
        [touchKey setInteger:openBtn.tag forKey:@"touchKey"];
        [self showBackgroundView];
    } else {
        if (openBtn.tag == touchNum) {
            openBtn.selected = NO;
            [self removeBackGroundView];
            [touchKey setInteger:2345 forKey:@"touchKey"];
        } else {
            [self showBackgroundView];
            [touchKey setInteger:openBtn.tag forKey:@"touchKey"];
        }
    }
}

- (void)showBackgroundView {
    [UIView animateWithDuration:ANITIME
        animations:^{
            if (!_backGroundView) {
                [self createBackGroundView];
            }
            self.backGroundView.alpha = BACKALPHA;
            self.backGroundView.hidden = NO;
            self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - NAVHEIGHT);
        }
        completion:^(BOOL finished) {
            if (!_listView) {
                [self createListView];
            } else {
                _listView.frame = CGRectMake(btnIndex * ScreenWidth / _titleArray.count, 40,
                                             ScreenWidth / _titleArray.count, _tableHeight);
                [_listView reloadListDataSourceWithArray:_listSourceArray];
            }

        }];
}

- (void)createListView {
    _listView = [[UWOpenListView alloc]
        initWithFrame:CGRectMake(btnIndex * ScreenWidth / _titleArray.count, 40,
                                 ScreenWidth / _titleArray.count, _tableHeight)
                Array:_listSourceArray];
    _listView.delegate = self;
    [self addSubview:_listView];
}

- (void)removeBackGroundView {
    [UIView animateWithDuration:ANITIME
        animations:^{
            [self.listView removeFromSuperview];
            self.listView = nil;
        }
        completion:^(BOOL finished) {
            [self.backGroundView removeFromSuperview];
            self.backGroundView = nil;
            self.frame = CGRectMake(0, 0, ScreenWidth, _btnHeight);
        }];
}

- (void)resetViews {
    [self removeBackGroundView];
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *tempButton = [[UIButton alloc] init];
        tempButton = (UIButton *)[self viewWithTag:KBTNTAG + i];
        tempButton.selected = NO;
    }
}

- (void)hasSelectWithString:(NSString *)selectString {
    UIButton *tempButton = [[UIButton alloc] init];
    tempButton = (UIButton *)[self viewWithTag:btnIndex + KBTNTAG];
    tempButton.selected = NO;
    [tempButton setTitle:selectString forState:UIControlStateNormal];
    [self removeBackGroundView];

    NSMutableArray *selectStringArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *tempButton = [[UIButton alloc] init];
        tempButton = (UIButton *)[self viewWithTag:KBTNTAG + i];
        [selectStringArray addObject:tempButton.titleLabel.text];
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(checkSelectArray:)]) {
        [self.delegate checkSelectArray:selectStringArray];
    }
}

@end
