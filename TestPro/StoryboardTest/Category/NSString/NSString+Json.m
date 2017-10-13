//
//  NSString+Json.m
//  ScreenShotBgPro
//
//  Created by GarryZhang on 2017/9/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import "NSString+Json.h"

@implementation NSString (Json)

- (NSDictionary *)dictionaryWithJsonString {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

@end
