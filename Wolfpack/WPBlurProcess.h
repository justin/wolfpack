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

#import <Wolfpack/Wolfpack.h>

//
// Sample JSON
//
//
//  "processing" : [
//      {
//          "actionType" : "blur",
//          "blendMode" : "darken",
//          "alpha" : 1.0,
//          "blurType" : "gaussian",
//          "blurRadius" : 0.008
//      }
//  ]


// Supported Keys
//
// "actionType" - Should be "blur"
// "blendMode" - Should be one of the supported blend modes listed in WPConstants
// "alpha" - The alpha value between 0.0 and 1.0
// "blurType" - The type of blur. Currently only gaussian is supported. "radial" coming someday.
// "blurRadius" - The radius of the blur. Equivalent to inputRadius in CIGaussianBlur.
@interface WPBlurProcess : WPProcess

@end
