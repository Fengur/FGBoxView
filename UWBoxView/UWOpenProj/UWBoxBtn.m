//
//  UWBoxBtn.m
//  UWBoxView
//
//  Created by 王智超 on 15/11/19.
//  Copyright © 2015年 com.FengurDev. All rights reserved.
//

#import "UWBoxBtn.h"
#import "UIView+NJ.h"
@implementation UWBoxBtn

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = self.width * 0.5 + 10;
    CGFloat imageY = 10;
    CGFloat imageW = self.width * 0.4 - 10;
    CGFloat imageH = self.height - 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)backgroundRectForBounds:(CGRect)bounds {
    CGFloat imageX = 22;
    CGFloat imageY = 8;
    CGFloat imageW = 20;
    CGFloat imageH = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 10;
    CGFloat titleY = 0;
    CGFloat titleW = self.width * 0.6 - 10;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
