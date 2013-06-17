//
//  SvImagePathCropView.m
//  SvImageEdit
//
//  Created by  maple on 5/12/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvImagePathCropView.h"

@interface SvImagePathCropView () {
    NSMutableArray  *_pointArray;
    BOOL            _isMoving;
}

@end

@implementation SvImagePathCropView

@synthesize cropBoundsRect = _cropBoundsRect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _pointArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)dealloc
{
    [_pointArray release];
    
    [super dealloc];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (_pointArray.count == 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    static CGFloat lengths[2] = {3, 3};
    CGContextSetLineDash(context, 2, lengths, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextBeginPath(context);
    CGPoint *points = malloc(sizeof(CGPoint) * _pointArray.count);
    for (int i = 0; i < _pointArray.count; ++i) {
        points[i] = [[_pointArray objectAtIndex:i] CGPointValue];
    }
    CGContextAddLines(context, points, _pointArray.count);
    free(points);
    
    // draw clip outbounding rect after select area
    if (!_isMoving) {
        CGRect pathBound = CGContextGetPathBoundingBox(context);
        CGContextStrokeRect(context, pathBound);
    }
    
    // draw the clip path
    CGContextStrokePath(context);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_pointArray removeAllObjects];
    
    CGPoint location = [[touches anyObject] locationInView:self];
    location = [self constraintPioinInCropRect:location];
    [_pointArray addObject:[NSValue valueWithCGPoint:location]];
    
    _isMoving = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInView:self];
    location = [self constraintPioinInCropRect:location];
    [_pointArray addObject:[NSValue valueWithCGPoint:location]];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isMoving = NO;
    
    CGPoint location = [[touches anyObject] locationInView:self];
    location = [self constraintPioinInCropRect:location];
    [_pointArray addObject:[NSValue valueWithCGPoint:location]];
     
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isMoving = NO;
    
    CGPoint location = [[touches anyObject] locationInView:self];
    location = [self constraintPioinInCropRect:location];
    [_pointArray addObject:[NSValue valueWithCGPoint:location]];
    
    [self setNeedsDisplay];
}

- (CGPoint)constraintPioinInCropRect:(CGPoint)location
{
    if (location.x < _cropBoundsRect.origin.x) {
        location.x = _cropBoundsRect.origin.x;
    }
    else if (location.x > _cropBoundsRect.origin.x + _cropBoundsRect.size.width) {
        location.x = _cropBoundsRect.origin.x + _cropBoundsRect.size.width;
    }
    
    if (location.y < _cropBoundsRect.origin.y) {
        location.y = _cropBoundsRect.origin.y;
    }
    else if (location.y > _cropBoundsRect.origin.y + _cropBoundsRect.size.height) {
        location.y = _cropBoundsRect.origin.y + _cropBoundsRect.size.height;
    }
    
    return location;
}

#pragma mark -
#pragma mark Public Method

- (NSArray*)getCropPath
{
    CGPoint point = CGPointZero;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _pointArray.count; ++i) {
        point = [[_pointArray objectAtIndex:i] CGPointValue];
        point.x += -_cropBoundsRect.origin.x;
        point.y += -_cropBoundsRect.origin.y;
        [array addObject:[NSValue valueWithCGPoint:point]];
    }
    
    return array;
}

- (CGRect)getCropRect
{
    // get boundingbox relate to self's bounds
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGPoint *points = malloc(sizeof(CGPoint) * _pointArray.count);
    for (int i = 0; i < _pointArray.count; ++i) {
        points[i] = [[_pointArray objectAtIndex:i] CGPointValue];
    }
    CGContextAddLines(context, points, _pointArray.count);
    free(points);
    
    // the boundingbox is ralate to bounds, we should convert it to cropboundsRect
    CGRect boundingBox = CGContextGetPathBoundingBox(context);
    boundingBox = CGRectApplyAffineTransform(boundingBox, CGAffineTransformMakeTranslation(-_cropBoundsRect.origin.x, -_cropBoundsRect.origin.y));
    
    UIGraphicsEndImageContext();
    
    return boundingBox;
}

- (void)emptyPath
{
    [_pointArray removeAllObjects];
    
    [self setNeedsDisplay];
}

@end
