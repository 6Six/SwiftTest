//
//  NSData-AES.h
//  CoreBusiness
//
//  Created by Sammy Zheng on 11-1-10.
//  Copyright 2011 Kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (AES128)

- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData *)AES128EncryptWithKey:(NSString *)key andIv:(NSString *)iv;
- (NSData *)AES128DecryptWithKey:(NSString *)key;
- (NSData *)AES128DecryptWithKey:(NSString *)key andIv:(NSString *)iv;

@end
