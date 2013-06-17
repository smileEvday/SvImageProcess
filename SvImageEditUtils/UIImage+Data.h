//
//  UIImage+Data.h
//  SvImageEdit
//
//  Created by  maple on 5/12/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Data)

+ (UIImage*)createImageWithData:(Byte*)data width:(NSInteger)width height:(NSInteger)height alphaInfo:(CGImageAlphaInfo)colorSpace;

// return bmpData is rgba
- (BOOL)getImageData:(void**)data width:(NSInteger*)width height:(NSInteger*)height alphaInfo:(CGImageAlphaInfo*)alphaInfo;

@end
