//
//  UIColor+Hex.m
//  WeatherApp
//
//  Created by jason on 8/26/15.
//  Copyright (c) 2015 jason. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(uint)hex {
    
    return [UIColor colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha {
    int red,green,blue;
    
    blue  = (hex  & 0x0000FF);
    green = ((hex & 0x00FF00) >> 8);
    red   = ((hex & 0xFF0000) >> 16);
    
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
    
}

+ (UIColor *)CardNiuDarkColor {
    return [UIColor colorWithHex:0x373737];
}

+ (UIColor *)CardNiuGrayColor {
	
    return [UIColor colorWithHex:0x757575];
}

+ (UIColor *)CardNiuLightGrayColor {
    return [UIColor colorWithHex:0xAAAAAA];
	
}

+ (UIColor *)CardNiuOrangeColor {
    return [UIColor colorWithHex:0xFF9251];
	
}


@end
