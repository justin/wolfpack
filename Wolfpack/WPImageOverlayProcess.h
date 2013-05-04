// WPImageOverlayProcess.h
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
//          "actionType" : "image",
//          "alpha" : 1.0,
//          "blendMode" : "darken",
//          "imageName" : "border",
//      }
//  ]


// Supported Keys
//
// "actionType" - Should be "image"
// "alpha" - The alpha value between 0.0 and 1.0
// "blendMode" - Should be one of the supported blend modes listed in WPConstants
// "imageName" - The name of the image. No extension required.
@interface WPImageOverlayProcess : WPProcess

@property (nonatomic, strong) CIImage *image;

@end
