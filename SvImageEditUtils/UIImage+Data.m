//
//  UIImage+Data.m
//  SvImageEdit
//
//  Created by  maple on 5/12/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "UIImage+Data.h"

@implementation UIImage (Data)

// the data should be RGBA format
+ (UIImage*)createImageWithData:(Byte*)data width:(NSInteger)width height:(NSInteger)height alphaInfo:(CGImageAlphaInfo)alphaInfo
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    if (!colorSpaceRef) {
        NSLog(@"Create ColorSpace Error!");
    }
    CGContextRef bitmapContext = CGBitmapContextCreate(data, width, height, 8, width * 4, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    if (!bitmapContext) {
        NSLog(@"Create Bitmap context Error!");
        CGColorSpaceRelease(colorSpaceRef);
        return nil;
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(bitmapContext);
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);

    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(bitmapContext);

    return image;
}


// return bmpData is rgba
- (BOOL)getImageData:(void**)data width:(NSInteger*)width height:(NSInteger*)height alphaInfo:(CGImageAlphaInfo*)alphaInfo
{
    int imgWidth = self.size.width * self.scale;
    int imgHegiht = self.size.height * self.scale;
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    if (colorspace == NULL) {
        NSLog(@"Create Colorspace Error!");
        return NO;
    }
    
    void *imgData = NULL;
    imgData = malloc(imgWidth * imgHegiht * 4);
    if (imgData == NULL) {
        NSLog(@"Memory Error!");
        return NO;
    }
    
    CGContextRef bmpContext = CGBitmapContextCreate(imgData, imgWidth, imgHegiht, 8, imgWidth * 4, colorspace, kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(bmpContext, CGRectMake(0, 0, imgWidth, imgHegiht), self.CGImage);
    
    *data = CGBitmapContextGetData(bmpContext);
    *width = imgWidth;
    *height = imgHegiht;
    *alphaInfo = kCGImageAlphaLast;
    
    CGColorSpaceRelease(colorspace);
    CGContextRelease(bmpContext);
    
    return YES;
}

@end
