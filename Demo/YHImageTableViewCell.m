//
//  YHImageTableViewCell.m
//  YHPinchPhotoBrowser
//
//  Created by yuhechuan on 2020/6/5.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "YHImageTableViewCell.h"

@interface YHImageTableViewCell ()

@property (nonatomic, strong) UIImageView *yhImageView;

@end

@implementation YHImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCellImage:(UIImage *)image {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageHeight = image.size.height / image.size.width  *1.0 *width;
    self.yhImageView.frame = CGRectMake(0, 30, width, imageHeight);
    self.yhImageView.image = image;
}

- (UIImageView *)yhImageView {
    if (!_yhImageView) {
        _yhImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_yhImageView];
    }
    return _yhImageView;
}

- (UIImageView *)getCurrentImageView {
    return self.yhImageView;
}

+ (CGFloat)cellHeight:(UIImage *)image {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageHeight = image.size.height / image.size.width  *1.0 *width;
    return imageHeight + 60;
}

@end
