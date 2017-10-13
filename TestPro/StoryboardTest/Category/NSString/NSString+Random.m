//
//  NSString+Random.m
//  CoreBusiness
//
//  Created by Junwu Wang on 5/16/14.
//  Copyright (c) 2014 Kingdee. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];

    if(string.length > 0)
    {
        return NO;
    }
    
    return YES;
}

@end
