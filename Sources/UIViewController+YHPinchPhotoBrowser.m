//
//  UIViewController+YHPinchPhotoBrowser.m
//  YHPinchPhotoBrowser
//
//  Created by yuhechuan on 2020/6/5.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "UIViewController+YHPinchPhotoBrowser.h"
#import <objc/message.h>

@implementation UIViewController (YHPinchPhotoBrowser)

- (YHPinchPhotoBrowser *)yhPhotoBrowser {
    YHPinchPhotoBrowser *yh_photoBrowser = objc_getAssociatedObject(self, @selector(setYhPhotoBrowser:));
    UIView *view = self.navigationController ? self.navigationController.view:self.view;
    if (!yh_photoBrowser) {
        yh_photoBrowser = [[YHPinchPhotoBrowser alloc]initWithGestureView:view];
        self.yhPhotoBrowser = yh_photoBrowser;
    } else {
        [yh_photoBrowser resetGestureView:view];
    }
    return yh_photoBrowser;
}

- (void)setYhPhotoBrowser:(YHPinchPhotoBrowser *)yhPhotoBrowser {
    objc_setAssociatedObject(self,_cmd, yhPhotoBrowser, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
