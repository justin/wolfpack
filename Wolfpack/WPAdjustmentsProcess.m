// WPAdjustmentsProcess.h
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

#import "WPAdjustmentsProcess.h"
#import "WPUtilities.h"
#import "WPConstants.h"

@interface WPAdjustmentsProcess ()
@property (nonatomic, strong) NSNumber *brightness;
@property (nonatomic, strong) NSNumber *contrast;
@property (nonatomic, strong) NSNumber *saturation;
@end

@implementation WPAdjustmentsProcess

- (instancetype)initWithFilter:(WPFilter *)filter dictionary:(NSDictionary *)steps
{
    if ((self = [super init]))
    {
        self.filter = filter;
        self.steps = steps;
        self.ciFilterName = @"CIColorControls";
        self.alpha = [steps[kWPProcessAlphaKey] floatValue];
        
        _brightness = self.steps[@"brightness"];
        _contrast = self.steps[@"contrast"];
        _saturation = self.steps[@"saturation"];
    }
    return self;
}

- (CIImage *)performWithInputImage:(CIImage *)inputImage
{   
    CIFilter *adjustment = [CIFilter filterWithName:self.ciFilterName];
    [adjustment setValue:inputImage forKey:kCIInputImageKey];
    [adjustment setValue:self.brightness forKey:@"inputBrightness"];
    [adjustment setValue:self.contrast forKey:@"inputContrast"];
    [adjustment setValue:self.saturation forKey:@"inputSaturation"];
    
    return [adjustment.outputImage imageByCroppingToRect:inputImage.extent];
}

@end
