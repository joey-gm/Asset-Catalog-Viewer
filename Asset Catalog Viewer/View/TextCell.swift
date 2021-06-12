//
//  TextCell.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import AppKit

/// A text view where the NSTextField is vertically centered.
final class TextCell: NSView {
    
    /// A text field that displays a string in the text cell view.
    unowned let textField: NSTextField
    
    /// Initializes a plain text cell with the given text.
    /// - Parameter text: A string of plain text assigned to the text field.
    init(text: String) {
        let textField = NSTextField(labelWithString: text)
        self.textField = textField
        super.init(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.cell?.lineBreakMode = .byTruncatingTail
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
