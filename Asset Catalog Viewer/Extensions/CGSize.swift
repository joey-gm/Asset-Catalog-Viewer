//
//  CGSize.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import AppKit

extension CGSize {
    
    /// Scales to fit the size of the image view in the Collection View Item (100pt x 100pt) while maintaining the aspect ratio.
    var scaleAspectFit: CGSize {
        let maxPoint: CGFloat = 100
        if width > maxPoint || height > maxPoint {
            let aspectRatio = min(maxPoint / width, maxPoint / height)
            return CGSize(width: aspectRatio * width, height: aspectRatio * height)
        } else {
            return self
        }
    }
    
    /// Returns the canvas size of the vector glyph.
    ///
    /// - Parameters:
    ///   - svgData: The data bytes of the Scalable Vector Graphics (SVG) file encoded in UTF-8 XML
    init?(svgData: Data) {
        guard let svgXML = String(data: svgData, encoding: .utf8),
              let widthRange = svgXML.range(of: "(?<=width=\")[0-9.]+", options: .regularExpression),
              let heightRange = svgXML.range(of: "(?<=height=\")[0-9.]+", options: .regularExpression),
              let width = Double(svgXML[widthRange]),
              let height = Double(svgXML[heightRange]) else { return nil }
        self = CGSize(width: width * NSScreen.scale, height: height * NSScreen.scale)
    }
    
}
