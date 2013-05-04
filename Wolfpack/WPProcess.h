// WPProcess.h
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
//  Generic subclass for each kind of process that can happen to an image.
//  Current and future subclasses include:
//  - WPBlurProcess
//  - WPColorProcess
//  - WPCurveProcess
//  - WPImageOverlayProcess
//  - WPLinearGradientProcess
//  - WPRadialGradientProcess
//  - WPScriptProcess

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import "WPFilter.h"

@interface WPProcess : NSObject

@property (strong) WPFilter *filter;
@property (strong) NSDictionary *steps;
@property (copy) NSString *ciFilterName;
@property (assign) CGFloat alpha;

- (instancetype)initWithFilter:(WPFilter *)filter dictionary:(NSDictionary *)steps;

- (CIImage *)performWithInputImage:(CIImage *)inputImage;

@end
