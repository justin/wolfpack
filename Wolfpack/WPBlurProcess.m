// WPBlurProcess.h
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

#import "WPBlurProcess.h"
#import "WPUtilities.h"
#import "WPConstants.h"
#import "CIColor+WPAdditions.h"

@interface WPBlurProcess ()
@property (nonatomic, strong) NSNumber *blurRadius;
@end

@implementation WPBlurProcess

- (instancetype)initWithFilter:(WPFilter *)filter dictionary:(NSDictionary *)steps;
{
    if ((self = [super init]))
    {
        self.filter = filter;
        self.steps = steps;
        self.ciFilterName = @"CIGaussianBlur";
        self.alpha = [steps[kWPProcessAlphaKey] floatValue];
        self.blurRadius = @([steps[@"blurRadius"] floatValue] * 1000);
    }
    return self;
}

- (CIImage *)performWithInputImage:(CIImage *)inputImage
{
    CIFilter *filter = [CIFilter filterWithName:self.ciFilterName];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:self.blurRadius forKey:@"inputRadius"];
    CIImage *blurredOutput = filter.outputImage;
    
    // Blend it as another layer.
    CIFilter *blendFilter = [CIFilter filterWithName:DRCIFilterNameForBlendMode(self.steps[kWPProcessBlendModeKey])];
    [blendFilter setValue:inputImage forKey:kCIInputImageKey];
    [blendFilter setValue:blurredOutput forKey:kCIInputBackgroundImageKey];
    
    return [blendFilter.outputImage imageByCroppingToRect:inputImage.extent];
}

@end
