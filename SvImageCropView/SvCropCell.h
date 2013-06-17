//
//  SvCropCell.h
//  SvImageEdit
//
//  Created by  maple on 5/7/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_WIDTH 45

enum {
    enCropCellPosLT = 0,    // 左上角
    enCropCellPosRT = 1,    // 右上角
    enCropCellPosRB = 2,    // 右下角
    enCropCellPosLB = 3,    // 左下角
};
typedef NSInteger SvCropCellPos;

@class SvCropCell;
@protocol SvCropCellDelegate <NSObject>

- (void)moveCell:(SvCropCell*)cell toPos:(CGPoint)newCenter;

@end


@interface SvCropCell : UIImageView

@property (nonatomic, readonly) SvCropCellPos cropCellPos;
@property (nonatomic, assign) id<SvCropCellDelegate> delegate;


- (id)initWithCenter:(CGPoint)center pos:(SvCropCellPos)cellPos;



@end
