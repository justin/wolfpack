//
//  DRAboutViewController.m
//  Wolfpack
//
//  Created by Justin Williams on 11/16/12.
//  Copyright (c) 2012 Second Gear. All rights reserved.
//

#import "DRAboutViewController.h"

@implementation DRAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        
    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle
// +--------------------------------------------------------------------
// | View Lifecycle
// +--------------------------------------------------------------------

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *buildNumber = info[@"CFBundleVersion"];
    self.buildNumberLabel.text = [NSString stringWithFormat:@"Build %@", buildNumber];
}

#pragma mark -
#pragma mark IBAction Methods
// +--------------------------------------------------------------------
// | IBAction Methods
// +--------------------------------------------------------------------

- (IBAction)followOnTwitter:(id)sender
{
    NSURL *twitterURL = [NSURL URLWithString:@"https://twitter.com/justin"];
    [[UIApplication sharedApplication] openURL:twitterURL];
}

- (IBAction)openGitHub:(id)sender
{
    NSURL *githubURL = [NSURL URLWithString:@"https://github.com/justin/wolfpack"];
    [[UIApplication sharedApplication] openURL:githubURL];
}

- (IBAction)openSupport:(id)sender
{
    NSURL *githubURL = [NSURL URLWithString:@"http://carpeaqua.com/contact/"];
    [[UIApplication sharedApplication] openURL:githubURL];
}

@end
