# YHPinchPhotoBrowser
YHPinchPhotoBrowser

Travis CocoaPods CocoaPods CocoaPods Laguage CocoaPods LeoDev GitHub stars

☀️ 一款仿Instagram 图片预览方式, 捏合手势,使用方便

In me the tiger sniffs the rose.

心有猛虎，细嗅蔷薇。
欢迎访问我的博客：https://www.jianshu.com/u/7c43d8cb3cff

iOS 9.0+
Xcode 9.0+
Objective-C 
介绍 Introduction

☀️ 一款仿Instagram 图片预览方式, 捏合手势,使用方便

其中主要用到了 UIPinchGestureRecognizer 和UIPanGestureRecognizer  两种手势, 不用window实现和window一样的覆盖全屏效果

### 使用方法
```
// 导入头文件
#import "UIViewController+YHPinchPhotoBrowser.h"

```
#### 1.单张图图片
```
__weak typeof(self) weakSelf = self;
self.yhPhotoBrowser.bz_dataSource = ^(UIPinchGestureRecognizer * _Nonnull recognizer, LocationInTarget  _Nonnull locationInTarget) {
       if (locationInTarget) {
           locationInTarget(weakSelf.sinleImageView);
       }
   };
```
#### 2.图片在TableView上时
```
__weak typeof(self) weakSelf = self;
  self.yhPhotoBrowser.bz_dataSource = ^(UIPinchGestureRecognizer * _Nonnull recognizer, LocationInTarget  _Nonnull locationInTarget) {
      [weakSelf locationInImageView:recognizer locationInTarget:locationInTarget];
  };
  
- (void)locationInImageView:(UIPinchGestureRecognizer*)recognizer
         locationInTarget:(LocationInTarget)locationInTarget {
  CGPoint locationTable = [recognizer locationInView:self.tableView];
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:locationTable];
  YHImageTableViewCell *targetCell = (YHImageTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
  UIImageView *imgeView = [targetCell getCurrentImageView];
  if (locationInTarget) {
      locationInTarget(imgeView);
  }
}
```


