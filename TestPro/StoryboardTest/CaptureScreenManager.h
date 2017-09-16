//
//  CaptureScreenManager.h
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/9/7.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaptureScreenManager : NSObject


/**
 单例

 @return 返回CaptureScreenManager 单例
 */
+ (instancetype)sharedInstance;

/**
 截屏
 */
- (void)screenShot;


@end
