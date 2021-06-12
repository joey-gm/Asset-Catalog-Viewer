//
//  AssetCatalog.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import Foundation
import UniformTypeIdentifiers

/// A model representing an asset catalog.
struct AssetCatalog {
    
    /// A strong reference of the CoreUI Catalog class.
    private let catalog: CUICatalog
    
    /// A node structure representing the named assets in an asset catalog.
    let assets: ContiguousArray<Item>
    
    /// An array of renditions in an asset catalog.
    let renditions: ContiguousArray<Rendition>
    
    /// System appearance lookup dictionary.
    let appearances: [UInt16: String]
    
    /// Localization lookup dictionary.
    let localizations: [UInt16: String]
    
    
    /// Initializes an asset catalog from the file at the specified URL.
    /// - Parameter url: A URL specifying the location an asset file.
    /// - Throws: This initializer throws an error if the asset catalog parsing fails, or if the data read is corrupted or otherwise invalid.
    init(url: URL) throws {
        do {
            self.catalog = try CUICatalog(url: url)
        } catch {
            throw error.localizedDescription.isEmpty ? CoreUIError.invalidFile : error
        }
        
        // Retrieves the CUIStructuredThemeStore object.
        let themeStore = catalog._themeStore()
        // Maps the appearance and localization lookup dictionaries.
        self.appearances = Dictionary(uniqueKeysWithValues: themeStore.appearances().map { ($1.uint16Value, $0.appearanceString) } )
        self.localizations = Dictionary(uniqueKeysWithValues: themeStore.localizations().map { ($1.uint16Value, $0) } )
        
        // Percent formatter.
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.maximumFractionDigits = 1
        
        // Decimal number formatter.
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 3
        
        // Retrieves all asset keys (CUIRenditionKey).
        let renditionKeys = themeStore.store().allAssetKeys()
        let count = renditionKeys.endIndex
        
        // Initializes a contiguously stored array of renditions.
        var renditions = ContiguousArray<Rendition>()
        renditions.reserveCapacity(count)
        
        // Temporary collections of unique asset names
        var imageKeys = Set<String>()
        imageKeys.reserveCapacity(count)
        var iconKeys = imageKeys
        var imageSetKeys = imageKeys
        var colorKeys = imageKeys
        var pdfKeys = imageKeys
        var vectorKeys = imageKeys
        var rawDataKeys = imageKeys
        
        // The theme index is needed to initiate a CUINamedVectorGlyph object for SVG renditions.
        let themeIndex = catalog.storageRef
        
        // Loops through all rendition keys in reverse order such that assets in larger resolution appear first.
        for key in renditionKeys.reversed() {
            
            // Retrieves the renditionkeytoken
            let keyList = key.keyList()
            
            // Loads the rendition
            guard let cuiRendition = themeStore.rendition(withKey: keyList),
                  let layout = Layout(rawValue: cuiRendition.type) else { continue }
            
            let renditionKey = RenditionKey(key: key)
            var renditionName = cuiRendition.name()
            
            // Sets the asset name if available
            let assetName: String
            if let name = themeStore.renditionName(forKeyList: keyList) {
                assetName = name
            } else {
                assetName = renditionName.hasPrefix("ZZZZPackedAsset") ? String(renditionName.prefix(21).dropFirst(4)) : renditionName
            }
            
            let kind: Kind
            let pixelFormat = PixelFormat(rawValue: cuiRendition.pixelFormat())
            
            // Categorizes the rendition and renames renditionName where appropriate
            switch layout {
            
            // Unsupported layouts
            case .Effect, .Gradient, .LayerStack, .InternalLink, .ExternalLink, .NamedContent, .ThinningPlaceholder, .TextStyle, .Texture, .TextureImage, .ModelAsset, .ModelMesh, .ModelSubMesh, .RecognitionGroup, .RecognitionObject, .MultisizeImageSet:
                continue
                
            case .Color:
                let cgColor = cuiRendition.cgColor().takeUnretainedValue()
                guard let colorSpace = cgColor.colorSpace,
                      let colorSpaceName = colorSpace.name as String?,
                      let components = cgColor.components,
                      let firstComponent = components.first else { continue }
                switch colorSpaceName.dropFirst(13) {
                case "DisplayP3":
                    kind = .Color_P3
                    renditionName = "P3 ("
                    renditionName += decimalFormatter.string(from: firstComponent)
                    renditionName += ", "
                    renditionName += decimalFormatter.string(from: components[1])
                    renditionName += ", "
                    renditionName += decimalFormatter.string(from: components[2])
                    renditionName += ")"
                case "SRGB":
                    kind = .Color_SRGB
                    renditionName = components.colorHex
                case "ExtendedSRGB":
                    kind = .Color_ExtendedSRGB
                    renditionName = components.colorHex
                    renditionName += " Extended sRGB"
                case "ExtendedLinearSRGB":
                    kind = .Color_ExtendedLinearSRGB
                    renditionName = components.colorHex
                    renditionName += " Extended Linear sRGB"
                case "GenericGrayGamma2_2":
                    kind = .Color_Gray
                    renditionName = percentFormatter.string(from: firstComponent)
                    renditionName += " Gray"
                case "ExtendedGray":
                    kind = .Color_ExtendedGray
                    renditionName = percentFormatter.string(from: firstComponent)
                    renditionName += " Extended Gray"
                default:
                    continue
                }
                if cgColor.alpha < 1 {
                    renditionName += ", alpha: "
                    renditionName += percentFormatter.string(from: cgColor.alpha)
                }
                colorKeys.insert(assetName)
                
            case .RawData:
                kind = .Data
                rawDataKeys.insert(assetName)
                // The rendition name of _CUIRawDataRendition is "CoreStructuredImage".
                // The file name appears in the asset name without the filename extension.
                renditionName = assetName
                let dataUTI = cuiRendition.utiType()
                if #available(macOS 11.0, *) {
                    if let utiType = UTType(dataUTI),
                       let fileExtension = utiType.preferredFilenameExtension {
                        renditionName += "."
                        renditionName += fileExtension
                    }
                } else if let fileExtension = UTTypeCopyPreferredTagWithClass(dataUTI as CFString, kUTTagClassFilenameExtension) {
                        renditionName += "."
                        renditionName += String(fileExtension.takeRetainedValue())
                }
                
            case .Vector:
                guard pixelFormat == .PDF else { continue }
                kind = .PDF
                pdfKeys.insert(assetName)
                if renditionName.hasSuffix(".pdf") {
                    renditionName.removeLast(4)
                }
                
            case .VectorGlyph:
                guard #available(OSX 10.15, *), pixelFormat == .SVG else { continue }
                kind = .Vector
                vectorKeys.insert(assetName)
                if renditionName.hasSuffix(".svg") {
                    renditionName.removeLast(4)
                }
                renditionName += renditionKey.glyphInfo
                
            case .Packed:
                kind = .ImageSet
                imageSetKeys.insert(assetName)
                if key.themeDimension1 != 0 {
                    renditionName += "_Dim-"
                    renditionName += String(key.themeDimension1)
                }
                if key.themeAppearance != 0 {
                    renditionName += "_"
                    renditionName += String(key.themeAppearance)
                }
                
            default:
                if renditionKey.part == .MultisizeImagePart {
                    kind = .Icon
                    iconKeys.insert(assetName)
                } else {
                    guard let pixelFmt = pixelFormat else { continue }
                    switch pixelFmt {
                    case .JPEG: kind = .Image_JPEG
                    case .HEIF: kind = .Image_HEIV
                    default:    kind = .Image
                    }
                    imageKeys.insert(assetName)
                }
                let suffix = renditionName.suffix(4)
                if suffix == ".jpg" || suffix == ".png" || suffix == ".svg" || suffix == ".pdf" {
                    renditionName.removeLast(4)
                }
                let scales = renditionName.suffix(3).lowercased()
                if scales == "@2x" || scales == "@3x" {
                    renditionName.removeLast(3)
                }
                if renditionKey.displayGamut == .P3 {
                    renditionName += "_P3"
                }
                if suffix == ".svg" {
                    renditionName += renditionKey.glyphInfo
                    if key.themeDimension2 > 0 {
                        renditionName += "_Part-"
                        renditionName += String(key.themeDimension2)
                    }
                }
                if key.themeScale > 1 {
                    renditionName += "@"
                    renditionName += String(key.themeScale)
                    renditionName += "x"
                }
            }
            
            // Initializes the rendition struct.
            let rendition = Rendition(themeIndex, cuiRendition, renditionKey, kind, assetName, renditionName)
            renditions.append(rendition)
        }
        
        renditions.sort {
            ($0.kind, $0.assetName.lowercased()) < ($1.kind, $1.assetName.lowercased())
        }
        self.renditions = renditions
        
        // Creates a node structure that represents the named assets.
        var assets: ContiguousArray<Item> = [Item(name: "All", isGroup: true, kind: .All)]
        assets.append(keys: iconKeys, kind: .Icon)
        assets.append(keys: imageKeys, kind: .Image)
        assets.append(keys: vectorKeys, kind: .Vector)
        assets.append(keys: pdfKeys, kind: .PDF)
        assets.append(keys: colorKeys, kind: .Color)
        assets.append(keys: imageSetKeys, kind: .ImageSet)
        assets.append(keys: rawDataKeys, kind: .Data)
        self.assets = assets
        
    }
    
    /// The attribute identifiers that the asset catalog used to encode the rendition keys.
    var attributeIDs: Set<AttributeID> {
        // Retrieves the keyFormat struct in the form of NSData
        let keyFormatData = catalog._themeStore().store().keyFormatData()
        // Copies the data bytes into an array of UInt32
        var keyfmt = [UInt32](repeating: 0, count: keyFormatData.count / MemoryLayout<UInt32>.stride)
        _ = keyfmt.withUnsafeMutableBytes { keyFormatData.copyBytes(to: $0) }
        // Drops the first three UInt32 ("tag", "version" and "maximumRenditionKeyTokenCount" respectively) to get the attribute identifiers (aka keyToken)
        // Maps the UInt32 attribute identifiers into a Set of enumerations
        return Set(keyfmt.dropFirst(3).compactMap { AttributeID(rawValue: $0) })
    }
    
}


private extension Array where Element == CGFloat {
    
    /// Returns the color hex string with a given array of color component intensity values.
    var colorHex: String {
        var value = 0x1000000
        value |= lround(Double(self[0] * 255)) << 16
        value |= lround(Double(self[1] * 255)) << 8
        value |= lround(Double(self[2] * 255))
        var colorHex = "#"
        colorHex += String(value, radix: 16, uppercase: true).dropFirst()
        return colorHex
    }
    
}
