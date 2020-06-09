//
//  YHPinchPhotoBrowser.m
//  YHPinchPhotoBrowser
//
//  Created by yuhechuan on 2020/6/4.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "YHPinchPhotoBrowser.h"

#define WORK_FEEL_MIN_SALE 0.5
#define WORK_FEEL_MAX_SALE 4

@interface YHPinchPhotoBrowser ()<UIGestureRecognizerDelegate>

/*
* 开始手势时底部灰色背景
*/
@property (nonatomic, strong) UIView *grayView;
/*
* 复制的需要缩放的 视图对象
*/
@property (nonatomic, strong) UIImageView *grayViewImage;
/*
* 需要进行缩放的视图 相对于屏幕的frame
*/
@property (nonatomic, assign) CGRect originImageFrame;
/*
 * 需要进行缩放的视图(一般为ImageView 或者其父视图)
 */
@property (nonatomic, strong) UIImageView *targetView;
/*
 * 添加手势的视图 一般是控制的view
 */
@property (nonatomic, weak)   UIView *gestureView;
/*
* 捏合手势
*/
@property (nonatomic, strong) UIPinchGestureRecognizer *pinch;
/*
* 滑动平移手势
*/
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation YHPinchPhotoBrowser

- (instancetype)initWithGestureView:(UIView *)gestureView {
    if (self = [super init]) {
        _gestureView = gestureView;
        _pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
        _pinch.delegate = self;
        [_gestureView addGestureRecognizer:_pinch];
        
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        _pan.delegate = self;
        _pan.minimumNumberOfTouches = 2;
        [_gestureView addGestureRecognizer:_pan];
        _animationBackgroundColor = [UIColor blackColor];
        _backgroundApla = 0.5;
    }
    return self;
}

#pragma mark -- method

- (void)resetGestureView:(UIView *)gestureView {
    self.gestureView = gestureView;
}

/*
* 捏合手势回调
*/
- (void)pinchAction:(UIPinchGestureRecognizer*)recognizer {
    __weak typeof(self) weakSelf = self;
    if (recognizer.state != UIGestureRecognizerStateEnded) {
        if (!self.grayView.superview) {
            if (self.bz_dataSource) {
                self.bz_dataSource(recognizer, ^(UIImageView * _Nonnull targetView) {
                    [weakSelf locationInImageView:targetView
                                       recognizer:recognizer];
                });
            }
        } else {
           [weakSelf transformScale:recognizer];
        }
    } else {
        [UIImageView animateWithDuration:0.25 animations:^{
            [weakSelf hidingGrayView];
        } completion:^(BOOL finished) {
            [weakSelf hideGrayView];
        }];
    }
}

/*
 * 根据目标视图算出其 在屏幕上的frame 复制一个一样的视图 并进行缩放
 */
- (void)locationInImageView:(UIImageView *)targetView
                 recognizer:(UIPinchGestureRecognizer *)recognizer {
    if (!targetView) {
        return;
    }
    
    CGPoint locationView = [recognizer locationInView:self.gestureView];
    CGRect realRect = [self.gestureView convertRect:targetView.frame fromView:targetView.superview];
    //算出2个手指具体位置 都要在 图片范围之内
    int touchCount = (int)recognizer.numberOfTouches;
    CGPoint p1 = locationView;
    CGPoint p2 = locationView;
    if (touchCount == 2) {
       p1 = [self.pinch locationOfTouch: 0 inView:self.gestureView];
       p2 = [self.pinch locationOfTouch: 1 inView:self.gestureView];
    }
    BOOL isLocationed = NO;
    if (targetView && CGRectContainsPoint(realRect, p1) && CGRectContainsPoint(realRect, p2)) {
       isLocationed  = YES;
    }
    
    if (!isLocationed) { // 不符合条件直接返回
        return;;
    }
    
    self.originImageFrame = realRect;
    self.targetView = targetView;

    self.grayViewImage.image = targetView.image;
    self.grayViewImage.contentMode = targetView.contentMode;
    self.grayViewImage.frame = realRect;
    [self showGrayView];
    [self transformScale:recognizer];
}

/*
* 根据触摸中心位置并进行缩放
*/
- (void)transformScale:(UIPinchGestureRecognizer*)recognizer {
    CGFloat scale = recognizer.scale;
    if (scale > WORK_FEEL_MAX_SALE || scale < WORK_FEEL_MIN_SALE) {
        return;
    }
    [self adjustAnchorPointForGestureRecognizer:recognizer];
    self.grayViewImage.transform = CGAffineTransformScale(self.grayViewImage.transform, scale, scale);
    recognizer.scale = 1.0;
}

/*
* 滑动手势回调
*/
- (void)panAction:(UIPanGestureRecognizer*)recognizer {
    __weak typeof(self) weakSelf = self;
    if (!self.grayView.superview) {
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.grayViewImage.superview];
        self.grayViewImage.center = CGPointMake(self.grayViewImage.center.x + translation.x, self.grayViewImage.center.y + translation.y);
        [recognizer setTranslation:CGPointZero inView:self.grayViewImage.superview];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        [UIImageView animateWithDuration:0.25 animations:^{
            [weakSelf hidingGrayView];
        } completion:^(BOOL finished) {
            [weakSelf hideGrayView];
        }];
    }
}


- (void)hidingGrayView {
    self.grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.grayViewImage.frame = self.originImageFrame;
    self.grayViewImage.transform = CGAffineTransformIdentity;
}

- (void)showGrayView {
    self.grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.gestureView addSubview:self.grayView];
    [self.gestureView bringSubviewToFront:self.grayView];
    self.targetView.hidden = YES;
}

- (void)hideGrayView {
    self.targetView.hidden = NO;
    [self.grayView removeFromSuperview];
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    //UIGestureRecognizerStateBegan意味着手势已经被识别
    if (gestureRecognizer.state ==UIGestureRecognizerStateBegan)  {
        //手势发生在哪个view上
        UIView *piece = self.grayViewImage;
        //获得当前手势在view上的位置。
        CGPoint locationInView = [gestureRecognizer locationInView:piece];

        piece.layer.anchorPoint =CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        //根据在view上的位置设置锚点。
        //防止设置完锚点过后，view的位置发生变化，相当于把view的位置重新定位到原来的位置上。
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        piece.center = locationInSuperview;
    }
}


/*
 * 是否允许两个手势同时 发生
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (otherGestureRecognizer == self.pan) {
        return YES;
    }
    return NO;
}


#pragma mark -- getter and setter

- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _grayView.backgroundColor = [self.animationBackgroundColor colorWithAlphaComponent:self.backgroundApla];
        _grayView.userInteractionEnabled = NO;
        [_grayView addSubview:self.grayViewImage];
    }
    return _grayView;
}

- (UIImageView *)grayViewImage {
    if (!_grayViewImage) {
        _grayViewImage = [[UIImageView alloc]init];
        _grayViewImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _grayViewImage;
}

- (void)dealloc {
    NSLog(@"YHPinchPhotoBrowser dealloc");
}

@end
