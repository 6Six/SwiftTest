//
//  AppDelegate.m
//  StoryboardTest
//
//  Created by GarryZhang on 2017/9/4.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import "AppDelegate.h"

#import "CaptureScreenManager.h"


#import <AVFoundation/AVFoundation.h>


@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTaskId;
@property (nonatomic, assign) BOOL isPlayed;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
    self.bgTaskId = [AppDelegate backgroundPlayerID:self.bgTaskId];
    
    [self.player play];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CaptureScreenManager sharedInstance] screenShot];
    });

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UIApplication *app = [UIApplication sharedApplication];
    self.bgTaskId = [app beginBackgroundTaskWithExpirationHandler:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.bgTaskId != UIBackgroundTaskInvalid)
            {
                self.bgTaskId = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.bgTaskId != UIBackgroundTaskInvalid)
            {
                self.bgTaskId = UIBackgroundTaskInvalid;
            }
        });
    });

    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private methods
//实现一下backgroundPlayerID:这个方法:
+ (UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
{
    //设置并激活音频会话类别
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    //允许应用程序接收远程控制
    //    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    
    if(newTaskId != UIBackgroundTaskInvalid && backTaskId != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    
    return newTaskId;
}

//处理中断事件
- (void)handleInterreption:(NSNotification *)sender
{
    if (self.isPlayed)
    {
        [self.player pause];
        self.isPlayed = NO;
    }
    else
    {
        [self.player play];
        self.isPlayed = YES;
    }
}

#pragma mark - Getter methods
- (AVAudioPlayer *)player
{
    if (!_player)
    {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        NSURL *moveMP3 = [NSURL fileURLWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"test.mp3"]];
        NSError *err = nil;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
        _player.volume = 0.0;
        _player.numberOfLoops = -1;
        [_player prepareToPlay];
        
        if (err != nil)
        {
            NSLog(@"move player init error:%@",err);
        }
        else
        {
            //            [_player play];
        }

    }
    
    return _player;
}



@end
