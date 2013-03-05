//
//  DRDetailViewController.h
//  WolfpackSample
//
//  Created by Justin Williams on 11/16/12.
//  Copyright (c) 2012 Second Gear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Wolfpack/WPFilter.h>

@interface DRDetailViewController : UIViewController
@property (nonatomic, strong) WPFilter *filter;
@property (nonatomic, strong) UIImage *image;

@end
