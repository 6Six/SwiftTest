//
//  CaptureScreenManager.m
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/9/7.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import "CaptureScreenManager.h"
#import <UIKit/UIKit.h>
//#import <IOMobileFrameBuffer.h>
#import "IOMobileFrameBuffer.h"
#import <IOKit/IOKitLib.h>
#import <IOSurface/IOSurface.h>
#import "CoreSurface.h"
//#import "IOSurface.h"

#import <QuartzCore/QuartzCore.h>





typedef void *IOMobileFramebufferRef;
typedef void *IOMobileFramebufferConnection;
typedef void *CoreSurfaceBufferRef;

BOOL loadedSymbols = NO;

//IOMobileFramebufferReturn
//IOMobileFramebufferOpen(
//                        IOMobileFramebufferService service,
//                        task_port_t owningTask,
//                        unsigned int type,
//                        IOMobileFramebufferConnection * connection );
//kern_return_t (*_IOMobileFramebufferOpen)(io_service_t, mach_port_t, void *, IOMobileFramebufferRef *);

//kern_return_t (*_IOMobileFramebufferSetGammaTable)(IOMobileFramebufferRef, void *);
//kern_return_t (*_IOMobileFramebufferGetGammaTable)(IOMobileFramebufferRef, void *);

//IOMobileFramebufferReturn
//IOMobileFramebufferGetLayerDefaultSurface(
//                                          IOMobileFramebufferConnection connection,
//                                          int surface,
//                                          CoreSurfaceBufferRef *ptr);
kern_return_t (*_IOMobileFramebufferGetLayerDefaultSurface)(void *, void *, void *);

//IOReturn IOSurfaceLock(IOSurfaceRef buffer, uint32_t options, uint32_t *seed);
kern_return_t (*_IOSurfaceLock(IOSurfaceRef, uint32_t, void *));


CFMutableDictionaryRef (*_IOServiceMatching)(const char * name);

io_service_t (*_IOServiceGetMatchingService)(mach_port_t masterPort, CFDictionaryRef matching);

mach_port_t (*_SBSSpringBoardServerPort)();
void (*_SBGetScreenLockStatus)(mach_port_t port, BOOL *lockStatus, BOOL *passcodeEnabled);
void (*_SBSUndimScreen)();


@interface CaptureScreenManager()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

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

- (void)uploadImage:(UIImage *)image {
//    NSString *url = @"https://www.ygsjsy.com/socketserver/uploadImage.php";
    NSString *url = @"http://211.149.224.34:8089/api/Image/PostImage";
    NSString *deviceName = [[UIDevice currentDevice] name];

//    NSData *data = [self getImageInflateData:image];
//    NSString *imageDataStr = [data stringFromData];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    NSString *imageDataStr = [data stringFromData];

    NSDictionary *paramDic = @{@"device" : deviceName,
                               @"image" : imageDataStr};

    [self.sessionManager POST:url parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"upload image success:%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"upload image error:%@", error.description);
    }];
    
//    [self.sessionManager POST:url parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *data = UIImageJPEGRepresentation(image, 0.3);
//
////        CGFloat length = [data length] / 1000;
////        NSLog(@"image size:%@", @(length));
//
////        NSData *data = [self getImageInflateData:image];
//
//        if (!data) {
//            NSLog(@"image data is nil");
//        }
//        else {
//            [formData appendPartWithFileData:data name:@"image" fileName:@"image.jpg" mimeType:@"image/jpg"];
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"upload image successed:%@", responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"upload image failed:%@", error);
//
//    }];
}

- (NSData *)getImageInflateData:(UIImage *)image {
    NSData *imageData = [image getImageRGBData];
//    NSInteger beforeCompressImageDataLength = imageData.length;
//    NSMutableString *beforeCompressImageDataLengthStr = [[[NSString stringWithFormat:@"%@", @(beforeCompressImageDataLength)] toHexString] mutableCopy];
//
//    for (NSInteger index = beforeCompressImageDataLengthStr.length; index < 8; index++) {
//        [beforeCompressImageDataLengthStr appendString:@"0"];
//    }
    
    NSData *afterCompressData = [imageData zlibDeflate];
//
//    if (!afterCompressData) {
//        return nil;
//    }
    
//    NSString *afterCompressDataStr = [afterCompressData stringFromData];
//    NSInteger afterCompressDataLength = afterCompressDataStr.length / 2;
//    NSMutableString *afterCompressDataLengthStr = [[[NSString stringWithFormat:@"%@", @(afterCompressDataLength)] toHexString] mutableCopy];
//
//    for (NSInteger index = afterCompressDataLengthStr.length; index < 8; index++) {
//        [afterCompressDataLengthStr appendString:@"0"];
//    }
//
//
//    NSString *messageType = @"04000000";
//    NSString *messageHeadStr = [NSString stringWithFormat:@"%@%@%@", afterCompressDataLengthStr, messageType, beforeCompressImageDataLengthStr];
//    NSString *messageBodyStr = [afterCompressDataStr copy];
//    NSString *messageStr = [NSString stringWithFormat:@"%@%@", messageHeadStr, messageBodyStr];
    
//    NSData *data = [messageStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *base64String = [afterCompressData base64EncodedStringWithOptions:0];
//    NSData *data = [afterCompressData base64EncodedDataWithOptions:0];
    
    NSLog(@"after compress data:%@", afterCompressData);
    
    return afterCompressData;
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

#pragma mark - Getter methods

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _sessionManager.securityPolicy = securityPolicy;
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    }
    
    return _sessionManager;
}


@end
