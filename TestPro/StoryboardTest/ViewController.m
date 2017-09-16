//
//  ViewController.m
//  StoryboardTest
//
//  Created by GarryZhang on 2017/9/4.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"28182398123812");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)screenShot {
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size); //self为需要截屏的UI控件 即通过改变此参数可以截取特定的UI控件
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"image:%@",image); //至此已拿到image
    UIImageView *imaView = [[UIImageView alloc] initWithImage:image];
    imaView.frame = CGRectMake(0, 10, 200, 200);
    [self.view addSubview:imaView];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);//把图片保存在本地
}
    
    

@end
