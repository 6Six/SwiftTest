//
//  NSString+AES.h
//  CoreBusiness
//
//  Created by Sammy Zheng on 11-1-10.
//  Copyright 2011 Kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringAES)

- (NSString *)AES128EncryptWithKey:(NSString *)key;
- (NSString *)AES128EncryptWithKey:(NSString *)key andIv:(NSString *)iv;
- (NSString *)Base64AES128EncryptWithKey:(NSString *)key andIv:(NSString *)iv;

- (NSString *)AES128DecryptWithKey:(NSString *)key;
- (NSString *)AES128DecryptWithKey:(NSString *)key andIv:(NSString *)iv;
- (NSString *)Base64AES128DecryptWithKey:(NSString *)key andIv:(NSString *)iv;
@end
