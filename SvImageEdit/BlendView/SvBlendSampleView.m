//
//  SvBlendSampleView.m
//  SvBlendSampleView
//
//  Created by mapleCao on 13-5-13.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "SvBlendSampleView.h"

@interface SvBlendSampleView () {
    UIImage *frontImage;
    UIImage *backImage;
    CGRect  frontImgRect;
    CGRect  backImgRect;
    
    UIScrollView *scrollView;
    NSInteger    currentBlendMode;
}

@end


@implementation SvBlendSampleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        frontImage = [UIImage imageNamed:@"ghost.JPG"];
        backImage = [UIImage imageNamed:@"backgroud.jpg"];
        
        
        frontImgRect = [self getAspectFitRect:frontImage];
        backImgRect = [self getAspectFitRect:backImage];
        
        currentBlendMode = kCGBlendModeNormal;
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 60, self.bounds.size.width, 60)];
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor grayColor];
        [scrollView release];
        
        scrollView.contentSize = CGSizeMake((45 + 10) * kCGBlendModePlusLighter + 10, 60);
        for (int i = 0; i < kCGBlendModePlusLighter; ++i) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(55 * i, 7, 45, 45);
            [btn addTarget:self action:@selector(chooseBlendMode:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.tag = i;
            [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [scrollView addSubview:btn];
        }
    }
    return self;
}

- (CGRect)getAspectFitRect:(UIImage*)image
{
    CGFloat width, height;
    if (self.bounds.size.width / self.bounds.size.height > image.size.width / image.size.height) {
        height = self.bounds.size.height;
        width = height * image.size.width / image.size.height;
    }
    else {
        width = self.bounds.size.width;
        height = width * image.size.height / image.size.width;
    }
    
    return CGRectMake(self.bounds.size.width / 2 - width / 2, self.bounds.size.height / 2 - height / 2, width, height);
}

- (void)chooseBlendMode:(UIButton*)sender
{
    currentBlendMode = sender.tag;

    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    [backImage drawInRect:backImgRect];
    
    [frontImage drawInRect:frontImgRect blendMode:currentBlendMode alpha:0.8];
    
}

@end
