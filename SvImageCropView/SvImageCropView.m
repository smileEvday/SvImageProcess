//
//  SvImageCropView.m
//  SvImageEdit
//
//  Created by  maple on 5/7/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvImageCropView.h"

#define CROP_CELL_INIT_MARGIN   20
#define CROP_RECT_MIN_WIDTH     45

@interface SvImageCropView () {
    NSMutableArray  *_dragCells;        // 拖动的四个角
    BOOL            isMovingCropArea;   // 是否正在移动裁剪区域
}

@end

@implementation SvImageCropView

@synthesize cropBoundsRect = _cropBoundsRect;
@synthesize cropRatio = _cropRatio;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        _cropRatio = 0;
        _dragCells = [[NSMutableArray alloc] initWithCapacity:4];
        
        // add LT cell
        SvCropCell *cell = [[SvCropCell alloc] initWithCenter:CGPointMake(CROP_CELL_INIT_MARGIN, CROP_CELL_INIT_MARGIN)  pos:enCropCellPosLT];
        cell.delegate = self;
        [self addSubview:cell];
        [_dragCells addObject:cell];
        [cell release];
        
        // RT
        cell = [[SvCropCell alloc] initWithCenter:CGPointMake(self.bounds.size.width - CROP_CELL_INIT_MARGIN, CROP_CELL_INIT_MARGIN) pos:enCropCellPosRT];
        cell.delegate = self;
        [self addSubview:cell];
        [_dragCells addObject:cell];
        [cell release];
        
        // RB
        cell = [[SvCropCell alloc] initWithCenter:CGPointMake(self.bounds.size.width - CROP_CELL_INIT_MARGIN, self.bounds.size.height - CROP_CELL_INIT_MARGIN) pos:enCropCellPosRB];
        cell.delegate = self;
        [self addSubview:cell];
        [_dragCells addObject:cell];
        [cell release];
        
        // LB
        cell = [[SvCropCell alloc] initWithCenter:CGPointMake(CROP_CELL_INIT_MARGIN, self.bounds.size.height - CROP_CELL_INIT_MARGIN) pos:enCropCellPosLB];
        cell.delegate = self;
        [self addSubview:cell];
        [_dragCells addObject:cell];
        [cell release];
        
        self.cropBoundsRect = self.bounds;
    }
    return self;
}

- (void)dealloc
{
    [_dragCells release];
    
    [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGFloat dashLength[2] = {4, 4};
    CGContextSetLineDash(context, 2, dashLength, 2);
    
    CGPoint point[4];
    int i = 0;
    for (SvCropCell *cell in _dragCells) {
        point[i++] = cell.center;
    }
    
    CGRect cropRect = CGRectMake(point[0].x, point[0].y, point[2].x - point[0].x, point[2].y - point[0].y);
    CGContextStrokeRect(context, cropRect);
}

// 四个点之间的区域
- (CGRect)cropArea
{
    CGPoint point[4];
    int i = 0;
    for (SvCropCell *cell in _dragCells) {
        point[i++] = cell.center;
    }
    
    CGRect cropRect = CGRectMake(point[0].x, point[0].y, point[2].x - point[0].x, point[2].y - point[0].y);
    return cropRect;
}

/*
 * @brief 获取真实的裁剪区域
 */
- (CGRect)getRealCropRect
{
    // 相对于自身坐标系
    CGRect cropArea = [self cropArea];
    
    // 转换到相对于cropBoundsRect
    return CGRectOffset(cropArea, -_cropBoundsRect.origin.x, -_cropBoundsRect.origin.y);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isMovingCropArea = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isMovingCropArea) {
        [self moveCropArea:touches];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isMovingCropArea) {
        [self moveCropArea:touches];
    }
    
    isMovingCropArea = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isMovingCropArea) {
        [self moveCropArea:touches];
    }
    
    isMovingCropArea = NO;
}

- (void)moveCropArea:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint preLocation = [touch previousLocationInView:self];
    CGPoint touchLocation = [touch locationInView:self];
    
    CGFloat xMove = touchLocation.x - preLocation.x;
    CGFloat yMove = touchLocation.y - preLocation.y;
    
    CGRect cropArea = [self cropArea];
    if (CGRectContainsPoint(cropArea, touchLocation)) {     // 移动crop区域
        
        if (xMove + cropArea.origin.x < _cropBoundsRect.origin.x) {
            xMove = _cropBoundsRect.origin.x - cropArea.origin.x;
        }
        else if (xMove + cropArea.origin.x + cropArea.size.width > _cropBoundsRect.origin.x + _cropBoundsRect.size.width) {
            xMove = _cropBoundsRect.origin.x + _cropBoundsRect.size.width - cropArea.origin.x - cropArea.size.width;
        }
        
        if (yMove + cropArea.origin.y < _cropBoundsRect.origin.y) {
            yMove = _cropBoundsRect.origin.y - cropArea.origin.y;
        }
        else if (yMove + cropArea.origin.y + cropArea.size.height > _cropBoundsRect.origin.y + _cropBoundsRect.size.height) {
            yMove = _cropBoundsRect.origin.y + _cropBoundsRect.size.height - cropArea.origin.y - cropArea.size.height;
        }
        
        for (SvCropCell *cell in _dragCells) {
            cell.center = CGPointMake(cell.center.x + xMove, cell.center.y + yMove);
        }
        
        [self setNeedsDisplay];
    }
}


#pragma mark -
#pragma mark SvCropCellDelegate

- (void)moveCell:(SvCropCell *)cell toPos:(CGPoint)newCenter
{
    BOOL canMoveCell = NO;
    if (!_cropRatio) {
        canMoveCell = [self moveCell:cell toCenter:newCenter];
    }
    else {
        canMoveCell = [self moveWithRatio:cell toCenter:newCenter];
    }
    
    if (canMoveCell) {
        
        SvCropCell *preCell = [_dragCells objectAtIndex:((cell.cropCellPos - 1 + 4) % 4)];
        SvCropCell *nextCell = [_dragCells objectAtIndex:((cell.cropCellPos + 1) % 4)];
        
        // 同步相邻cell的位置
        if (cell.cropCellPos == enCropCellPosLT || cell.cropCellPos == enCropCellPosRB) {
            preCell.center = CGPointMake(cell.center.x, preCell.center.y);
            nextCell.center = CGPointMake(nextCell.center.x, cell.center.y);
        }
        else {
            preCell.center = CGPointMake(preCell.center.x, cell.center.y);
            nextCell.center = CGPointMake(cell.center.x, nextCell.center.y);
        }
        
        [self setNeedsDisplay];
    }
}

// 固定比例裁剪
- (BOOL)moveWithRatio:(SvCropCell*)cell toCenter:(CGPoint)newCenter
{
    // 不允许越出裁剪边界
    
    // do something
    
    return YES;
}

- (BOOL)moveCell:(SvCropCell*)cell toCenter:(CGPoint)newCenter
{    
    SvCropCell *diagonalCell = [_dragCells objectAtIndex:((cell.cropCellPos + 2) % 4)];
    
    CGFloat newX = newCenter.x;
    CGFloat newY = newCenter.y;
    
    // 维持裁剪区域不小于最小宽度
    switch (cell.cropCellPos) {
        case enCropCellPosLT:
        {
            newX = diagonalCell.center.x - newX >= CROP_RECT_MIN_WIDTH ? newX : diagonalCell.center.x - CROP_RECT_MIN_WIDTH;
            newY = diagonalCell.center.y - newY >= CROP_RECT_MIN_WIDTH ? newY : diagonalCell.center.y - CROP_RECT_MIN_WIDTH;
            break;
        }
        case enCropCellPosRT:
        {
            newX = newX - diagonalCell.center.x >= CROP_RECT_MIN_WIDTH ? newX : diagonalCell.center.x + CROP_RECT_MIN_WIDTH;
            newY = diagonalCell.center.y - newY >= CROP_RECT_MIN_WIDTH ? newY : diagonalCell.center.y - CROP_RECT_MIN_WIDTH;
            break;
        }
        case enCropCellPosRB:
        {
            newX = newX - diagonalCell.center.x >= CROP_RECT_MIN_WIDTH ? newX : diagonalCell.center.x + CROP_RECT_MIN_WIDTH;
            newY = newY - diagonalCell.center.y >= CROP_RECT_MIN_WIDTH ? newY : diagonalCell.center.y + CROP_RECT_MIN_WIDTH;
            break;
        }
        case enCropCellPosLB:
        {
            newX = diagonalCell.center.x - newX >= CROP_RECT_MIN_WIDTH ? newX : diagonalCell.center.x - CROP_RECT_MIN_WIDTH;
            newY = newY - diagonalCell.center.y >= CROP_RECT_MIN_WIDTH ? newY : diagonalCell.center.y + CROP_RECT_MIN_WIDTH;
            break;
        }                
        default:
            break;
    }
    
    // 保证裁剪区域不超过cropBounds
    if (newX < _cropBoundsRect.origin.x)
        newX = _cropBoundsRect.origin.x;
    else if (newX > _cropBoundsRect.origin.x + _cropBoundsRect.size.width)
        newX = _cropBoundsRect.origin.x + _cropBoundsRect.size.width;
    
    if (newY < _cropBoundsRect.origin.y)
        newY = _cropBoundsRect.origin.y;
    else if (newY > _cropBoundsRect.origin.y + _cropBoundsRect.size.height)
        newY = _cropBoundsRect.origin.y + _cropBoundsRect.size.height;
    
    cell.center = CGPointMake(newX, newY);
    
    return YES;
}


#pragma mark -
#pragma mark Publick method

- (void)setCropBoundsRect:(CGRect)cropBoundsRect
{
    _cropBoundsRect = cropBoundsRect;
    
    [self setCropRect:CGRectMake(_cropBoundsRect.origin.x + CROP_CELL_INIT_MARGIN,
                                _cropBoundsRect.origin.y + CROP_CELL_INIT_MARGIN,
                                _cropBoundsRect.size.width - 2 * CROP_CELL_INIT_MARGIN,
                                 _cropBoundsRect.size.height - 2 * CROP_CELL_INIT_MARGIN)];
}

- (void)setCropRect:(CGRect)cropRect
{
    SvCropCell *ltCell = [_dragCells objectAtIndex:0];
    ltCell.center = cropRect.origin;
    
    SvCropCell *rtCell = [_dragCells objectAtIndex:1];
    rtCell.center = CGPointMake(cropRect.origin.x + cropRect.size.width, cropRect.origin.y);
    
    SvCropCell *rbCell = [_dragCells objectAtIndex:2];
    rbCell.center = CGPointMake(cropRect.origin.x + cropRect.size.width, cropRect.origin.y + cropRect.size.height);
    
    SvCropCell *lbCell = [_dragCells objectAtIndex:3];
    lbCell.center = CGPointMake(cropRect.origin.x, cropRect.origin.y + cropRect.size.height);
    
    [self setNeedsDisplay];
}

@end
