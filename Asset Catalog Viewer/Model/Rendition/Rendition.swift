//
//  Rendition.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import AppKit

/// A model representing a rendition.
struct Rendition {
    
    /// The rendition object in the CoreUI framework.
    ///
    /// `Rendition` struct keeps a reference to the CUIThemeRendition object, which allows the program to access and export the rendition data upon request.
    ///
    /// There is a strong reference between CUIThemeRendition and CUICatalog, while the reference between CUIThemeRendition and CUIStructuredThemeStore is weak. If the asset catalog is initialized directly via CUIStructuredThemeStore, this property should not be marked as unowned in order to retain the CUIThemeRendition object.
    private unowned let cuiRendition: CUIThemeRendition
    
    /// The detailed type (i.e. the subcategory) of rendition to determine the appropriate data extraction when exporting the rendition.
    private let _kind: Kind
    
    /// The type (i.e. the main category) of rendition that is used to generate the hierarchical tree structure in the outline view.
    let kind: Kind
    
    /// The rendition keys.
    let key: RenditionKey
    
    /// The name of the asset.
    let assetName: String
    
    /// The name of the rendition.
    let renditionName: String
    
    /// The preview rendition image / thumbnail.
    let previewImage: NSImage?
    
    
    /// Initializes a rendition structure.
    /// - Parameters:
    ///   - themeIndex: The theme index of the CUIStructuredThemeStore.
    ///   - cuiRendition: The reference to the CUIThemeRendition object.
    ///   - key: The rendition keys.
    ///   - _kind: The detailed type of the rendition.
    ///   - assetName: The name of the asset.
    ///   - renditionName: The name of the rendition.
    init(_ themeIndex: UInt64, _ cuiRendition: CUIThemeRendition, _ key: RenditionKey, _ _kind: Kind, _ assetName: String, _ renditionName: String) {
        self.cuiRendition = cuiRendition
        self.assetName = assetName
        self.renditionName = renditionName
        self.key = key
        // Sets the types of the rendition.
        self._kind = _kind
        switch _kind {
        case .Image_JPEG, .Image_HEIV:
            self.kind = .Image
        case .Color_P3, .Color_SRGB, .Color_ExtendedSRGB, .Color_ExtendedLinearSRGB, .Color_Gray, .Color_ExtendedGray:
            self.kind = .Color
        default:
            self.kind = _kind
        }
        // Generates preview images
        switch kind {
        case .Icon, .ImageSet, .Image:
            let previewSize = cuiRendition.unslicedSize().scaleAspectFit
            self.previewImage = NSImage(size: previewSize, flipped: false) {
                // CF Get Function
                NSImage(cgImage: cuiRendition.unslicedImage().takeUnretainedValue(), size: previewSize).draw(in: $0)
                return true
            }
        case .PDF:
            // CF Object-creation Function
            let cgImage = cuiRendition.createImageFromPDFRendition(withScale: NSScreen.scale).takeRetainedValue()
            let previewSize = CGSize(width: cgImage.width, height: cgImage.height).scaleAspectFit
            self.previewImage = NSImage(size: previewSize, flipped: false) {
                NSImage(cgImage: cgImage, size: previewSize).draw(in: $0)
                return true
            }
        case .Vector:
            if let canvasSize = CGSize(svgData: cuiRendition.rawData()) {
                let previewSize = canvasSize.scaleAspectFit
                self.previewImage = NSImage(size: previewSize, flipped: false) {
                    let namedVector = CUINamedVectorGlyph(name: nil, using: CUIRenditionKey(keyList: cuiRendition.key()), fromTheme: themeIndex)
                    // CF Object-creation Function
                    let cgImage = namedVector.rasterizeImage(usingScaleFactor: NSScreen.scale, forTargetSize: previewSize).takeRetainedValue()
                    NSImage(cgImage: cgImage, size: previewSize).draw(in: $0)
                    return true
                }
            } else {
                self.previewImage = nil
            }
        case .Color:
            let length: CGFloat = 100
            self.previewImage = NSImage(size: CGSize(width: length, height: length), flipped: false) {
                // CF Get Function -> takeUnretainedValue
                let cgColor = cuiRendition.cgColor().takeUnretainedValue()
                if cgColor.alpha != 1 {
                    NSColor.black.drawSwatch(in: $0)
                    let path = NSBezierPath()
                    path.move(to: .zero)
                    path.line(to: CGPoint(x: length, y: 0))
                    path.line(to: CGPoint(x: length, y: length))
                    path.close()
                    NSColor.white.setFill()
                    path.fill()
                }
                NSColor(cgColor: cgColor)?.drawSwatch(in: $0)
                return true
            }
        case .Data:
            var fileType = cuiRendition.utiType()
            if fileType == "dyn.age8u" {
                // dyn.age8u = data file without extension
                // Swaps the universal type identifier to "Office Open XML", which will return a default macOS file icon.
                fileType = "org.openxmlformats.openxml"
            }
            let fileIcon = NSWorkspace.shared.icon(forFileType: fileType)
            fileIcon.size = CGSize(width: 64, height: 64)
            self.previewImage = fileIcon
        default:
            self.previewImage = nil
        }
    }
    
    /// The type of rendition file being provided for the NSFilePromiseProvider / NSPasteboardWriting.
    var fileType: String? {
        switch _kind {
        case .Image, .ImageSet, .Icon:  return "public.png"
        case .Image_JPEG:               return "public.jpeg"
        case .Image_HEIV:               return "public.heif"
        case .PDF:                      return "com.adobe.pdf"
        case .Vector:                   return "public.svg-image"
        case .Color, .Color_P3, .Color_SRGB, .Color_ExtendedSRGB, .Color_ExtendedLinearSRGB, .Color_Gray, .Color_ExtendedGray:
            // NSPasteboard.PasteboardType.color.rawValue
            return "com.apple.cocoa.pasteboard.color"
        default:
            guard let typeIdentifier = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, URL(fileURLWithPath: renditionName).pathExtension as CFString, nil) else { return nil }
            return typeIdentifier.takeRetainedValue() as String
        }
    }
    
    /// The file name for the exported rendition data.
    var fileName: String {
        let fileExtension: String
        switch _kind {
        case .Image, .Icon:
            return assetName + "_" + renditionName + ".png"
        case .ImageSet:     fileExtension = ".png"
        case .Image_JPEG:   fileExtension = ".jpg"
        case .Image_HEIV:   fileExtension = ".heif"
        case .PDF:          fileExtension = ".pdf"
        case .Vector:       fileExtension = ".svg"
        default:
            return renditionName
        }
        return renditionName + fileExtension
    }
    
    /// Write the contents of the rendition to a location.
    ///
    /// - parameter url: The location to write the rendition data into.
    /// - throws: An error in the Cocoa domain, if there is an error writing to the `URL`.
    func write(to url: URL) throws {
        let data: Data
        switch _kind {
        case .Image, .ImageSet, .Icon:
            // Throws AssetCatalogError.exportFailure
            guard let destination = CGImageDestinationCreateWithURL(url as CFURL, kUTTypePNG, 1, nil) else {
                throw CoreUIError.invalidURL
            }
            CGImageDestinationAddImage(destination, cuiRendition.unslicedImage().takeUnretainedValue(), nil)
            guard CGImageDestinationFinalize(destination) else {
                throw CoreUIError.exportFailure
            }
            return
        case .Image_JPEG, .Image_HEIV, .Vector:
            data = cuiRendition.rawData()
        case .PDF:
            data = cuiRendition.srcData
        case .Data:
            data = cuiRendition.data()
        default:
            return
        }
        try data.write(to: url)
    }
    
}
