//
//  DRMasterViewController.m
//  WolfpackSample
//
//  Created by Justin Williams on 11/16/12.
//  Copyright (c) 2012 Second Gear. All rights reserved.
//

#import "DRMasterViewController.h"
#import "DRDetailViewController.h"
#import <Wolfpack/Wolfpack.h>

@implementation DRMasterViewController

#pragma mark -
#pragma mark UIStoryboardSegue Methods
// +--------------------------------------------------------------------
// | UIStoryboardSegue Methods
// +--------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DRDetailViewController *detailViewController = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"RAWSegue"])
    {
        NSURL *rawFilterURL = [[NSBundle mainBundle] URLForResource:@"RAW_1536" withExtension:@"filter"];
        detailViewController.filter = [[WPFilter alloc] initWithFilterAtURL:rawFilterURL];
        detailViewController.image = [UIImage imageNamed:@"Sample2.jpg"];
    }
    
    if ([segue.identifier isEqualToString:@"GothamSegue"])
    {
        NSURL *noirFilterURL = [[NSBundle mainBundle] URLForResource:@"Noir_1536" withExtension:@"filter"];
        detailViewController.filter = [[WPFilter alloc] initWithFilterAtURL:noirFilterURL];
        detailViewController.image = [UIImage imageNamed:@"Sample1.jpg"];
    }

    if ([segue.identifier isEqualToString:@"WarmerSegue"])
    {
        detailViewController.image = [UIImage imageNamed:@"Sample2.jpg"];
    }
    
    if ([segue.identifier isEqualToString:@"CoolerSegue"])
    {
        detailViewController.image = [UIImage imageNamed:@"Sample3.jpg"];
    }
    
    if ([segue.identifier isEqualToString:@"HighContrastBWSegue"])
    {
        detailViewController.image = [UIImage imageNamed:@"Sample4.jpg"];
    }
    
    if ([segue.identifier isEqualToString:@"DesaturatedSegue"])
    {
        detailViewController.image = [UIImage imageNamed:@"Sample5.jpg"];
    }
    
    if ([segue.identifier isEqualToString:@"WolfpackSegue"])
    {
        detailViewController.image = [UIImage imageNamed:@"Sample2.jpg"];
    }
}

@end
