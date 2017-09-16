//
//  CaptureScreenManager.m
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/9/7.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import "CaptureScreenManager.h"
#import <UIKit/UIKit.h>
#import <IOMobileFrameBuffer.h>
//#import "IOMobileFrameBuffer.h"
#import <IOKit/IOKitLib.h>
#import <IOSurface/IOSurface.h>
#import <QuartzCore/QuartzCore.h>

@interface CaptureScreenManager()

@end

@implementation CaptureScreenManager

+ (instancetype)sharedInstance {
    static CaptureScreenManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (void)screenShot {
//    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
//    UIGraphicsBeginImageContext(screenWindow.frame.size);
//    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
    
    UIImage *viewImage = [self screenShotImage];
    NSLog(@"image:%@",viewImage); //至此已拿到image

    UIImageWriteToSavedPhotosAlbum(viewImage, self, nil, nil);//把图片保存在本地
//    return viewImage;
    
    
//    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size); //self为需要截屏的UI控件 即通过改变此参数可以截取特定的UI控件
////    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    NSLog(@"image:%@",image); //至此已拿到image
////    UIImageView *imaView = [[UIImageView alloc] initWithImage:image];
////    imaView.frame = CGRectMake(0, 10, 200, 200);
////    [self.view addSubview:imaView];
//    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);//把图片保存在本地
    
    NSLog(@"capture screen successed.");
}

- (UIImage *)screenShotImage {
    IOMobileFramebufferConnection connect;
    kern_return_t result;
    CoreSurfaceBufferRef screenSurface = NULL;
    io_service_t framebufferService = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleH1CLCD"));
    if(!framebufferService)
        framebufferService = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleM2CLCD"));
    if(!framebufferService)
        framebufferService = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleCLCD"));
    
    result = IOMobileFramebufferOpen(framebufferService, mach_task_self(), 0, &connect);
    result = IOMobileFramebufferGetLayerDefaultSurface(connect, 0, &screenSurface);
    
    uint32_t aseed;
    IOSurfaceLock((IOSurfaceRef)screenSurface, 0x00000001, &aseed);
    size_t width = IOSurfaceGetWidth((IOSurfaceRef)screenSurface);
    
    size_t height = IOSurfaceGetHeight((IOSurfaceRef)screenSurface);
    CFMutableDictionaryRef dict;
    size_t pitch = width*4, size = width*height*4;
    
    int bPE=4;
    
    char pixelFormat[4] = {'A','R','G','B'};
    dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(dict, kIOSurfaceIsGlobal, kCFBooleanTrue);
    CFDictionarySetValue(dict, kIOSurfaceBytesPerRow, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &pitch));
    CFDictionarySetValue(dict, kIOSurfaceBytesPerElement, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bPE));
    CFDictionarySetValue(dict, kIOSurfaceWidth, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &width));
    CFDictionarySetValue(dict, kIOSurfaceHeight, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &height));
    CFDictionarySetValue(dict, kIOSurfacePixelFormat, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, pixelFormat));
    CFDictionarySetValue(dict, kIOSurfaceAllocSize, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &size));
    
    IOSurfaceRef destSurf = IOSurfaceCreate(dict);
    IOSurfaceAcceleratorRef outAcc;
    IOSurfaceAcceleratorCreate(NULL, 0, &outAcc);
    
    IOSurfaceAcceleratorTransferSurface(outAcc, (IOSurfaceRef)screenSurface, destSurf, dict, NULL);
    IOSurfaceUnlock((IOSurfaceRef)screenSurface, kIOSurfaceLockReadOnly, &aseed);
    CFRelease(outAcc);
    
    CGDataProviderRef provider =  CGDataProviderCreateWithData(NULL,  IOSurfaceGetBaseAddress(destSurf), (width * height * 4), NULL);
    
    CGImageRef cgImage = CGImageCreate(width, height, 8,
                                       8*4, IOSurfaceGetBytesPerRow(destSurf),
                                       CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst |kCGBitmapByteOrder32Little, provider, NULL, YES, kCGRenderingIntentDefault);
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    return image;
}



@end
