//
//  NSData+SSL.m
//  Lockbox
//
//  Created by Steve Streza on 5/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EncryptionUtil.h"
#import <CommonCrypto/CommonCryptor.h>

const void* LBSHA1ForBytes(const char *bytes, unsigned long long len){
#ifdef UsingOpenSSL
	void *shaBytes = SHA1(bytes, len, NULL);
	return shaBytes;
#else
	/* Do the work */
//	shaInit   (NULL, 1);
//	shaUpdate (NULL, (BITS8 *) bytes, len);
//	shaFinal  (NULL, mydigest);

	void *mydigest = malloc(LBSHADigestLength);
	CC_SHA1(bytes, len, mydigest);
	
	/* print it out. */
	//	for (loop=0; loop<SHF_DIGESTSIZE; loop++) printf ("%02lX", mydigest[loop]);
	return mydigest;
#endif
}

@implementation NSData (SSLCategory)

+(NSData *)SHA1:(NSData *)aData{
	unsigned long long len = [aData length];
	const void *bytes = [aData bytes];
	
	const void *sha1 = LBSHA1ForBytes(bytes,len);
	
	NSData *data = [NSData dataWithBytes:sha1
								  length:LBSHADigestLength];	
	free((void *)sha1);
	return data;
}

+ (NSString *)HexValue:(NSData *)aData{
    NSMutableString *hex = [NSMutableString string];
    unsigned char *bytes = (unsigned char *)[aData bytes];
    char temp[3];
    int i = 0;
	
    for (i = 0; i < [aData length]; i++) {
        temp[0] = temp[1] = temp[2] = 0;
        (void)sprintf(temp, "%02x", bytes[i]);
        [hex appendString:[NSString stringWithUTF8String:temp]];
    }
	
    return hex;
}

+ (NSData *)AES128EncryptWithKey:(NSString *)key Data:(NSData *)aData {
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128 +1]; // room for terminator (unused) // oorspronkelijk 256
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [aData length];
	
	//See the doc: For block ciphers, the output size will always be less than or 
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, 
										  kCCAlgorithmAES128, 
										  kCCOptionPKCS7Padding | kCCOptionECBMode,
										  keyPtr, 
										  kCCKeySizeAES128, // oorspronkelijk 256
										  NULL /* initialization vector (optional) */,
										  [aData bytes], 
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

@end
