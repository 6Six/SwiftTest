//
//  NSString+AES.m
//  CoreBusiness
//
//  Created by Sammy Zheng on 11-1-10.
//  Copyright 2011 Kingdee. All rights reserved.
//

#import "NSString+AES.h"
#import "NSData+AES.h"
#import "NSData+Base64.h"
#import "EncryptionUtil.h"
#import "NSData+KPBase64.h"

#import <stdio.h>
#import <stdlib.h>
#import <string.h>

unsigned char strToChar (char a, char b)
{
    char encoder[3] = {'\0','\0','\0'};
    encoder[0] = a;
    encoder[1] = b;
    return (char) strtol(encoder,NULL,16);
}

@implementation NSString (NSStringAES)

- (NSData *) decodeFromHexidecimal;
{
    const char * bytes = [self cStringUsingEncoding: NSUTF8StringEncoding];
    NSUInteger length = strlen(bytes);
    unsigned char * r = (unsigned char *) malloc(length / 2 + 1);
    unsigned char * index = r;
	
    while ((*bytes) && (*(bytes +1))) {
        *index = strToChar(*bytes, *(bytes +1));
        index++;
        bytes+=2;
    }
    *index = '\0';
	
    NSData * result = [NSData dataWithBytes: r length: length / 2];
    free(r);
	
    return result;
}


- (NSString *)AES128EncryptWithKey:(NSString *)key {
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSData *entryptedData =[data AES128EncryptWithKey:key];
	NSString *encryptString = [NSData HexValue:entryptedData];
	return encryptString;
}


- (NSString *)AES128EncryptWithKey:(NSString *)key andIv:(NSString *)iv {
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSData *encryptedData =[data AES128EncryptWithKey:key andIv:iv];
	NSString *encryptString = [NSData HexValue:encryptedData];
	return encryptString;
}

- (NSString *)Base64AES128EncryptWithKey:(NSString *)key andIv:(NSString *)iv
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [data AES128EncryptWithKey:key andIv:iv];
    NSString *encryptedString = [encryptedData base64EncodedString];
    return encryptedString;
}

- (NSString *)AES128DecryptWithKey:(NSString *)key {
	NSData *data = [self decodeFromHexidecimal];
	NSData *decryptedData = [data AES128DecryptWithKey:key];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

- (NSString *)AES128DecryptWithKey:(NSString *)key andIv:(NSString *)iv {
	NSData *data = [self decodeFromHexidecimal];
	NSData *decryptedData = [data AES128DecryptWithKey:key andIv:iv];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

- (NSString *)Base64AES128DecryptWithKey:(NSString *)key andIv:(NSString *)iv
{
    NSData *data = [NSData dataFromBase64String:self];
    NSData *decryptedData = [data AES128DecryptWithKey:key andIv:iv];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}
@end
