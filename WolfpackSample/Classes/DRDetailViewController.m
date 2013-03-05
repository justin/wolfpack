//
//  DRDetailViewController.m
//  WolfpackSample
//
//  Created by Justin Williams on 11/16/12.
//  Copyright (c) 2012 Second Gear. All rights reserved.
//

#import "DRDetailViewController.h"
#import <Wolfpack/Wolfpack.h>

@interface DRDetailViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation DRDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.filter processImage:self.image completion:^(UIImage *processedImage) {
        self.image = processedImage;
    }];
}

#pragma mark -
#pragma mark Dynamic Accessor Methods
// +--------------------------------------------------------------------
// | Dynamic Accessor Methods
// +--------------------------------------------------------------------

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self configureView];
}

#pragma mark -
#pragma mark Private/Convenience Methods
// +--------------------------------------------------------------------
// | Private/Convenience Methods
// +--------------------------------------------------------------------

- (void)configureView
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = self.image;
}

@end
