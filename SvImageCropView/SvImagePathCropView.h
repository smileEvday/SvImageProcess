//
//  SvImagePathCropView.h
//  SvImageEdit
//
//  Created by  maple on 5/12/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SvImagePathCropView : UIView

@property (nonatomic, assign) CGRect cropBoundsRect;

/*
 * @brief 获取真实的裁剪路径
 */
- (NSArray*)getCropPath;

/*
 * @brief 获取真实裁剪路径的外接矩形
 */
- (CGRect)getCropRect;

/*
 * @brief clear path data and refresh UI
 */
- (void)emptyPath;

@end
