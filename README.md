# Wolfpack 0.0.1

Wolfpack is an image processing library for iOS and OS X. With the vast improvements to Core Image brought on by iOS 6, working with images on the iPhone and iPad has never been easier. 

This is a total work in progress.

## Installation

- Add -ObjC to target's Other Linker Flags
- Target Dependency is libWolfpack
- Link against libWolfpack, libz, libc++, CoreImage, CoreGraphics, Accelerate
- Import <Wolfpack/Wolfpack.h> where you want to use it.

## What's There

* Apply a variety of different effects and overlays to an image based off a filter file bundle.
* Crop images off as squares, ready to upload to that photo social network.

## What's Not

* Documentation is non-existent outside of this README file.
* Lua script processing does not work 
* Curve file (ACV) processing currently does not work. 

## The .filter file format 

Wolfpack works with "filter" files that contain the assets and instructions for routinely applying an effect to your image.  A .filter file is just a zipped bundle of images, scripts and JSON parsing information that Wolfpack uses to apply its effects to an image.

Why JSON instead of plist? The idea is to make the filter file format platform-agnostic so someone could build an Android, Windows Phone or whatever processing engine that uses the same file formats.

### filter.json

You can see a sample filter description at: [https://gist.github.com/justin/5087965](https://gist.github.com/justin/5087965)

* _formatVersion_: Allow for versioning of filters for changes going forward
* _filterIdentifier_: A unique identifier for your filter. Reverse DNS notation
* _filterName_: The user visible name of your filter
* _filterDescription_: A description of what your filter does
* _requirements:_ In the case that your filter uses a platform-specific technology you can define those settings here. Should be an array.
* _organizationName_: Duh?
* _organizationURL_: The URL for your company/org
* _sampleImages_: An array of sample images bundled with your filter showing what a finalized photo may look like. Should match the size of the of the filter downloaded.
* _processing_: An array of the steps that are to be performed on the image. 

#### Support processing types:
* blur: A gaussian blur
* color: Apply a color blend
* adjustment: Apply image adjustments like brightness, contrast, etc
* curve: [Not Implemented Yet]
* gradient: Supports a `gradientType` of either `linear` or `radial`
* image: Overlay an image using a specific blending mode.
* script: [Not Implemented Yet]
* CoreImage: A free-form CoreImage action that you can use with any supported CIFilter.

### Filter Conventions

1. "Packaging" artwork allows you to give the filter a logo or some other design asset to visually identify it.  Artwork be called 'packaging.png' and 'packaging@2x.png' respectively.
2. Each filter should be distributed based on the device image output size. At current time that is 1536, 1936, and 2448. By breaking each filter out like this saves bandwidth for the user since they only have to download the image assets for their specific device size. Filters should be named accordingly: Filter_1536.filter, Filter_2448.filter, Filter_2448.filter
3. String assets can be localized if they are stored in the language specific .lproj folder. [Not Currently Implemented]
4. The `filterize.rb` script in Script will generate the filters for each supported size. See the 'NoirFilter' sample folder for an example of how stuff should be named.
5. Scripts (when supported) should be Lua based.

## Requirements

Wolfpack requires iOS 6 and uses ARC. 

## Credits & Contact

Wolfpack was lovingly created by [Justin Williams](https://github.com/justin) ([@justin](https://twitter.com/justin) on Twitter). 

## License

Wolfpack is licensed under the MIT license. See the LICENSE file for more info.
