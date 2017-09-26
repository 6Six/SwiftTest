//
//  UIView+Layout.m
//  Layout
//
//  Created by jason on 9/20/14.
//  Copyright (c) 2014 jason. All rights reserved.
//

#import "UIView+Layout.h"
#import "UIColor+Hex.h"

@implementation UIView (Layout)

+ (CGRect)MainFrame
{
    return [UIScreen mainScreen].bounds;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right;
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)point
{
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)setAddTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y += top;
    self.frame = frame;
}

- (void)setAddLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x += left;
    self.frame = frame;
}

- (void)showLeftBorder
{
    if (![self checkBorderExistsWithUIViewBorder:UIViewBorderLeftLine]) {
        [self addLineWithFrame:CGRectMake(0, 0, 0.5, self.height) border:UIViewBorderLeftLine];
    }
}

- (void)showRightBorder
{
    if (![self checkBorderExistsWithUIViewBorder:UIViewBorderRightLine]) {
        [self addLineWithFrame:CGRectMake(self.width - 0.5, 0, 0.5, self.height) border:UIViewBorderRightLine];
    }
}
- (void)showTopBorder
{
    if (![self checkBorderExistsWithUIViewBorder:UIViewBorderTopLine]) {
        [self addLineWithFrame:CGRectMake(0, 0, self.width, 0.5) border:UIViewBorderTopLine];
    }
}
- (void)showBottomBorder
{
    if (![self checkBorderExistsWithUIViewBorder:UIViewBorderBottomLine]) {
        [self addLineWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5) border:UIViewBorderBottomLine];
    }
}

- (void)addBottomBorder
{
    [self addLineWithFrame:CGRectMake(0, self.bottom - 0.5, self.width, 0.5) border:UIViewBorderBottomLine];
}

- (void)addLineWithFrame:(CGRect)frame border:(UIViewBorder)border
{
    [self addLineWithFrame:frame border:border lineColor:[UIColor colorWithHex:0xe7e7e7]];
}

- (void)addLineWithFrame:(CGRect)frame border:(UIViewBorder)border lineColor:(UIColor *)lineColor
{
    if ([self checkBorderExistsWithUIViewBorder:border]) {
        return;
    }
    UIView *borderLine = [[UIView alloc] initWithFrame:frame];
    borderLine.tag = border;
    borderLine.backgroundColor = lineColor;
    [self addSubview:borderLine];
}

- (BOOL)checkBorderExistsWithUIViewBorder:(UIViewBorder)border {
    return [self viewWithTag:border] ? YES : NO;
//    NSArray *subviews = self.subviews;
//    for (UIView *view in subviews) {
//        if (view.tag == border) {
//            return YES;
//        }
//    }
//    return NO;
}

- (UITapGestureRecognizer *)addTapGestureWithTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapGR.numberOfTapsRequired    = 1;
    [self addGestureRecognizer:tapGR];
    return tapGR;
}

- (void)addTapGestureWithAction:(SEL)action {
    [self addTapGestureWithTarget:self action:action];
}

@end















