//
//  NSData-AES.m
//  CoreBusiness
//
//  Created by Sammy Zheng on 11-1-10.
//  Copyright 2011 Kingdee. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AES128)


- (NSData *)AES128EncryptWithKey:(NSString *)key {
    return [self AES128EncryptWithKey:key andIv:nil];
}

- (NSData *)AES128EncryptWithKey:(NSString *)key andIv:(NSString *)iv {
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused) // oorspronkelijk 256
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    if(iv) {
        bzero(ivPtr, sizeof(ivPtr));
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }
	
	NSUInteger dataLength = [self length];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
    CCOptions options = iv ? (kCCOptionPKCS7Padding) : (kCCOptionPKCS7Padding | kCCOptionECBMode);
    
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
										  kCCAlgorithmAES128,
										  options,
										  keyPtr,
										  kCCKeySizeAES128, // oorspronkelijk 256
										  iv ? ivPtr : NULL /* initialization vector (optional) */,
										  [self bytes],
										  dataLength, /* input */
										  buffer,
										  bufferSize, /* output */
										  &numBytesEncrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
	
	free(buffer); //free the buffer;
	return nil;
}

- (NSData *)AES128DecryptWithKey:(NSString *)key {
    return [self AES128DecryptWithKey:key andIv:nil];
}

- (NSData *)AES128DecryptWithKey:(NSString *)key andIv:(NSString *)iv {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused) // oorspronkelijk 256
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
    
    char ivPtr[kCCKeySizeAES128+1];
    if(iv) {
        bzero(ivPtr, sizeof(ivPtr));
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }
	
    
	NSUInteger dataLength = [self length];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
    
    CCOptions options = iv ? (kCCOptionPKCS7Padding) : (kCCOptionPKCS7Padding | kCCOptionECBMode);
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
										  kCCAlgorithmAES128,
										  options,
										  keyPtr,
										  kCCKeySizeAES128, // oorspronkelijk 256
										  iv ? ivPtr : NULL /* initialization vector (optional) */,
										  [self bytes],
										  dataLength, /* input */
										  buffer,
										  bufferSize, /* output */
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	}
	
	free(buffer); //free the buffer;
	return nil;
}
@end
