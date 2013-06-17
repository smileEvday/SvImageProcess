//
//  SvImageDataViewController.m
//  SvImageEdit
//
//  Created by  maple on 5/12/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvImageDataViewController.h"
#import "UIImage+Data.h"

@implementation SvImageDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.toolbarHidden = NO;
    self.title = @"Edit";
    self.view.backgroundColor = [UIColor grayColor];
    
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height - 44 - 49)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [imageView release];
    
    UIImage *image = [UIImage imageNamed:@"IMG_1607.JPG"];
    imageView.image = image;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelf)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"green image" style:UIBarButtonItemStyleBordered target:self action:@selector(makeGreen)];
    self.toolbarItems = [NSArray arrayWithObject:barItem];
    [barItem release];
}

- (void)makeGreen
{
    void *imgData = NULL;
    NSInteger width, height;
    CGImageAlphaInfo alphaInfo;
    
    // ABGR
    if ([imageView.image getImageData:&imgData width:&width height:&height alphaInfo:&alphaInfo]) {
        
        // nGray=0.299*R+0.587*G+0.114*B
        int *pData = (int*)imgData;
        for (int j = 0; j < height; ++j) {
            for (int i = 0; i < width; ++i) {
                *(pData + i + j * width) &= 0xFF00FF00;
            }
        }

        UIImage *image = [UIImage createImageWithData:imgData width:width height:height alphaInfo:alphaInfo];
        imageView.image = image;
        
        free(imgData);
    }
}

- (void)dismissSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
