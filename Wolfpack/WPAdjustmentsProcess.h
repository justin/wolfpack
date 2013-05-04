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

#import <Wolfpack/Wolfpack.h>

//
// Sample JSON
//
//
//  "processing" : [
//      {
//          "actionType" : "adjustment",
//          "brightness" : 0.6
//          "contrast" : 0.5
//          "saturation" : 1.0
//      }
//  ]


// Supported Keys
//
// "actionType" - Should be "adjustment"
// "brightness" - An integer value between 0.0 and 1.0 to adjust the image brightness.
// "contrast" - An integer value between 0.0 and 1.0 to adjust the image contrast.
// "saturation" - An integer value between 0.0 and 1.0 to adjust the image saturation.
@interface WPAdjustmentsProcess : WPProcess

@end
