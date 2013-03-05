// WPFilter.h
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

//
//  .filter files are parsed here.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^WPFilterCompletionHandler)(UIImage *processedImage);

@interface WPFilter : NSObject

@property (nonatomic, strong, readonly) NSURL *filterURL;
@property (nonatomic, copy, readonly) NSString *filterName;
@property (nonatomic, copy, readonly) NSString *filterDescription;
@property (nonatomic, assign, readonly) CGFloat formatVersion;
@property (nonatomic, copy, readonly) NSString *organizationName;
@property (nonatomic, strong, readonly) NSURL *organizationURL;
@property (nonatomic, strong, readonly) NSArray *sampleImages;
@property (nonatomic, strong, readonly) UIImage *packagingArtwork;
@property (nonatomic, strong, readonly) NSArray *processingSteps;

- (instancetype)initWithFilterAtURL:(NSURL *)filterURL;

// Processing happens on the background, but we return the completion handler
// on the main thread.
- (void)processImage:(UIImage *)image completion:(WPFilterCompletionHandler)handler;
- (void)processCGImage:(CGImageRef)image completion:(WPFilterCompletionHandler)handler;

- (NSURL *)pathURLForFilterItemNamed:(NSString *)fileName;

@end
