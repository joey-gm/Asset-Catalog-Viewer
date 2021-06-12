//
//  String.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns the appearance name without the Cocoa and Cocoa Touch prefix.
    var appearanceString: String {
        let string: String
        if self.hasPrefix("NSAppearanceName") {
            string = String(self.dropFirst(16))
        } else if self.hasPrefix("UIAppearance") {
            string = String(self.dropFirst(12))
        } else {
            string = self
        }
        // Convert camelCase string into space-separated words
        return string.unicodeScalars.reduce(String()) {
            if CharacterSet.uppercaseLetters.contains($1) {
                return $0 + " " + String($1)
            } else {
                return $0 + String($1)
            }
        }
    }
    
}
