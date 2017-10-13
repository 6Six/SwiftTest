//
//  NSData+STUnzipArchive.h
//  ScreenShotBgPro
//
//  Created by GarryZhang on 2017/9/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (STUnzipArchive)

// ZLIB

/**
 Zlib 解压

 @return 解压后的数据
 */
- (NSData *)zlibInflate;


/**
 Zlib 压缩

 @return    压缩后的数据
 */
- (NSData *)zlibDeflate;

// GZIP

/**
 GZip 解压

 @return    解压后的数据
 */
- (NSData *)gzipInflate;


/**
 GZip   压缩

 @return 压缩后的数据
 */
- (NSData *)gzipDeflate;

@end
