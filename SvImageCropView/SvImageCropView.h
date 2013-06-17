//
//  SvImageCropView.h
//  SvImageEdit
//
//  Created by  maple on 5/7/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SvCropCell.h"

@interface SvImageCropView : UIView <SvCropCellDelegate> 

@property (nonatomic, assign) CGRect  cropBoundsRect;
@property (nonatomic, assign) CGFloat cropRatio;        // 裁剪比例，default = 0, 意味着不限制比例


/*
 * @brief 设置裁剪区域
 */
- (void)setCropRect:(CGRect)cropRect;


/*
 * @brief 获取真实的裁剪区域
 */
- (CGRect)getRealCropRect;


@end
