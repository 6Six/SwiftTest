//
//  UIView+Layout.h
//  Layout
//
//  Created by jason on 9/20/14.
//  Copyright (c) 2014 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewBorder) {
    UIViewBorderLeftLine = 1000,
    UIViewBorderBottomLine ,
    UIViewBorderRightLine ,
    UIViewBorderTopLine ,
};

@interface UIView (Layout)

+ (CGRect)MainFrame;

- (CGFloat)left;
- (CGFloat)right;
- (CGSize)size;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGPoint)origin;


- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setSize:(CGSize)size;
- (void)setTop:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)setOrigin:(CGPoint)point;
- (void)setAddTop:(CGFloat)top;
- (void)setAddLeft:(CGFloat)left;


- (void)showLeftBorder;
- (void)showRightBorder;
- (void)showTopBorder;
- (void)showBottomBorder;

- (void)addLineWithFrame:(CGRect)frame border:(UIViewBorder)border;
- (void)addLineWithFrame:(CGRect)frame border:(UIViewBorder)border lineColor:(UIColor *)lineColor;
- (UITapGestureRecognizer *)addTapGestureWithTarget:(id)target action:(SEL)action;
- (void)addTapGestureWithAction:(SEL)action;
- (void)addBottomBorder;

@end
