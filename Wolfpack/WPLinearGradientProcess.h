// WPLinearGradientProcess.h
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

#import <Wolfpack/Wolfpack.h>

// TODO: Handle rotation of the gradient


//
// Sample JSON
//
//
//  "processing" : [
//      {
//          "actionType" : "gradient",
//          "alpha" : 1.0,
//          "blendMode" : "darken",
//          "gradientType" : "linear",
//          "direction" : "vertical",
//          "colors" : [
//              "rgb(0, 0, 0)",
//              "rgb(225, 255, 255)"
//			],
//          "locations" : [0.2, 0.8]
//      }
//  ]


// Supported Keys
//
// "actionType" - Should be "gradient"
// "alpha" - The alpha value between 0.0 and 1.0
// "blendMode" - Should be one of the supported blend modes listed in WPConstants
// "gradientType" - "linear" or "radial"
// "direction" - [NOT IMPLEMENTED] The direction which the gradient is applied. Should be horizontal or vertical.
// "colors" - The equivalent of inputColor0 and inputColor1. RGB values are only supported in rgb() format. Should only be two values. All others will be ignored.
// "locations" - The equivalent of inputRadius0 and inputRadius1. Should only be two values. All others will be ignored.
@interface WPLinearGradientProcess : WPProcess

@end
