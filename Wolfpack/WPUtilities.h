// WPUtilities.h
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
#import <Foundation/Foundation.h>

// Creates a string with the resolution-specific name for an image asset.
// The resolution is based on the device type. For instance an iPhone 5 would
// return ImageName_2448.
//
// imageName - The name of the image you want to fetch from the filter.
//
//
// Returns the image name with the resolution appended (Image_2448).
extern NSString * DRDeviceSpecificImageName(NSString *imageName);

// Converts a Wolfpack key for a blend mode into one that is compatible with
// Core Image.
//
//
// blendMode -  The Wolfpack key for the specific blend mode. If it's an unsupported
//              blend mode it will return nil.
//
// Returns the name of the Core Image filter for a specific blend mode.
extern NSString * DRCIFilterNameForBlendMode(NSString *blendMode);