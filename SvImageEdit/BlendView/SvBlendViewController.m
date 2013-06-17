//
//  SvBlendViewController.m
//  SvImageEdit
//
//  Created by  maple on 5/13/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvBlendViewController.h"
#import "SvBlendSampleView.h"

@interface SvBlendViewController ()

@end

@implementation SvBlendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    SvBlendSampleView *blendView = [[SvBlendSampleView alloc] initWithFrame:self.view.bounds];
    blendView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:blendView];
    [blendView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
