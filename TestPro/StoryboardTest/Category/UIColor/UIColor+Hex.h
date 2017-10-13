//
//  UIColor+Hex.h
//  WeatherApp
//
//  Created by jason on 8/26/15.
//  Copyright (c) 2015 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)CardNiuDarkColor;

+ (UIColor *)CardNiuGrayColor;

+ (UIColor *)CardNiuLightGrayColor;

+ (UIColor *)CardNiuOrangeColor;

+ (UIColor *)colorWithHex:(uint)hex;

+ (UIColor*)colorWithHex:(uint)hex alpha:(CGFloat)alpha;

@end
