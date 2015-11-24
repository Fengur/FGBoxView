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
#define BACKALPHA 0.5
#define ANITIME 0.2
#define WILDTEMP 2345
#import "UWOpenView.h"

@implementation UWOpenView {
    NSMutableArray *_allDataSoureArray;
    NSMutableArray *_listSourceArray;
    float _btnHeight;
    int btnIndex;
    float _originY;
    float _listY;
    float _boxViewWidth;
}

- (id)initWithFrame:(CGRect)frame
         titleArray:(NSMutableArray *)titleArray
        tableHeight:(float)tableHeight
     containerArray:(NSMutableArray *)containerArray {
    if (self = [super init]) {
        self.frame = frame;
        _originY = frame.origin.y;
        _listY = frame.size.height;
        self.titleArray = titleArray;
        self.tableHeight = tableHeight;
        _boxViewWidth = self.bounds.size.width;
        _btnHeight = frame.size.height;
        [self createBtnsWithTitleArray:titleArray];
        _allDataSoureArray = containerArray;
    }
    return self;
}

- (void)createBackGroundView {
    _backGroundView = [[UIView alloc]
        initWithFrame:CGRectMake(0, self.frame.size.height, _boxViewWidth, self.tableHeight)];
    _backGroundView.backgroundColor = [UIColor blackColor];
    _backGroundView.alpha = 0;
    UITapGestureRecognizer *tapGester =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetViews)];
    [_backGroundView addGestureRecognizer:tapGester];
    [self addSubview:_backGroundView];
}
- (void)createBtnsWithTitleArray:(NSMutableArray *)titleArray {
    for (int i = 0; i < titleArray.count; i++) {
        float bWidth = _boxViewWidth / titleArray.count;
        float bHeight = self.frame.size.height;
        _openBtn = [[UWBoxBtn alloc] initWithFrame:CGRectMake(bWidth * i, 0, bWidth, bHeight)];
        _openBtn.layer.cornerRadius = 5;
        [_openBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [_openBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        [_openBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateSelected];
        _openBtn.tag = KBTNTAG + i;
        _openBtn.selected = NO;
        [_openBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_openBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _openBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _openBtn.backgroundColor = [UIColor whiteColor];
        [_openBtn addTarget:self
                      action:@selector(openBtnClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_openBtn];
    }
}

- (void)openBtnClicked:(UIButton *)openBtn {
    btnIndex = (int)(openBtn.tag - KBTNTAG);
    if (btnIndex >= _allDataSoureArray.count) {
        _listSourceArray = [NSMutableArray arrayWithArray:@[@"暂无内容"]];
    } else {
        _listSourceArray = [[NSMutableArray alloc] initWithArray:_allDataSoureArray[btnIndex]];
    }
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
            [touchKey setInteger:WILDTEMP forKey:@"touchKey"];
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
            self.frame = CGRectMake(0, _originY, _boxViewWidth, ScreenHeight - _originY);
        }
        completion:^(BOOL finished) {
            if (!_listView) {
                [self createListView];
            } else {
                _listView.frame = CGRectMake(btnIndex * _boxViewWidth / _titleArray.count, _listY,
                                             _boxViewWidth / _titleArray.count, _tableHeight);
                [_listView reloadListDataSourceWithArray:_listSourceArray];
            }

        }];
}

- (void)createListView {
    _listView = [[UWOpenListView alloc]
        initWithFrame:CGRectMake(btnIndex * _boxViewWidth / _titleArray.count, _listY,
                                 _boxViewWidth / _titleArray.count, _tableHeight)
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

            self.frame = CGRectMake(0, _originY, _boxViewWidth, _btnHeight);
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
    NSUserDefaults *touchKey = [NSUserDefaults standardUserDefaults];
    [touchKey setInteger:WILDTEMP forKey:@"touchKey"];
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

- (UIColor *)randomColor {
    static BOOL seed = NO;
    if (!seed) {
        seed = YES;
        srandom(time(NULL));
    }
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
