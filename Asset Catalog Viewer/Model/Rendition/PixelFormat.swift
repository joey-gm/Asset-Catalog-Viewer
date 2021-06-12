//
//  PixelFormat.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//


/// The Pixel Format of the rendition.
///
/// The raw value is the ASCII encoding of the pixel format name in big-endian representation.
enum PixelFormat: Int32 {
    
    /// ARGB color model.
    case ARGB   = 0x41524742
    
    /// RGBW color model.
    case RGBW   = 0x52474257
    
    /// RGB5 color model.
    case RGB5   = 0x52474235
    
    /// GA8 colorspace.
    case GA8    = 0x47413820
    
    /// GA16 colorspace.
    case GA16   = 0x47413136
    
    /// PDF.
    case PDF    = 0x50444620
    
    /// JPEG lossy compression image.
    ///
    /// The corresponding rendition class would be `_CUIRawPixelRendition` (kCSIPixelFormatJPEG).
    case JPEG   = 0x4A504547
    
    /// High Efficiency Image File Format.
    ///
    /// The corresponding rendition class would be `_CUIRawPixelRendition` (kCSIPixelFormatHEIF).
    case HEIF   = 0x48454946
    
    /// Raw Data.
    case DATA   = 0x44415441
    
    /// Scalable Vector Graphics.
    case SVG    = 0x53564720
    
}
