//
//  YHSinleImageViewController.m
//  YHPinchPhotoBrowser
//
//  Created by yuhechuan on 2020/6/5.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "YHSinleImageViewController.h"
#import "UIViewController+YHPinchPhotoBrowser.h"

@interface YHSinleImageViewController ()

@property (nonatomic, strong) UIImageView *sinleImageView;

@end

@implementation YHSinleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"单张图片";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"1.jpeg"];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat imageHeight = image.size.height / image.size.width  *1.0 *width;
    self.sinleImageView.frame = CGRectMake(0, (height - imageHeight) / 2.0, width, imageHeight);
    self.sinleImageView.image = image;
    [self.view addSubview:self.sinleImageView];
    __weak typeof(self) weakSelf = self;
    self.yhPhotoBrowser.bz_dataSource = ^(UIPinchGestureRecognizer * _Nonnull recognizer, LocationInTarget  _Nonnull locationInTarget) {
        if (locationInTarget) {
            locationInTarget(weakSelf.sinleImageView);
        }
    };
}


- (UIImageView *)sinleImageView {
    if (!_sinleImageView) {
        _sinleImageView = [[UIImageView alloc]init];
    }
    return _sinleImageView;
}


@end
