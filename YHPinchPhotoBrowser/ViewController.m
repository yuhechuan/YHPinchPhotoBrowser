//
//  ViewController.m
//  YHPinchPhotoBrowser
//
//  Created by yuhechuan on 2020/6/4.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "ViewController.h"
#import "YHButton.h"
#import "YHSinleImageViewController.h"
#import "YHImageTableViewController.h"

@interface ViewController ()

@property (nonatomic, strong) YHButton *display;
@property (nonatomic, strong) YHButton *displayPresent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    self.title = @"项目演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = 200;
    CGFloat height = 50;
    CGFloat x = (self.view.bounds.size.width - width) / 2.0;
    CGFloat y1 = 200;
    _display = [[YHButton alloc]initWithFrame:CGRectMake(x, y1, width, height)];
    _display.title = @"单张图片";
    _display.buttonColor = [UIColor colorWithRed:70 / 225.0 green:187 / 255.0 blue:38 / 255.0 alpha:1];
    typeof(self) __weak weakSelf = self;
    _display.operation = ^{
        [weakSelf displayAnimation];
    };
    [self.view addSubview:_display];
    
    _displayPresent = [[YHButton alloc]initWithFrame:CGRectMake(x, y1+ height *2, width, height)];
    _displayPresent.title = @"TableView多张图片";
    _displayPresent.buttonColor = [UIColor colorWithRed:230 / 225.0 green:103 / 255.0 blue:103 / 255.0 alpha:1];
    _displayPresent.operation = ^{
        [weakSelf displayAnimationPresent];
    };
    [self.view addSubview:_displayPresent];
}

- (void)displayAnimation {
    YHSinleImageViewController *s = [[YHSinleImageViewController alloc]init];
    [self.navigationController pushViewController:s animated:YES];
}

- (void)displayAnimationPresent {
    YHImageTableViewController *i = [[YHImageTableViewController alloc]init];
    [self.navigationController pushViewController:i animated:YES];
}


@end
