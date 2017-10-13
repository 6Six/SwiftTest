//
//  SSSocketManager.h
//  ScreenShotBgPro
//
//  Created by GarryZhang on 2017/9/26.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@protocol SSSocketManagerDelegate <NSObject>

- (void)onSSSocket:(AsyncSocket *)socket willDisconnectWithError:(NSError *)error;
- (void)onSSSocketDidDisconnect:(AsyncSocket *)socket;
- (void)onSSSocket:(AsyncSocket *)socket didConnectToHost:(NSString *)host port:(UInt16)port;
- (void)onSSSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
- (void)onSSSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag;
- (void)onSSSocketNeedReconnect;


@end

@interface SSSocketManager : NSObject


/**
 *  单例方法
 *
 *  @return SSSocketManager对象
 */
+ (SSSocketManager *)sharedInstance;

/**
 *  设置连接代理
 *
 *  @param ssDelegate 代理
 */
- (void)setSSManagerDelegate:(id<SSSocketManagerDelegate>)ssDelegate;

/**
 *  清除心跳数
 */
- (void)clearHeartBeatCount;

/**
 *  是否能连接上接口
 *
 *  @param host        主机ip
 *  @param port        服务端口
 *  @param error       错误反馈
 *
 *  @return YES:成功  NO:失败
 */
- (BOOL)connectToHost:(NSString *)host onPort:(UInt16)port error:(NSError *__autoreleasing *)error;

/**
 *  断开连接
 */
- (void)disconnect;

/**
 *  连接状态
 *
 *  @return 是否连接上
 */
- (BOOL)isConnected;

/**
 *  写数据
 *
 *  @param data       数据流
 *  @param timeout    超时
 *  @param tag        标签
 */
- (void)writeData:(NSData *)data
      withTimeout:(NSTimeInterval)timeout
              tag:(long)tag;

/**
 *  读数据
 *
 *  @param timeout 超时
 *  @param tag     标签
 */
- (void)readDataWithTimeout:(NSTimeInterval)timeout
                        tag:(long)tag;

@end
