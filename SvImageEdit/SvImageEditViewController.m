//
//  SvImageEditViewController.m
//  SvImageEdit
//
//  Created by  maple on 5/7/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvImageEditViewController.h"

#import "SvImageCropView.h"
#import "SvImagePathCropView.h"
#import "SvImageEdit.h"

#define IMAGE_VIEW_BOUND_MARGIN  20

#define PATH_CROP

@interface SvImageEditViewController () {
    UIImageView     *_imageView;
    UIImage         *_orignalImg;       // 原图
    UIImage         *_currentImg;       // 当前显示的图片
    
    CGRect          _imgRealRect;       // 图片显示的真实区域
    CGFloat         _imgShowScale;      // 图片真实大小/图片显示大小
    
    SvImageCropView     *_cropView;         // 用于裁剪图片的view
    SvImagePathCropView *_pathCropView;
}

@property (nonatomic, retain) UIImage *orignalImg;
@property (nonatomic, retain) UIImage *currentImg;

@end

@implementation SvImageEditViewController

@synthesize orignalImg = _orignalImg;
@synthesize currentImg = _currentImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _currentImg = nil;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.toolbarHidden = NO;
    
    self.title = @"Edit";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    SvTransformView *transformV = [[SvTransformView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:transformV];
//    [transformV release];
    
//    transformV = [[SvTransformView alloc] initWithFrame:self.view.bounds];
//    transformV.color11 = [UIColor blueColor];
//    transformV.transform = CGAffineTransformMakeRotation(M_PI_4);
//    [self.view addSubview:transformV];
//    [transformV release];
    
//    SvTransformView *transformV = [[SvTransformView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
//    transformV.center = CGPointMake(160, 200);
//    [self.view addSubview:transformV];
//    [transformV release];
//    
//    return;
    
    // set navibar
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelEdit)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    // set toolbar
    UIBarButtonItem *loadImageBtn = [[UIBarButtonItem alloc] initWithTitle:@"load" style:UIBarButtonItemStyleBordered target:self action:@selector(chooseImg)];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *rotate90Clockwise = [[UIBarButtonItem alloc] initWithTitle:@"45" style:UIBarButtonItemStyleBordered target:self action:@selector(rotateImg45)];
    
//    UIBarButtonItem *rotate90Clockwise = [[UIBarButtonItem alloc] initWithTitle:@"45" style:UIBarButtonItemStyleBordered target:self action:@selector(rotateImg90)];
    
    UIBarButtonItem *rotate90CounterClockwise = [[UIBarButtonItem alloc] initWithTitle:@"90" style:UIBarButtonItemStyleBordered target:self action:@selector(rotateImg90CounterClockwise)];
    
    UIBarButtonItem *cropItem= [[UIBarButtonItem alloc] initWithTitle:@"crop" style:UIBarButtonItemStyleBordered target:self action:@selector(showCropView)];
    
    UIBarButtonItem *flipItem = [[UIBarButtonItem alloc] initWithTitle:@"flipH" style:UIBarButtonItemStyleBordered target:self action:@selector(flipH)];
    
    self.toolbarItems = [NSArray arrayWithObjects:flexItem, loadImageBtn, flexItem, cropItem, flexItem, rotate90Clockwise, flexItem,  rotate90CounterClockwise, flexItem, flipItem, flexItem, nil];
    
    [loadImageBtn release];
    [flexItem release];
    [rotate90Clockwise release];
    [rotate90CounterClockwise release];
    [cropItem release];
    [flipItem release];

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(IMAGE_VIEW_BOUND_MARGIN, IMAGE_VIEW_BOUND_MARGIN, self.view.bounds.size.width -  2 * IMAGE_VIEW_BOUND_MARGIN, self.view.bounds.size.height - 2 * IMAGE_VIEW_BOUND_MARGIN)];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = _currentImg;
    _imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView];
    [_imageView release];
    
    [self updateImageRealRect];

    _cropView = nil;
    _pathCropView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_orignalImg release];
    [_currentImg release];
    
    [super dealloc];
}

- (void)updateImageRealRect
{
    _imgShowScale = 1;
    _imgRealRect = _imageView.bounds;
    
    if (_currentImg) {
        CGFloat imageRatio = _currentImg.size.width / _currentImg.size.height;
        CGFloat imageViewRatio = _imageView.bounds.size.width / _imageView.bounds.size.height;
        
        CGFloat realHeight = 0, realWidth = 0;
        if (imageViewRatio >= imageRatio) {
            realHeight = _imageView.bounds.size.height;
            realWidth = imageRatio * realHeight;
        }
        else {
            realWidth = _imageView.bounds.size.width;
            realHeight = realWidth / imageRatio;
        }
        
        _imgShowScale = _currentImg.size.width * _currentImg.scale / realWidth;
        
        _imgRealRect = CGRectMake(_imageView.bounds.size.width / 2 - realWidth / 2,
                                  _imageView.bounds.size.height / 2 - realHeight / 2,
                                  realWidth, realHeight);
    }
}

- (void)setOrignalImg:(UIImage *)orignalImg
{
    if (_orignalImg != orignalImg) {
        [_orignalImg release];
        _orignalImg = [orignalImg retain];
    }
       
    [self setCurrentImg:_orignalImg];
}

- (void)setCurrentImg:(UIImage *)currentImg
{
    if (_currentImg != currentImg) {
        [_currentImg release];
        _currentImg = [currentImg retain];
    }
    
    _imageView.image = _currentImg;
    CGRect rect = CGRectOffset(_imgRealRect, _imageView.frame.origin.x, _imageView.frame.origin.y);
    [self updateImageRealRect];
    if (_cropView && !_cropView.hidden) {
        _cropView.cropBoundsRect = rect;
    }
    
    if (_pathCropView && !_pathCropView.hidden) {
        _pathCropView.cropBoundsRect = rect;
    }
}


#pragma mark -
#pragma mark Navbar Action

- (void)cancelEdit
{
    [self setOrignalImg:_orignalImg];
}

- (void)saveEdit
{
    UIImage *image = _currentImg;
    
#ifndef PATH_CROP
    
    if (_cropView && !_cropView.hidden) {
        // 显示的裁剪区域
        CGRect cropRect = [_cropView getRealCropRect];
        
        // 乘以显示比例，得到真实的裁剪大小
        CGRect cropRectToImage = CGRectApplyAffineTransform(cropRect, CGAffineTransformMakeScale(_imgShowScale, _imgShowScale));
        image = [_currentImg cropImageWithRect:cropRectToImage];
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
    }
    
#else
    
    if (_pathCropView && !_pathCropView.hidden) {
        
        // 显示的裁剪区域
//        NSArray *path = [_pathCropView getCropPath];
//        NSMutableArray *pointArray = [NSMutableArray array];
//        CGPoint point = CGPointZero;
//        for (int i = 0; i < path.count; ++i) {
//            point = [[path objectAtIndex:i] CGPointValue];
//            point.x *= _imgShowScale;
//            point.y *= _imgShowScale;
//            [pointArray addObject:[NSValue valueWithCGPoint:point]];
//        }
//        
//        image = [_currentImg cropImageWithPath:pointArray];
        
        CGRect cropRect = [_pathCropView getCropRect];
        cropRect = CGRectApplyAffineTransform(cropRect, CGAffineTransformMakeScale(_imgShowScale, _imgShowScale));
        image = [_currentImg cropImageWithRect:cropRect];
        
        [_pathCropView emptyPath];
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
    }
    
#endif
    
    [self setOrignalImg:image];
}


#pragma mark -
#pragma mark toolBar Action

- (void)chooseImg
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    [imagePicker release];
}

- (void)showCropView
{
    
#ifndef PATH_CROP
    if (!_cropView) {
        _cropView = [[SvImageCropView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [self.view addSubview:_cropView];
        [_cropView release];
    }
    
    [self updateImageRealRect];
    _cropView.cropBoundsRect = CGRectOffset(_imgRealRect, _imageView.frame.origin.x, _imageView.frame.origin.y);
    _cropView.hidden = NO;
    
#else
    if (!_pathCropView) {
        _pathCropView = [[SvImagePathCropView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [self.view addSubview:_pathCropView];
        [_pathCropView release];
    }
    
    [self updateImageRealRect];
    _pathCropView.cropBoundsRect = CGRectOffset(_imgRealRect, _imageView.frame.origin.x, _imageView.frame.origin.y);
    _pathCropView.hidden = NO;
    
#endif
}

- (void)hideCropView
{
    _cropView.hidden = YES;
    
    _pathCropView.hidden = YES;
}

- (void)rotateImg45
{
    [self hideCropView];
    
    self.currentImg = [_currentImg rotateImageWithRadian:M_PI_4 * 3 cropMode:enSvCropClip];
    [self.view bringSubviewToFront:_imageView];
}

- (void)rotateImg90
{
    [self hideCropView];
    
    self.currentImg = [_currentImg rotate90CounterClockwise];
}

- (void)rotateImg90CounterClockwise
{
    [self hideCropView];
    
    self.currentImg = [_currentImg rotate90Clockwise];
}

- (void)flipH
{
    [self hideCropView];
    
    self.currentImg = [_currentImg flipHorizontal];
}

- (void)flipV
{
    [self hideCropView];
    
    self.currentImg = [_currentImg flipVertical];
}


#pragma mark -
#pragma mark UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self setOrignalImg:image];
    [self.navigationController dismissViewControllerAnimated:YES completion:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancel Choose");
    [self.navigationController dismissViewControllerAnimated:YES completion:NO];
}


@end
