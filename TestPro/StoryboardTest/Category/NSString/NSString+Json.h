//
//  NSString+Json.h
//  ScreenShotBgPro
//
//  Created by GarryZhang on 2017/9/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Json)

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString;

@end
