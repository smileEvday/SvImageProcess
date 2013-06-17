//
//  SvCropCell.m
//  SvImageEdit
//
//  Created by  maple on 5/7/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvCropCell.h"

@interface SvCropCell () {
    BOOL isMoving;      // 标记当前cell是否处于移动状态
}

@end


@implementation SvCropCell

@synthesize cropCellPos;
@synthesize delegate;

- (id)initWithCenter:(CGPoint)center pos:(SvCropCellPos)cellPos
{
    self = [super initWithFrame:CGRectMake(0, 0, CELL_WIDTH, CELL_WIDTH)];
    if (self) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"cropDragCell.png"] forState:UIControlStateNormal];
        btn.frame = self.bounds;
        [self addSubview:btn];

        // Initialization code
        self.userInteractionEnabled = YES;
        
        self.center = center;
        cropCellPos = cellPos;
        
        isMoving = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isMoving = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isMoving) {
        UITouch *touch = [touches anyObject];
        CGPoint posInSuperView = [touch locationInView:self.superview];
        if (self.delegate && [self.delegate respondsToSelector:@selector(moveCell:toPos:)]) {
            [self.delegate moveCell:self toPos:posInSuperView];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isMoving = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    isMoving = NO;
}

@end
