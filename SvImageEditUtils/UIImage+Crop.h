//
//  UIImage+SvImageEdit.h
//  SvImageEdit
//
//  Created by  maple on 5/8/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SvImageEdit)

/*
 * @brief crop image
 */
- (UIImage*)cropImageWithRect:(CGRect)cropRect;

/*
 * @brief crop image with path
 */
- (UIImage*)cropImageWithPath:(NSArray*)pointArr;

@end
