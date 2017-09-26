//
//  ViewController.m
//  SocketTest
//
//  Created by GarryZhang on 2017/9/24.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import "ViewController.h"
#import "AsyncSocket.h"

#import "NSData+Parser.h"

@interface ViewController ()

@property (nonatomic, strong) AsyncSocket *asyncSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)connectServer:(id)sender {
    NSError *error = nil;
    NSString *host = @"54.254.183.241";
    
    [self.asyncSocket connectToHost:host onPort:10008 error:&error];
    
    NSLog(@"connect to host: %@", host);
}

#pragma mark - AsyncSocket delegate methods
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"will disconnect socket.");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"disconnect socket.");
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"did connect.");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *receiveDataStr = [data stringFromData];
    NSLog(@"socketReadDataString:%@", receiveDataStr);
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"did write data.");
}


#pragma mark - Getter methods
- (AsyncSocket *)asyncSocket {
    if (!_asyncSocket) {
        _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    }
    
    return _asyncSocket;
}

@end
