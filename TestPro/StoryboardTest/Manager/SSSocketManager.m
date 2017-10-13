//
//  SSSocketManager.m
//  ScreenShotBgPro
//
//  Created by GarryZhang on 2017/9/26.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import "SSSocketManager.h"
#import "CaptureScreenManager.h"

static NSString *const kBeatHeartCommandHeadStr = @"000000000100000000000000";

static NSInteger const kBeatHeartTimeinteval = 5.0;

@interface SSSocketManager()

@property (nonatomic, strong) AsyncSocket *asyncSocket;
@property (nonatomic, strong) NSTimer *heartBeatTimer;
@property (nonatomic, strong) NSTimer *sendImageDataTimer;

@property (nonatomic, strong) NSMutableArray *imageDataArray;

@property (nonatomic, weak) id<SSSocketManagerDelegate> delegate;

@property (nonatomic, assign) NSInteger heartBeatCount;

@end

@implementation SSSocketManager

- (instancetype)init {
    if (self = [super init]) {
        self.asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    }
    
    return self;
}

+ (SSSocketManager *)sharedInstance
{
    static SSSocketManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SSSocketManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)setSSManagerDelegate:(id<SSSocketManagerDelegate>)ssDelegate
{
    if (ssDelegate)
    {
        self.delegate = ssDelegate;
        
//        [self.heartBeatTimer fire];
    }
}

- (void)clearHeartBeatCount
{
    self.heartBeatCount = 0;
    
    if (!self.heartBeatTimer.isValid)
    {
        [self.heartBeatTimer fire];
    }
}

//- (void)sendData
//{
//    if (self.imageDataArray.count == 0)
//    {
//        [self sendHeartBeat];
//    }
//}

#pragma mark - Private methods
- (void)sendHeartBeat
{
    if (2 == self.heartBeatCount) {
        [self disconnect];
        self.heartBeatCount = 0;
        
        return;
    }
    
    NSData *data = [kBeatHeartCommandHeadStr dataFromString];
//    [self writeData:data withTimeout:30 tag:0];
    [self.asyncSocket writeData:data withTimeout:30 tag:0];
    self.heartBeatCount++;
    
    NSLog(@"send beat heart");
}

- (void)needReconnect {
    NSError *error = nil;
    
    if ([self.asyncSocket isConnected]) {
        [self.asyncSocket disconnect];
    }
    
    
    BOOL connect = [self connectToHost:kHost onPort:kPort error:&error];
    
    if (!connect) {
        [self needReconnect];
    }
    
    NSLog(@"reconnect");
}

- (void)sendDeviceName {
    NSString *deviceName = [[UIDevice currentDevice] name];
    NSDictionary *deviceNameDic = @{@"IpadName" : deviceName};
    NSString *deviceNameJsonDataStr = [deviceNameDic convertToJsonData];
    NSData *deviceNameUTF8Data = [deviceNameJsonDataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger beforeCompressUTF8DataLength = deviceNameUTF8Data.length;
    NSMutableString *beforeCompressDataLengthStr = [[[NSString stringWithFormat:@"%@", @(beforeCompressUTF8DataLength)] toHexString] mutableCopy];
    
    for (NSInteger index = beforeCompressDataLengthStr.length; index < 8; index++) {
        [beforeCompressDataLengthStr appendString:@"0"];
    }
    
    NSData *afterCompressData = [deviceNameUTF8Data zlibDeflate];
    
    if (!afterCompressData) {
        return;
    }
    
    NSString *afterCompressDataStr = [afterCompressData stringFromData];
    NSInteger afterCompressDataLength = afterCompressDataStr.length / 2;
    NSMutableString *afterCompressDataLengthStr = [[[NSString stringWithFormat:@"%@", @(afterCompressDataLength)] toHexString] mutableCopy];
    
    for (NSInteger index = afterCompressDataLengthStr.length; index < 8; index++) {
        [afterCompressDataLengthStr appendString:@"0"];
    }
    
    
    NSString *messageType = @"02000000";
    NSString *messageHeadStr = [NSString stringWithFormat:@"%@%@%@", afterCompressDataLengthStr, messageType, beforeCompressDataLengthStr];
    NSString *messageBodyStr = [afterCompressDataStr copy];
    NSString *messageStr = [NSString stringWithFormat:@"%@%@", messageHeadStr, messageBodyStr];
    

    NSData *data = [messageStr dataFromString];
    [self.asyncSocket writeData:data withTimeout:30 tag:0];
    NSLog(@"send device:%@", deviceName);
    NSLog(@"device data: %@", data);
}

//- (void)sendCaptureImage:(UIImage *)image {
//    NSData *imageData = [image getImageRGBData];
//    NSInteger beforeCompressImageDataLength = imageData.length;
//    NSMutableString *beforeCompressImageDataLengthStr = [[[NSString stringWithFormat:@"%@", @(beforeCompressImageDataLength)] toHexString] mutableCopy];
//
//    for (NSInteger index = beforeCompressImageDataLengthStr.length; index < 8; index++) {
//        [beforeCompressImageDataLengthStr appendString:@"0"];
//    }
//
//    NSData *afterCompressData = [imageData zlibDeflate];
//
//    if (!afterCompressData) {
//        return;
//    }
//
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
//
//
//    NSData *data = [messageStr dataFromString];
//    NSMutableArray *tempDataArray = [NSMutableArray array];
//
//    if (data.length > 512) {
//        NSInteger count = data.length / 512;
//        for (NSInteger index = 0; index <= count; index++) {
//            if (index == count) {
//                [tempDataArray addObject:[data subdataWithRange:NSMakeRange(index * 512, data.length - index * 512)]];
//            }
//            else {
//                [tempDataArray addObject:[data subdataWithRange:NSMakeRange(index * 512, 512)]];
//            }
//        }
//    }
//    else {
//        [tempDataArray addObject:data];
//    }
//
//    if ([self.heartBeatTimer isValid]) {
//        [self.heartBeatTimer invalidate];
//        _heartBeatTimer = nil;
//    }
//
//    [self.imageDataArray removeAllObjects];
//    [self.imageDataArray addObjectsFromArray:tempDataArray];
//
//    if (![self.sendImageDataTimer isValid]) {
//        [self.sendImageDataTimer fire];
//    }
//
//    for (NSData *tmpData in tempDataArray) {
//        [self.asyncSocket writeData:tmpData withTimeout:30 tag:0];
//    }
//
////    NSLog(@"send image data:%@", imageData);
////    NSLog(@"image compressed data: %@", data);
//}

- (void)sendImageData
{
    if (self.imageDataArray.count > 0)
    {
        NSData *data = self.imageDataArray[0];
        
        [self.asyncSocket writeData:data withTimeout:30 tag:100];
        [self.imageDataArray removeObjectAtIndex:0];
    }
    else {
        if (![self.heartBeatTimer isValid]) {
            [self.heartBeatTimer fire];
        }
        
        [self.sendImageDataTimer invalidate];
        _sendImageDataTimer = nil;
    }
}

#pragma mark - Public methods
- (BOOL)isConnected
{
    return [self.asyncSocket isConnected];
}

- (BOOL)connectToHost:(NSString *)host onPort:(UInt16)port error:(NSError *__autoreleasing *)error
{
    if ([self.asyncSocket isConnected]) {
        [self.asyncSocket disconnect];
    }
    
    BOOL isconnected = [self.asyncSocket connectToHost:host onPort:port error:error];
    
    return isconnected;
}

- (void)disconnect
{
    [self.heartBeatTimer invalidate];
    _heartBeatTimer = nil;
    
    [self.sendImageDataTimer invalidate];
    _sendImageDataTimer = nil;
    
    [self.asyncSocket disconnect];
}

- (void)writeData:(NSData *)data
      withTimeout:(NSTimeInterval)timeout
              tag:(long)tag
{
    [self.imageDataArray addObject:data];
    
    if (![self.sendImageDataTimer isValid])
    {
        [self.sendImageDataTimer fire];
    }
}

- (void)readDataWithTimeout:(NSTimeInterval)timeout
                        tag:(long)tag
{
    [self.asyncSocket readDataWithTimeout:timeout tag:tag];
}

#pragma mark - AsyncSocket delegate methods
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSSSocket:willDisconnectWithError:)])
    {
        [self.delegate onSSSocket:sock willDisconnectWithError:err];
    }
    
    NSLog(@"will disconnect socket.");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSocketDidDisconnect:)])
    {
        [self.delegate onSSSocketDidDisconnect:sock];
    }
    
    NSLog(@"disconnect socket.");
    
    [self needReconnect];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSSSocket:didConnectToHost:port:)])
    {
        [self.delegate onSSSocket:sock didConnectToHost:host port:port];
    }
    
    NSLog(@"did connect.");
    
    [self.asyncSocket readDataWithTimeout:30 tag:0];

    
    if (![self.heartBeatTimer isValid]) {
        [self.heartBeatTimer fire];
    }

    [self sendDeviceName];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSSSocket:didReadData:withTag:)])
    {
        [self.delegate onSSSocket:sock didReadData:data withTag:tag];
    }
    
    NSString *receiveDataStr = [data stringFromData];
//    NSLog(@"socketReadDataString:%@", receiveDataStr);
    
    if ([receiveDataStr isEqualToString:kBeatHeartCommandHeadStr]) {
        NSLog(@"receive beat heart response");

        [self clearHeartBeatCount];
    }
    else {
        NSString *commandStr = [receiveDataStr substringWithRange:NSMakeRange(8, 8)];
        
        if ([commandStr isEqualToString:@"02000000"]) {
            // 解析设备名称回复
            NSString *responseStr = [receiveDataStr substringFromIndex:24];
            NSData *responseData = [responseStr dataFromString];
            NSData *inflateData = [responseData zlibInflate];
            responseStr = [[NSString alloc] initWithData:inflateData encoding:NSUTF8StringEncoding];
            NSDictionary *responseDic = [responseStr dictionaryWithJsonString];
           
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                NSInteger status = [responseDic[@"status"] integerValue];
                
                if (0 == status) {
                    NSLog(@"收到设备名称成功");
                }
                else {
                    NSString *failureReason = responseDic[@"FailtureReason"];
                    NSLog(@"收到设备名称失败:%@", failureReason);
                }
            }
        }
        else if ([receiveDataStr containsString:@"0000000003000000"]) {
            // 开始截图
            
            UIImage *image = [[CaptureScreenManager sharedInstance] screenShotImage];
            [[CaptureScreenManager sharedInstance] uploadImage:image];
//            [self sendCaptureImage:image];
        }
        else if ([commandStr isEqualToString:@"04000000"]) {
            // 发送图片回复
            NSString *responseStr = [receiveDataStr substringFromIndex:24];
            NSData *responseData = [responseStr dataFromString];
            NSData *inflateData = [responseData zlibInflate];
            responseStr = [[NSString alloc] initWithData:inflateData encoding:NSUTF8StringEncoding];
            NSDictionary *responseDic = [responseStr dictionaryWithJsonString];
            
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                NSInteger status = [responseDic[@"status"] integerValue];
                
                if (0 == status) {
                    NSLog(@"收到图片成功");
                }
                else {
                    NSString *failureReason = responseDic[@"FailtureReason"];
                    NSLog(@"收到图片失败:%@", failureReason);
                }
            }
        }
        
        NSLog(@"receive data:%@", receiveDataStr);
    }
    
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSSSocket:didWriteDataWithTag:)])
    {
        [self.delegate onSSSocket:sock didWriteDataWithTag:tag];
    }
    
//    NSLog(@"did write data.");
    [self.asyncSocket readDataWithTimeout:30 tag:0];

}

#pragma mark - Getter methods
- (NSTimer *)heartBeatTimer
{
    if (!_heartBeatTimer)
    {
        _heartBeatTimer = [NSTimer timerWithTimeInterval:kBeatHeartTimeinteval target:self selector:@selector(sendHeartBeat) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_heartBeatTimer forMode:NSRunLoopCommonModes];
        // 打开下面一行输出runloop的内容就可以看出，timer却是已经被添加进去
        //NSLog(@"the thread's runloop: %@", [NSRunLoop currentRunLoop]);
        // 打开下面一行, 该线程的runloop就会运行起来，timer才会起作用
        //        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    }
    
    return _heartBeatTimer;
}

- (NSTimer *)sendImageDataTimer
{
    if (!_sendImageDataTimer)
    {
        _sendImageDataTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(sendImageData) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_sendImageDataTimer forMode:NSRunLoopCommonModes];
    }
    
    return _sendImageDataTimer;
}

- (NSMutableArray *)imageDataArray
{
    if (!_imageDataArray)
    {
        _imageDataArray = [NSMutableArray array];
    }
    
    return _imageDataArray;
}

@end
