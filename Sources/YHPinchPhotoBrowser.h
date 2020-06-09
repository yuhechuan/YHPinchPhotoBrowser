//
//  YHPinchPhotoBrowser.h
//  YHPinchPhotoBrowser
//
//  Created by yuhechuan on 2020/6/4.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 *  用于寻求被缩放targetView(用于算出他在gestureView的真实frame) 及缩放targetView携带的UIimage(用于新的view显示image) 的block
 */
typedef void(^LocationInTarget)(UIImageView *targetView);

@interface YHPinchPhotoBrowser : NSObject

/*
 * bz_dataSource 当捏合收起开始 在gestureView开始时 调用 用于寻求被缩放view 及缩放view携带的UIimage
 */
@property (nonatomic, copy) void(^bz_dataSource)(UIPinchGestureRecognizer *recognizer, LocationInTarget locationInTarget);

/*
* 动画时 背景颜色默认是黑色
*/
@property (nonatomic, strong) UIColor *animationBackgroundColor;

/*
* 动画时 背景透明度 默认是 0.5
*/
@property (nonatomic, assign) CGFloat backgroundApla;

/*
 * gestureView 添加手势的视图 一般是控制的view
 */
- (instancetype)initWithGestureView:(UIView *)gestureView;

/*
* 跟新手势视图
*/
- (void)resetGestureView:(UIView *)gestureView;


@end

NS_ASSUME_NONNULL_END
