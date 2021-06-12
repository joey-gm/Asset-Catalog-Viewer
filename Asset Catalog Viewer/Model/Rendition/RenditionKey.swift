//
//  RenditionKey.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//


/// A value type for the rendition keys.
///
/// This is a Swift structure that represents the decoded rendition keys. Unlike CUIRenditionKey, `RenditionKey` stores the attributes in enumeration cases where appropriate to allow type-safe access to various rendition attributes.
struct RenditionKey {
    
    /// Theme Identifier.
    ///
    /// Note: identifier 0 = packed assets.
    let identifier:             UInt16
    
    /// Theme Appearance.
    let appearance:             UInt16
    
    /// Theme Localization.
    let localization:           UInt16
    
    /// Theme Dimension 1.
    let dimension1:             UInt16
    
    /// Theme Dimension 2.
    let dimension2:             UInt16
    
    /// Theme Subtype.
    let subtype:                UInt16
    
    /// Theme Element.
    let element:                Attribute.Element
    
    /// Theme Part.
    let part:                   Attribute.Part
    
    /// Theme Idiom.
    let idiom:                  Attribute.Idiom
    
    /// Theme Scale.
    let scale:                  Attribute.Scale
    
    /// Theme Display Gamut.
    let displayGamut:           Attribute.Gamut
    
    /// Theme Size.
    let size:                   Attribute.Size
    
    /// Theme UI Horizontal Size Class.
    let sizeClassHorizontal:    Attribute.SizeClass
    
    /// Theme UI Vertical Size Class.
    let sizeClassVertical:      Attribute.SizeClass
    
    /// Theme Direction.
    let direction:              Attribute.Direction
    
    /// Theme Drawing Layer.
    let layer:                  Attribute.Layer
    
    /// Theme Value.
    let value:                  Attribute.Value
    
    /// Theme Previous Value.
    let previousValue:          Attribute.Value
    
    /// Theme State.
    let state:                  Attribute.State
    
    /// Theme Previous State.
    let previousState:          Attribute.State
    
    /// Theme Presentation State
    let presentationState:      Attribute.PresentationState
    
    /// Theme Memory Class.
    let memoryClass:            Attribute.Memory
    
    /// Theme Graphics Feature Set Class.
    let graphicsClass:          Attribute.Graphics
    
    /// Theme Deployment Target.
    let deploymentTarget:       Attribute.Target
    
    /// Theme Glyph Weight.
    let glyphWeight:            Attribute.GlyphWeight
    
    /// Theme Glyph Size.
    let glyphSize:              Attribute.GlyphSize
    
    
    /// Creates a rendition key structure from the CUIRenditionKey object.
    /// - Parameter key: The CUIRenditionKey object.
    init(key: CUIRenditionKey) {
        self.identifier =           UInt16(key.themeIdentifier)
        self.appearance =           UInt16(key.themeAppearance)
        self.localization =         UInt16(key.themeLocalization)
        self.dimension1 =           UInt16(key.themeDimension1)
        self.dimension2 =           UInt16(key.themeDimension2)
        self.subtype =              UInt16(key.themeSubtype)
        self.element =              Attribute.Element(key.themeElement)
        self.part =                 Attribute.Part(key.themePart)
        self.idiom =                Attribute.Idiom(key.themeIdiom)
        self.scale =                Attribute.Scale(key.themeScale)
        self.displayGamut =         Attribute.Gamut(key.themeDisplayGamut)
        self.size =                 Attribute.Size(key.themeSize)
        self.sizeClassHorizontal =  Attribute.SizeClass(key.themeSizeClassHorizontal)
        self.sizeClassVertical =    Attribute.SizeClass(key.themeSizeClassVertical)
        self.direction =            Attribute.Direction(key.themeDirection)
        self.layer =                Attribute.Layer(key.themeLayer)
        self.value =                Attribute.Value(key.themeValue)
        self.previousValue =        Attribute.Value(key.themePreviousValue)
        self.state =                Attribute.State(key.themeState)
        self.previousState =        Attribute.State(key.themePreviousState)
        self.presentationState =    Attribute.PresentationState(key.themePresentationState)
        self.memoryClass =          Attribute.Memory(key.themeMemoryClass)
        self.graphicsClass =        Attribute.Graphics(key.themeGraphicsClass)
        self.deploymentTarget =     Attribute.Target(key.themeDeploymentTarget)
        self.glyphWeight =          Attribute.GlyphWeight(key.themeGlyphWeight)
        self.glyphSize =            Attribute.GlyphSize(key.themeGlyphSize)
    }
    
    /// Returns a string representation of the glyph weight and size.
    var glyphInfo: String {
        return "_" + glyphWeight.string + "-" + glyphSize.string
    }
    
}
