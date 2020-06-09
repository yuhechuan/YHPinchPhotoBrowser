//
//  YHImageTableViewCell.h
//  YHPinchPhotoBrowser
//
//  Created by yuhechuan on 2020/6/5.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHImageTableViewCell : UITableViewCell

- (void)setCellImage:(UIImage *)image;
- (UIImageView *)getCurrentImageView;
+ (CGFloat)cellHeight:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
