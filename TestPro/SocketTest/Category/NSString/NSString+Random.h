//
//  NSString+Random.h
//  CoreBusiness
//
//  Created by Junwu Wang on 5/16/14.
//  Copyright (c) 2014 Kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Random)

+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;

/**
 *  判断字符串是否全是数字
 *
 *  @param string 字符串
 *
 *  @return YES:是  NO:不是
 */
+ (BOOL)isPureNumandCharacters:(NSString *)string;

@end
