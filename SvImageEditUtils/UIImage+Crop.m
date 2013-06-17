//
//  UIImage+SvImageEdit.m
//  SvImageEdit
//
//  Created by  maple on 5/8/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (SvImageEdit)

/*
 * @brief crop image
 */
- (UIImage*)cropImageWithRect:(CGRect)cropRect
{
    CGRect drawRect = CGRectMake(-cropRect.origin.x , -cropRect.origin.y, self.size.width * self.scale, self.size.height * self.scale);
    
    UIGraphicsBeginImageContext(cropRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, cropRect.size.width, cropRect.size.height));
    
    [self drawInRect:drawRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
 * @brief crop image with path
 */
- (UIImage*)cropImageWithPath:(NSArray*)pointArr
{
    if (pointArr.count == 0) {
        return nil;
    }
    
    CGPoint *points = malloc(sizeof(CGPoint) * pointArr.count);
    for (int i = 0; i < pointArr.count; ++i) {
        points[i] = [[pointArr objectAtIndex:i] CGPointValue];
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * self.scale, self.size.height * self.scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextAddLines(context, points, pointArr.count);
    CGContextClosePath(context);
    CGRect boundsRect = CGContextGetPathBoundingBox(context);
    UIGraphicsEndImageContext();

    UIGraphicsBeginImageContext(boundsRect.size);
    context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, boundsRect.size.width, boundsRect.size.height));
    
    CGMutablePathRef  path = CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-boundsRect.origin.x, -boundsRect.origin.y);
    CGPathAddLines(path, &transform, points, pointArr.count);
    
    CGContextBeginPath(context);
    CGContextAddPath(context, path);    
    CGContextClip(context);
    
    [self drawInRect:CGRectMake(-boundsRect.origin.x, -boundsRect.origin.y, self.size.width * self.scale, self.size.height * self.scale)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGPathRelease(path);
    UIGraphicsEndImageContext();
    
    return image;
}

@end
