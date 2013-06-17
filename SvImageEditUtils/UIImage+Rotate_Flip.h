//
//  UIImage+Rotate_Flip.h
//  SvImageEdit
//
//  Created by  maple on 5/14/13.
//  Copyright (c) 2013 smileEvday. All rights reserved.
//
// 

#import <UIKit/UIKit.h>

enum {
    enSvCropClip,               // the image size will be equal to orignal image, some part of image may be cliped
    enSvCropExpand,             // the image size will expand to contain the whole image, remain area will be transparent
};
typedef NSInteger SvCropMode;



@interface UIImage (Rotate_Flip)

/*
 * @brief roate image with radian in clip mode
 */
- (UIImage*)rotateImageWithRadian:(CGFloat)radian;

/*
 * @brief rotate image with radian
 */
- (UIImage*)rotateImageWithRadian:(CGFloat)radian cropMode:(SvCropMode)cropMode;

/*
 * @brief rotate image 90 withClockWise
 */
- (UIImage*)rotate90Clockwise;

/*
 * @brief rotate image 90 counterClockwise
 */
- (UIImage*)rotate90CounterClockwise;

/*
 * @brief rotate image 180 degree
 */
- (UIImage*)rotate180;

/*
 * @brief rotate image to default orientation
 */
- (UIImage*)rotateImageToOrientationUp;

/*
 * @brief flip horizontal
 */
- (UIImage*)flipHorizontal;

/*
 * @brief flip vertical
 */
- (UIImage*)flipVertical;

/*
 * @brief flip horizontal and vertical
 */
- (UIImage*)flipAll;


@end
