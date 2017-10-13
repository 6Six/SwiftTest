//
//  NSDictionary+Extension.h
//  ScreenShotBgPro
//
//  Created by GarryZhang on 2017/9/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)


/**
 字典转换为json

 @param dict 带转换的字段
 @return 转换后的json数据
 */
- (NSString *)convertToJsonData;

@end
