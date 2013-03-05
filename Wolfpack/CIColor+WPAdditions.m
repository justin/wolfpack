// CIColor+WPAdditions.m
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
#import "CIColor+WPAdditions.h"

@implementation CIColor (WPAdditions)

+ (CIColor *)colorWithRGBString:(NSString *)rgbString
{
    return [CIColor colorWithRGBString:rgbString alpha:1.0];
}

+ (CIColor *)colorWithRGBString:(NSString *)rgbString alpha:(CGFloat)alpha
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?:([0-9]{1,3}))" options:0 error:&error];
    
    NSString *colorString = rgbString;
    float rgb[3] = { 255, 255, 255 }, *rgbPtr;
    rgbPtr = rgb;
    __block NSUInteger count = 0;
        
    [regex enumerateMatchesInString:colorString options:0 range:NSMakeRange(0,[colorString length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (NSEqualRanges(result.range, NSMakeRange(0, 0)) == NO)
        {
            rgbPtr[count] = [[colorString substringWithRange:result.range] floatValue];
            count++;;
        }
    }];
    
    return [CIColor colorWithRed:rgbPtr[0]/255 green:rgbPtr[1]/255 blue:rgbPtr[2]/255 alpha:alpha];
}

@end
