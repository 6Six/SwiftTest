//
//  UIImage+RGB.m
//  ScreenShotBgPro
//
//  Created by GarryZhang on 2017/9/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import "UIImage+RGB.h"

//Create a bitmap context

CG_EXTERN CGContextRef CGBitmapContextCreate(
                                             
                                             void *data, //如果data非空，指向一个内存区域，大小至少bytesPerRow *height的字节。如果data为空,data上下文自动分配和释放收回。
                                             
                                             size_t width,
                                             //像素宽
                                             
                                             size_t height,
                                             //像素高
                                             
                                             size_t bitsPerComponent,
                                             //位的数量为每个组件的指定一个像素
                                             
                                             size_t bytesPerRow,
                                             //每一行的位图的字节,至少要宽*每个像素的字节
                                             
                                             CGColorSpaceRef space,
                                             //指定一个颜色空间
                                             
                                             CGBitmapInfo bitmapInfo
//指定位图是否应该包含一个alpha通道和它是如何产生的,以及是否组件是浮点或整数
);


@implementation UIImage (RGB)



//获取UIImage像素ARGB值
- (NSData *)getImageRGBData
{
    
    CGImageRef imageref = [self CGImage];
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    int width = CGImageGetWidth(imageref) / 2;
    int height = CGImageGetHeight(imageref) / 2;
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * width;
    int bitsPerComponent = 8;
    
    unsigned char *imagedata=malloc(width*height*bytesPerPixel);
    
    CGContextRef cgcnt = CGBitmapContextCreate(imagedata,
                                               width,
                                               height,
                                               bitsPerComponent,
                                               bytesPerRow,
                                               colorspace,
                                               kCGImageAlphaPremultipliedFirst);
    //将图像写入一个矩形
    CGRect therect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(cgcnt, therect, imageref);
    
    
    //释放资源
    CGColorSpaceRelease(colorspace);
    
    CGContextRelease(cgcnt);
    
//    for (int i = 0 ; i < 4*width*height; i++) {
//        NSLog(@"UIImage(%d,%d) == %d",(i/4)%width,(i/4)/width,imagedata[i]);
//        if (i%4==3) {
//            NSLog(@"=================");
//        }
//    }
    
    NSData *data = [NSData dataWithBytes:imagedata length:strlen(imagedata)];
    
    return data;
}


//获取UIImage像素Gray值
- (unsigned char *)getImageGrayData:(UIImage*)image
{
    CGImageRef imageref = [image CGImage];
    CGColorSpaceRef colorspace=CGColorSpaceCreateDeviceGray();
    
    int width = CGImageGetWidth(imageref);
    int height = CGImageGetHeight(imageref);
    int bytesPerPixel = 1;
    int bytesPerRow = bytesPerPixel*width;
    int bitsPerComponent = 8;
    
    unsigned char * imagedata=malloc(width*height*bytesPerPixel);
    
    CGContextRef cgcnt = CGBitmapContextCreate(imagedata,
                                               width,
                                               height,
                                               bitsPerComponent,
                                               bytesPerRow,
                                               colorspace,
                                               kCGImageAlphaNone);
    //将图像写入一个矩形
    CGRect therect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(cgcnt, therect, imageref);
    
    
    //释放资源
    CGColorSpaceRelease(colorspace);
    CGContextRelease(cgcnt);
    
    for (int i = 0 ; i < width*height; i++) {
//        NSLog(@"UIImage(%d,%d) == %d", i%width, i/width, imagedata[i]);
    }
    
    return imagedata;
}


@end
