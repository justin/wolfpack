// WPFilter.m
//
// Copyright (c) 2013 Justin Williams (http://carpeaqua.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <CoreImage/CoreImage.h>
#import <zipzap/zipzap.h>
#import "WPFilter.h"
#import "WPColorProcess.h"

@implementation WPFilter

- (instancetype)initWithFilterAtURL:(NSURL *)filterURL
{
    if ((self = [super init]))
    {
        _filterURL = filterURL;
        
        if (_filterURL != nil)
        {
            [self parseFilterJSON];
        }
    }
    
    return self;
}

- (void)processCGImage:(CGImageRef)image completion:(WPFilterCompletionHandler)handler
{
    dispatch_queue_t filterQueue = dispatch_queue_create("com.secondgear.wolfpack.process", 0);
    dispatch_async(filterQueue, ^{
        CIImage *ciImage = [[CIImage alloc] initWithCGImage:image options:nil];
        
        __block CIImage *output = ciImage;
        for (WPProcess *process in self.processingSteps)
        {
            output = [process performWithInputImage:output];
        }
        
        // crop the image using CICrop
        CIFilter *crop = [CIFilter filterWithName:@"CICrop"];
        [crop setValue:output forKey:kCIInputImageKey];
        [crop setValue:[CIVector vectorWithCGRect:ciImage.extent] forKey:@"inputRectangle"];
        
        output = crop.outputImage;
        
        // We have to convert from CIImage to a CGImageRef because trying to go
        // straight from CIImage to UIImage causes the image to do weird scaling shit
        // when being thrown into a UIImageView.
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef cgimg = [context createCGImage:output fromRect:[output extent]];
        UIImage *filteredImage = [UIImage imageWithCGImage:cgimg];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(filteredImage);
        });
    });        
}

- (void)processImage:(UIImage *)image completion:(WPFilterCompletionHandler)handler
{
    [self processCGImage:image.CGImage completion:handler];
}

#pragma mark -
#pragma mark Private/Convenience Methods
// +--------------------------------------------------------------------
// | Private/Convenience Methods
// +--------------------------------------------------------------------

- (NSURL *)pathURLForFilterItemNamed:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryFiltersDirectory = [paths[0] stringByAppendingPathComponent:@"Filters"];
    NSString *filterDirectory = [libraryFiltersDirectory stringByAppendingPathComponent:[[self.filterURL lastPathComponent] stringByDeletingPathExtension]];
    return [NSURL fileURLWithPath:[filterDirectory stringByAppendingPathComponent:fileName]];
}

- (NSURL *)pathURLForFilter:(ZZArchive *)filterArchive itemNamed:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *filtersDirectory = [paths[0] stringByAppendingPathComponent:@"Filters"];
    
    NSString *filterName = [[filterArchive.URL lastPathComponent] stringByDeletingPathExtension];
    _filterName = filterName;
    NSString *filterDirectory = [filtersDirectory stringByAppendingPathComponent:filterName];
    NSFileManager *fm = [[NSFileManager alloc] init];
    // Create it if it doesn't exist.
    if ([fm fileExistsAtPath:filterDirectory] == NO)
    {
        NSError *createError = nil;
        [fm createDirectoryAtPath:filterDirectory withIntermediateDirectories:YES attributes:nil error:&createError];
        NSAssert1(createError == nil, @"Error creating directory for filter: %@", fileName);
    }
    
    return [NSURL fileURLWithPath:[filterDirectory stringByAppendingPathComponent:fileName]];
}

- (void)parseFilterJSON
{
    ZZArchive *oldArchive = [ZZArchive archiveWithContentsOfURL:_filterURL];
    
    // We are unpacking the Filter archives in <app>/Library/Filters
    for (ZZArchiveEntry *entry in oldArchive.entries)
    {
        NSError *unzipError = nil;
        NSURL *entryURL = [self pathURLForFilter:oldArchive itemNamed:entry.fileName];
        
        NSFileManager *fm = [[NSFileManager alloc] init];
        // Create it if it doesn't exist.
        if ([entry.fileName hasSuffix:@"/"] == YES)
        {
            NSError *createError = nil;
            [fm createDirectoryAtURL:entryURL withIntermediateDirectories:YES attributes:nil error:nil];
            NSAssert1(createError == nil, @"Error creating directory for filter: %@", entry.fileName);
        }
        else
        {
            [entry.data writeToURL:entryURL options:NSDataWritingFileProtectionCompleteUnlessOpen error:&unzipError];
            [entryURL setResourceValue:entry.lastModified forKey:NSURLContentModificationDateKey error:nil];
            NSAssert1(unzipError == nil, @"Error unzipping file attribute: %@", [entry.fileName lastPathComponent]);
        }
    }

    // Parse the JSON
    NSData *jsonData = [NSData dataWithContentsOfURL:[self pathURLForFilterItemNamed:@"filter.json"]];
    NSError *error = nil;
    NSDictionary *serialized = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    // TODO: handle JSON parsing errors.
    
    _filterName = serialized[@"filterName"];
    _filterDescription = serialized[@"filterDescription"]; // TODO: Need to localized
    _formatVersion = [serialized[@"filterDescription"] floatValue];
    _organizationName = serialized[@"organizationName"];
    _organizationURL = [NSURL URLWithString:serialized[@"organizationURL"]];
    
    // Extract out any bundled sample images.
    NSMutableArray *samples = [[NSMutableArray alloc] init];
    for (NSString *sampleName in serialized[@"sampleImages"])
    {
        NSURL *sampleImageURL = [self pathURLForFilterItemNamed:sampleName];
        if (sampleImageURL != nil)
        {
            [samples addObject:[UIImage imageWithContentsOfFile:[sampleImageURL path]]];
        }
    }
    _sampleImages = samples;
    
    // Extract out the processing steps
    NSMutableArray *processingSteps = [[NSMutableArray alloc] init];
    for (NSDictionary *step in serialized[@"processing"])
    {
        if ([step[@"actionType"] isEqualToString:@"blur"])
        {
            WPBlurProcess *blurProcess = [[WPBlurProcess alloc] initWithFilter:self dictionary:step];
            [processingSteps addObject:blurProcess];
        }
        else if ([step[@"actionType"] isEqualToString:@"color"])
        {
            WPColorProcess *colorProcess = [[WPColorProcess alloc] initWithFilter:self dictionary:step];
            [processingSteps addObject:colorProcess];
            
        }
        else if ([step[@"actionType"] isEqualToString:@"adjustment"])
        {
            WPAdjustmentsProcess *adjustmentProcess = [[WPAdjustmentsProcess alloc] initWithFilter:self dictionary:step];
            [processingSteps addObject:adjustmentProcess];
        }
        else if ([step[@"actionType"] isEqualToString:@"curve"])
        {
            WPCurveProcess *curveProcess = [[WPCurveProcess alloc] initWithFilter:self dictionary:step];
            [processingSteps addObject:curveProcess];
        }
        else if ([step[@"actionType"] isEqualToString:@"gradient"])
        {
            if ([step[@"gradientType"] isEqualToString:@"linear"])
            {
                WPLinearGradientProcess *linearGradientProcess = [[WPLinearGradientProcess alloc] initWithFilter:self dictionary:step];
                [processingSteps addObject:linearGradientProcess];
            }
            else if ([step[@"gradientType"] isEqualToString:@"gradient"])
            {
                WPRadialGradientProcess *radialGradientProcess = [[WPRadialGradientProcess alloc] initWithFilter:self dictionary:step];
                [processingSteps addObject:radialGradientProcess];
            }
        }
        else if ([step[@"actionType"] isEqualToString:@"image"])
        {
            WPImageOverlayProcess *imageProcess = [[WPImageOverlayProcess alloc] initWithFilter:self dictionary:step];
            [processingSteps addObject:imageProcess];
        }
        else if ([step[@"actionType"] isEqualToString:@"script"])
        {
            WPScriptProcess *scriptProcess = [[WPScriptProcess alloc] initWithFilter:self dictionary:step];
            [processingSteps addObject:scriptProcess];

        }
        else if ([step[@"actionType"] isEqualToString:@"CoreImage"])
        {
            WPCoreImageProcess *ciProcess = [[WPCoreImageProcess alloc] initWithFilter:self dictionary:step];
            [processingSteps addObject:ciProcess];
        }
    }
    
    _processingSteps = processingSteps;

    // Set the packaging artwork if necessary
    NSURL *packagingURL = [self pathURLForFilterItemNamed:@"packaging.png"];
    if (packagingURL != nil)
    {
        _packagingArtwork = [UIImage imageWithContentsOfFile:[packagingURL path]];
    }
}

@end
