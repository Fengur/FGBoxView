//
//  ViewController.m
//  UWBoxView
//
//  Created by 王智超 on 15/11/19.
//  Copyright © 2015年 com.FengurDev. All rights reserved.
//

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "ViewController.h"
#import "UWOpenView.h"
@interface ViewController ()<UWOpenViewDelegate> {
    NSMutableArray *_titleArray;
    NSMutableArray *_sexArray;
    NSMutableArray *_payArray;
    NSMutableArray *_placeArray;
    NSMutableArray *_timeArray;
    NSMutableArray *_containerArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [self setUpData];
    self.view.backgroundColor = [self randomColor];
    [super viewDidLoad];
    UWOpenView *openView = [[UWOpenView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 45)
                                                  titleArray:_titleArray
                                                 tableHeight:ScreenHeight - 64-45
                                              containerArray:_containerArray];
    openView.delegate = self;
    [self.view addSubview:openView];
}

#pragma mark:
#pragma mark : -- UWOpenViewDelegate

- (void)checkSelectArray:(NSMutableArray *)selectStringArray {
    for (id object in selectStringArray) {
        NSLog(@"选择结果:-- :%@", object);
    }
}

- (void)setUpData {
    _titleArray = [[NSMutableArray alloc] initWithObjects:@"性别", @"付费", @"地点",@"时间", nil];
    _sexArray = [[NSMutableArray alloc] initWithObjects:@"男", @"女", @"男女不限", @"中性", nil];
    _payArray = [[NSMutableArray alloc] initWithObjects:@"我付钱", @"你付钱", @"AA制", nil];
    _placeArray = [[NSMutableArray alloc] initWithObjects:@"中南海", @"蝴蝶谷", @"老君山",
                                                          @"扭曲丛林", @"死亡之塔", nil];
    _timeArray = [[NSMutableArray alloc] initWithObjects:@"周一", @"周二", @"周三", @"周四",
                                                         @"周五", @"周六", @"周日", nil];
    _containerArray =
        [[NSMutableArray alloc] initWithObjects:_sexArray, _payArray, _placeArray, _timeArray, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
