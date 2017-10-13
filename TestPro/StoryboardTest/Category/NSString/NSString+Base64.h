//
//  NSString+Base64.h
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import <Foundation/NSString.h>

@interface NSString (Base64Additions)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

/**
 *  将普通字符串转换成base64字符串
 *  @param text 普通字符串
 *  @return base64字符串
 */
- (NSString *)base64StringFromText;

/**
 *  将base64字符串转换成普通字符串
 *  @param base64 base64字符串
 *  @return 普通字符串
 */
- (NSString *)textFromBase64String;

@end
