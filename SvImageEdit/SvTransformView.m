//
//  SvTransformView.m
//  SvImageEdit
//
//  Created by  maple on 5/23/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvTransformView.h"

@implementation SvTransformView

@synthesize color11;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect);
//    
//    CGContextSetStrokeColorWithColor(context, color11.CGColor);
//    
//    CGRect rect2 = CGRectMake(rect.size.width / 2 - 90, rect.size.height / 2 - 120, 180, 240);
//    CGContextStrokeRect(context, rect2);
//    
//    CGContextSaveGState(context);
//    CGFloat dash[2] = {3, 3};
//    CGContextSetLineDash(context, 0, dash, 2);
//    
//    CGPoint midLine[2] = {{rect2.origin.x + rect2.size.width / 2, rect2.origin.y}, {rect2.origin.x + rect2.size.width / 2, rect2.origin.y + rect2.size.height}};
//    CGContextStrokeLineSegments(context, midLine, 2);
//    
//    CGContextRestoreGState(context);
//    
//    CGContextSetFillColorWithColor(context, color11.CGColor);
//    CGContextFillEllipseInRect(context, CGRectMake(self.bounds.size.width / 2 - 5, self.bounds.size.height / 2 - 5, 10, 10));
//    
//    CGContextSetLineDash(context, 0, dash, 2);
//    CGContextStrokeLineSegments(context, midLine, 2);
//    
//    return;
    
    // 原点旋转
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect);
//    
//    CGContextSetStrokeColorWithColor(context, color11.CGColor);
//    
//    CGRect rect1 = CGRectMake(self.bounds.size.width / 2, 10, self.bounds.size.width / 2 - 2, self.bounds.size.height / 2 - 2);
//    CGContextStrokeRect(context, rect1);
//    
//    
//    CGContextSaveGState(context);
//    CGFloat dash[2] = {3, 3};
//    CGContextSetLineDash(context, 0, dash, 2);
//    CGPoint midLine[2] = {{rect1.origin.x + rect1.size.width / 2, rect1.origin.y}, {rect1.origin.x + rect1.size.width / 2, rect1.origin.y + rect1.size.height}};
//    CGContextStrokeLineSegments(context, midLine, 2);
//    CGContextRestoreGState(context);
//    
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextTranslateCTM(context, self.bounds.size.width / 2, 10);
//    CGContextRotateCTM(context, M_PI_4);
//    CGRect rect2 = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height / 2);
//    CGContextStrokeRect(context, rect2);
//    
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillEllipseInRect(context, CGRectMake(-5, -5, 10, 10));
//    
//    CGContextSetLineDash(context, 0, dash, 2);
//    CGPoint midLine2[2] = {{rect2.origin.x + rect2.size.width / 2, rect2.origin.y}, {rect2.origin.x + rect2.size.width / 2, rect2.origin.y + rect2.size.height}};
//    CGContextStrokeLineSegments(context, midLine2, 2);
    
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect);
//    
//    CGContextSetStrokeColorWithColor(context, color11.CGColor);
//    
//    CGRect rect1 = CGRectMake(self.bounds.size.width / 3, 100, self.bounds.size.width / 3 - 1, self.bounds.size.height / 3 - 1);
//    CGContextStrokeRect(context, rect1);
//    
//    
//    CGContextSaveGState(context);
//    CGFloat dash[2] = {3, 3};
//    CGContextSetLineDash(context, 0, dash, 2);
//    CGPoint midLine[2] = {{rect1.origin.x + rect1.size.width / 2, rect1.origin.y}, {rect1.origin.x + rect1.size.width / 2, rect1.origin.y + rect1.size.height}};
//    CGContextStrokeLineSegments(context, midLine, 2);
//    CGContextRestoreGState(context);
//    
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextTranslateCTM(context, self.bounds.size.width / 3 * 2 - self.bounds.size.width / 6, self.bounds.size.height / 3 / 2 + 100);
//    CGRect rect2 = CGRectMake(0, 0, self.bounds.size.width / 3 - 1, self.bounds.size.height / 3 - 1);
//    CGContextStrokeRect(context, rect2);
//    
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillEllipseInRect(context, CGRectMake(-5, -5, 10, 10));
//    
//    CGContextSaveGState(context);
//    CGContextSetLineDash(context, 0, dash, 2);
//    CGPoint midLine2[2] = {{rect2.origin.x + rect2.size.width / 2, rect2.origin.y}, {rect2.origin.x + rect2.size.width / 2, rect2.origin.y + rect2.size.height}};
//    CGContextStrokeLineSegments(context, midLine2, 2);
//    CGContextRestoreGState(context);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextRotateCTM(context, M_PI_4);
//    CGContextStrokeRect(context, rect2);
//    
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillEllipseInRect(context, CGRectMake(-5, -5, 10, 10));
//    
//    CGContextSaveGState(context);
//    CGContextSetLineDash(context, 0, dash, 2);
//    CGContextStrokeLineSegments(context, midLine2, 2);
//    CGContextRestoreGState(context);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
//    CGContextTranslateCTM(context, -self.bounds.size.width / 6, -self.bounds.size.height / 6);
//    CGContextStrokeRect(context, rect2);
//    
//    CGContextSaveGState(context);
//    CGContextSetLineDash(context, 0, dash, 2);
//    CGContextStrokeLineSegments(context, midLine2, 2);
//    CGContextRestoreGState(context);

    /***********************************************************************/
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, self.bounds);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    
//    CGRect rect1 = CGRectMake(60, 90, 100, 130);
//    CGContextStrokeRect(context, rect1);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    rect1 = CGRectMake(10, 25, 200, 260);
//    CGContextStrokeRect(context, rect1);
//    
//   
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    CGPoint line1[2] = {{60, 90}, {15, 32}};
//    CGContextStrokeLineSegments(context, line1, 2);
//    
//    CGContextSetLineJoin(context, kCGLineJoinBevel);
//    CGPoint line11[3] = {{15, 32 + 8 * cos(M_PI_4) + 2}, {15, 31}};
//    CGContextStrokeLineSegments(context, line11, 2);
//    CGPoint line12[3] = {{15, 32}, {15 + 8 * sin(M_PI_4), 32}};
//    CGContextStrokeLineSegments(context, line12, 2);
//    
//    
//    CGPoint line2[2] = {{160, 90}, {200, 35}};
//    CGContextStrokeLineSegments(context, line2, 2);
//    
//    CGContextSetLineJoin(context, kCGLineJoinBevel);
//    CGPoint line21[3] = {{200, 35 + 8 * cos(M_PI_4) + 2}, {200, 34}};
//    CGContextStrokeLineSegments(context, line21, 2);
//    CGPoint line22[3] = {{200, 35}, {200 - 8 * sin(M_PI_4), 35}};
//    CGContextStrokeLineSegments(context, line22, 2);
//    
//    CGPoint line3[2] = {{160, 220}, {205, 279}};
//    CGContextStrokeLineSegments(context, line3, 2);
//    
//    CGContextSetLineJoin(context, kCGLineJoinBevel);
//    CGPoint line31[3] = {{205, 279 - 8 * cos(M_PI_4) - 2}, {205, 280}};
//    CGContextStrokeLineSegments(context, line31, 2);
//    CGPoint line32[3] = {{205, 279}, {205 - 8 * sin(M_PI_4), 279}};
//    CGContextStrokeLineSegments(context, line32, 2);
//    
//    CGPoint line4[2] = {{60, 220}, {15, 280}};
//    CGContextStrokeLineSegments(context, line4, 2);
//    
//    CGContextSetLineJoin(context, kCGLineJoinBevel);
//    CGPoint line41[3] = {{15, 280 - 8 * cos(M_PI_4) - 2}, {15, 279}};
//    CGContextStrokeLineSegments(context, line41, 2);
//    CGPoint line42[3] = {{15, 280}, {15 + 8 * sin(M_PI_4), 280}};
//    CGContextStrokeLineSegments(context, line42, 2);
    
    ////////////////////////////////////
//    UIImage *image = [UIImage imageNamed:@"backgroud.jpg"];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect rect1 = CGRectMake(50, 50, 200, 250);
    CGContextStrokeRect(context, rect1);
    
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGFloat dash[2] = {3, 3};
    CGContextSetLineDash(context, 0, dash, 2);
    CGRect rect2 = CGRectMake(100, 100, 120, 160);
    CGContextStrokeRect(context, rect2);
    
    
    
}


@end
