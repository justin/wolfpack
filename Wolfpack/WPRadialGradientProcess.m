// WPRadialGradientProcess.h
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
#import "WPRadialGradientProcess.h"
#import "CIColor+WPAdditions.h"
#import "WPConstants.h"
#import "WPUtilities.h"

@interface WPRadialGradientProcess ()
@property (strong) CIVector *inputCenter;
@property (strong) CIColor *color0;
@property (strong) CIColor *color1;
@property (strong) NSNumber *radius0;
@property (strong) NSNumber *radius1;
@end

@implementation WPRadialGradientProcess

- (instancetype)initWithFilter:(WPFilter *)filter dictionary:(NSDictionary *)steps
{
    if ((self = [super init]))
    {
        self.filter = filter;
        self.steps = steps;
        self.ciFilterName = @"CIRadialGradient";
        self.alpha = [steps[kWPProcessAlphaKey] floatValue];
        
        NSArray *colors = steps[@"colors"];
        _color0 = [CIColor colorWithRGBString:colors[0] alpha:self.alpha];
        _color1 = [CIColor colorWithRGBString:colors[1] alpha:self.alpha];
        
        NSArray *radiuses = steps[@"radiuses"];
        _radius0 = radiuses[0];
        _radius1 = radiuses[1];
    }
    return self;
}

- (CIImage *)performWithInputImage:(CIImage *)inputImage
{
    CIFilter *filter = [CIFilter filterWithName:self.ciFilterName];
    
    // These points are a % along the gradient's image view. The values are the start
    // and end points so we multiply them by the height/width respectively to get
    // an approximation.
    [filter setValue:self.color0 forKey:@"inputColor0"];
    [filter setValue:self.color1 forKey:@"inputColor1"];
    [filter setValue:self.radius0 forKey:@"inputRadius0"];
    [filter setValue:self.radius1 forKey:@"inputRadius1"];
    
    CIImage *outputGradient = filter.outputImage;
    
    CIFilter *blendFilter = [CIFilter filterWithName:DRCIFilterNameForBlendMode(self.steps[kWPProcessBlendModeKey])];
    [blendFilter setValue:inputImage forKey:kCIInputImageKey];
    [blendFilter setValue:outputGradient forKey:kCIInputBackgroundImageKey];
    
    return [blendFilter.outputImage imageByCroppingToRect:inputImage.extent];
}
@end

