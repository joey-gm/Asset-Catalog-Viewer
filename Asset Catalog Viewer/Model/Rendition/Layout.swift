//
//  Layout.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//


/// The Layout of the rendition.
///
/// This is the value that identifies the type or subtype of the rendition.
enum Layout: Int64 {
    
    // MARK: - Rendition Type
    // Constant Prefix: kCoreTheme, aka Asset Type
    
    /// Image - One Part
    case OnePart = 0
    /// Image - Three Part Horizontal
    case ThreePartHorizontal = 1
    /// Image - Three Part Vertical
    case ThreePartVertical = 2
    /// Image - Nine Part
    case NinePart = 3
    /// Image - Twelve Part
    case TwelvePart = 4
    /// Image - Many Part
    case ManyPart = 5
    /// Gradient
    case Gradient = 6
    /// Effect
    case Effect = 7
    /// Animation
    case Animation = 8
    /// Vector
    case Vector = 9
    /// Raw Data
    case RawData = 1000
    /// External Link
    case ExternalLink = 1001
    /// Layer Stack
    case LayerStack = 1002
    /// Internal Link
    case InternalLink = 1003
    /// Packed Image Atlas
    case Packed = 1004
    /// Named Content
    case NamedContent = 1005
    /// Thinning Placeholder
    case ThinningPlaceholder = 1006
    /// Texture
    case Texture = 1007
    /// Texture Image
    case TextureImage = 1008
    /// Color
    case Color = 1009
    /// Multi-size Image Set
    case MultisizeImageSet = 1010
    /// Top-level Model I/O Asset
    case ModelAsset = 1011
    /// Model I/O Mesh
    case ModelMesh = 1012
    /// Recognition Group
    case RecognitionGroup = 1013
    /// Recognition Object
    case RecognitionObject = 1014
    /// Text Style
    case TextStyle = 1015
    /// Model I/O Sub-Mesh
    case ModelSubMesh = 1016
    /// Vector Glyph
    case VectorGlyph = 1017
    
    
    // MARK: - Rendition Subtype
    // Constant Prefix: kCUIRenditionType, aka Image Type
    
    /// Image - One Part Fixed Size
    case OnePartFixedSize = 10
    /// Image - One Part Tiled
    case OnePartTile = 11
    /// Image - One Part Scaled
    case OnePartScale = 12
    /// Image - Three Part Horizontal Tiled
    case ThreePartHTile = 20
    /// Image - Three Part Horizontal Scaled
    case ThreePartHScale = 21
    /// Image - Three Part Horizontal Uniform
    case ThreePartHUniform = 22
    /// Image - Three Part Vertical Tiled
    case ThreePartVTile = 23
    /// Image - Three Part Vertical Scaled
    case ThreePartVScale = 24
    /// Image - Three Part Vertical Uniform
    case ThreePartVUniform = 25
    /// Image - Nine Part Tiled
    case NinePartTile = 30
    /// Image - Nine Part Scaled
    case NinePartScale = 31
    /// Image - Nine Part Horizontal Uniform Vertical Scaled
    case NinePartHorizontalUniformVerticalScale = 32
    /// Image - Nine Part Horizontal Scaled Vertical Uniform
    case NinePartHorizontalScaleVerticalUniform = 33
    /// Image - Nine Part Edges Only
    case NinePartEdgesOnly = 34
    /// Image - Many Part Layout Unknown
    case ManyPartLayoutUnknown = 40
    /// Animation Filmstrip
    case AnimationFilmstrip = 50
    
}
