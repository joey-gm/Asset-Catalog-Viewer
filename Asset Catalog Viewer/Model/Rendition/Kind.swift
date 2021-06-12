//
//  Kind.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//


/// The type of rendition.
///
/// This enumeration represents the various types of renditions and can be used to group the renditions in a hierarchical tree structure.
///
/// There are three implicit groups:
/// - All: All-encompassing grouping that include all types of renditions.
/// - Main Categories: This is the groupings for the outline view, namely Color, Data, Icon, Image, ImageSet, PDF, and Vector.
/// - Subcategories: This is the detailed type definition of the rendition upon parsing the asset catalog file, which is determined by the `Layout` and `PixelFormat` of the rendition. The property `Rendition._kind` uses this detailed type to determine the appropriate data extraction when exporting the rendition.
enum Kind: Comparable {
    
    
    /// The all-encompassing type
    case All
    
    
    // MARK: - Main Categories
    
    /// Icon Rendition
    ///
    /// The icon rendition class could be `_CUIThemePixelRendition` or `_CUIInternalLinkRendition`
    case Icon
    
    /// Image Rendition
    ///
    /// The image rendition class could be `_CUIThemePixelRendition` or `_CUIInternalLinkRendition` or `_CUIRawPixelRendition`
    case Image
    
    /// Image Set Rendition
    ///
    /// aka Packed Image or Image Atlas.
    /// Class: `_CUIThemePixelRendition`
    case ImageSet
    
    /// PDF Rendition
    ///
    /// Class:  `_CUIThemePDFRendition`
    case PDF
    
    /// SVG Rendition
    ///
    /// Class:  `_CUIThemeSVGRendition`
    case Vector
    
    /// Color Rendition
    ///
    /// Class:  `_CUIThemeColorRendition`
    case Color
    
    /// Data Rendition
    ///
    /// Class:  `_CUIRawDataRendition`
    case Data
    
    
    // MARK: - Subcategories - Image
    
    /// Image Rendition - JPEG
    case Image_JPEG
    
    /// Image Rendition - HEIV
    case Image_HEIV
    
    
    // MARK: - Subcategories - Color
    
    /// Color Rendition - P3 Color Space
    case Color_P3
    
    /// Color Rendition - sRGB Color Space
    case Color_SRGB
    
    /// Color Rendition - Extended sRGB Color Space
    case Color_ExtendedSRGB
    
    /// Color Rendition - Extended Linear sRGB Color Space
    case Color_ExtendedLinearSRGB
    
    /// Color Rendition - Gray Color Space
    case Color_Gray
    
    /// Color Rendition - Extended Gray Color Space
    case Color_ExtendedGray
    
    
    /// Returns the name of the given enum case.
    var string: String { return String(describing: self) }
    
}
