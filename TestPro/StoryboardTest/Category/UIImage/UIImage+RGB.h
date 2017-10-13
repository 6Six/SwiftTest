//
//  UIImage+RGB.h
//  ScreenShotBgPro
//
//  Created by GarryZhang on 2017/9/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RGB)


/**
 获取image的rgb数值

 @param image 图片数据
 @return rgb数据
 */
- (NSData *)getImageRGBData;

@end
