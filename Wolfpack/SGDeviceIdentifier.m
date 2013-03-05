// SGDeviceIdentifier.h
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

#import "SGDeviceIdentifier.h"
#import <sys/sysctl.h>

@interface SGDeviceIdentifier ()
+ (NSString *)devicePlatform;
@end

@implementation SGDeviceIdentifier

+ (NSString *)deviceName
{
    NSString *platform = [[self class] devicePlatform];
    
    NSRange phoneRange = [platform rangeOfString:@"iPhone" options:NSCaseInsensitiveSearch];
    NSRange tabletRange = [platform rangeOfString:@"iPad" options:NSCaseInsensitiveSearch];
    if (phoneRange.location == 0)
    {
        return @"iPhone";
    }
    else if (tabletRange.location == 0)
    {
        return @"iPad";
    }
    else
    {
        return @"iPod touch";
    }
    
    return @"";
}

+ (CGSize)deviceBackCameraResolution
{
    NSString *platform = [[self class] devicePlatform];

    if ([platform isEqualToString:@"iPhone1,1"])    return CGSizeMake(640,480); // Original
    if ([platform isEqualToString:@"iPhone1,2"])    return CGSizeMake(640,480); // 3G
    if ([platform isEqualToString:@"iPhone2,1"])    return CGSizeMake(2048,1536); // 3GS
    if ([platform isEqualToString:@"iPhone3,1"])    return CGSizeMake(2592,1936); // 4
    if ([platform isEqualToString:@"iPhone3,2"])    return CGSizeMake(3264,2448); // Mystery 4!
    if ([platform isEqualToString:@"iPhone3,3"])    return CGSizeMake(3264,2448); // VZW 4
    if ([platform isEqualToString:@"iPhone4,1"])    return CGSizeMake(3264,2448); // 4S
    if ([platform isEqualToString:@"iPhone5,1"])    return CGSizeMake(3264,2448); // 5 GSM
    if ([platform isEqualToString:@"iPhone5,2"])    return CGSizeMake(3264,2448); // 5 CDMA
        
    if ([platform isEqualToString:@"iPod1,1"])      return CGSizeZero; // iPod 1g
    if ([platform isEqualToString:@"iPod2,1"])      return CGSizeZero; // iPod 2g
    if ([platform isEqualToString:@"iPod3,1"])      return CGSizeZero; // iPod 3g
    if ([platform isEqualToString:@"iPod4,1"])      return CGSizeMake(960,720); // iPod 4g
    if ([platform isEqualToString:@"iPod5,1"])      return CGSizeMake(2592,1936); // iPod 5g
    if ([platform isEqualToString:@"iPad1,1"])      return CGSizeZero; // iPad 1

    if ([platform isEqualToString:@"iPad2,1"])      return CGSizeMake(1280,720); // iPad 2 WiFi
    if ([platform isEqualToString:@"iPad2,2"])      return CGSizeMake(1280,720); // iPad 2 GSM
    if ([platform isEqualToString:@"iPad2,3"])      return CGSizeMake(1280,720); // iPad 2 CDMA
    if ([platform isEqualToString:@"iPad2,3"])      return CGSizeMake(1280,720); // iPad 2 CDMA
    if ([platform isEqualToString:@"iPad2,3"])      return CGSizeMake(1280,720); // iPad 2 CDMA
    if ([platform isEqualToString:@"iPad2,4"])      return CGSizeMake(1280,720); // iPad 2 New GEn

    if ([platform isEqualToString:@"iPad3,1"])      return CGSizeMake(2592,1936); // iPad 3 WiFi
    if ([platform isEqualToString:@"iPad3,2"])      return CGSizeMake(2592,1936); // iPad 3 CDMA
    if ([platform isEqualToString:@"iPad3,3"])      return CGSizeMake(2592,1936); // iPad 3 GSM
    if ([platform isEqualToString:@"iPad3,4"])      return CGSizeMake(2592,1936); // iPad 4 WiFi
    if ([platform isEqualToString:@"iPad3,5"])      return CGSizeMake(2592,1936); // iPad 4 CDMA
    if ([platform isEqualToString:@"iPad3,6"])      return CGSizeMake(2592,1936); // iPad 4 GSM

    // iPad mini
    if ([platform isEqualToString:@"iPad2,5"])      return CGSizeMake(2592,1936); // iPad mini CDMA
    if ([platform isEqualToString:@"iPad2,6"])      return CGSizeMake(2592,1936); // iPad mini CDMA

    if ([platform isEqualToString:@"i386"])         return CGSizeZero; // Sim
    if ([platform isEqualToString:@"x86_64"])       return CGSizeZero; // Sim

    return CGSizeZero;
}

#pragma mark -
#pragma mark Private/Convenience Methods
// +--------------------------------------------------------------------
// | Private/Convenience Methods
// +--------------------------------------------------------------------

+ (NSString *)devicePlatform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

@end
