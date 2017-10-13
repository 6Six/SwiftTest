//
//  NSString+Parser.m
//  CardioCycleBT
//
//  Created by richinfo on 15/5/30.
//  Copyright (c) 2015年 com.garry.test. All rights reserved.
//

#import "NSString+Parser.h"

@implementation NSString (Parser)

- (NSString *)stringByReversed
{
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i=self.length; i>0; i--) {
        [s appendString:[self substringWithRange:NSMakeRange(i-1, 1)]];
    }
    return s;
}

- (NSData *)dataFromString
{
    NSInteger strLength = self.length;
    int j=0;
    Byte bytes[strLength];  ///3ds key的Byte 数组， 128位
    for(int index = 0; index < strLength; index++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [self characterAtIndex:index]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        
        if(hex_char1 >= '0' && hex_char1 <='9')
        {
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        }
        else if(hex_char1 >= 'A' && hex_char1 <='F')
        {
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        }
        else
        {
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        }
        
        index++;
        
        unichar hex_char2 = [self characterAtIndex:index]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
        {
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        }
        else if(hex_char2 >= 'A' && hex_char2 <='F')
        {
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        }
        else
        {
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        }
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:strLength / 2];
    
    return newData;
}

#pragma mark 十进制转换为十六进制
- (NSString *)toHexString
{
    NSString *hexString = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%02lx", (long)[self integerValue]]];
    return hexString;
}

#pragma mark 十六进制转换为十进制
- (NSString *)hexToDecimal
{
    long decimalNum = strtoul([self UTF8String], 0, 16);
    
    NSString *str = [NSString stringWithFormat:@"%ld", decimalNum];
    
    return str;
}

@end
