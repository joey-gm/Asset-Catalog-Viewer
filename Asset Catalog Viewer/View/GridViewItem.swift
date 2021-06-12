//
//  GridViewItem.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import AppKit

/// A collection view item to display the rendition and its asset name and rendition name.
final class GridViewItem: NSCollectionViewItem {
    
    /// The reuse identifier for the grid view.
    static let reuseIdentifier = NSUserInterfaceItemIdentifier("GridViewItemID")
    
    /// An image view that displays the rendition.
    unowned let renditionView: NSImageView
    
    /// A text field that displays the name of the asset.
    unowned let primaryLabel: NSTextField
    
    /// A text field that displays the name of the rendition.
    unowned let secondaryLabel: NSTextField
    
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        // Configure rendition image view
        let renditionView = NSImageView()
        renditionView.wantsLayer = true
        renditionView.translatesAutoresizingMaskIntoConstraints = false
        if let layer = renditionView.layer {
            layer.cornerRadius = 7.5
            layer.borderWidth = 1
            layer.borderColor = NSColor.gray.withAlphaComponent(0.3).cgColor
            layer.masksToBounds = true
        }
        self.renditionView = renditionView
        // Configure primary label view
        let primaryLabel = NSTextField(labelWithString: String())
        primaryLabel.wantsLayer = true
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.cell?.lineBreakMode = .byTruncatingTail
        primaryLabel.alignment = .center
        self.primaryLabel = primaryLabel
        // Configure secondary label view
        let secondaryLabel = NSTextField(labelWithString: String())
        secondaryLabel.wantsLayer = true
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.cell?.lineBreakMode = .byTruncatingTail
        secondaryLabel.alignment = .center
        secondaryLabel.textColor = .secondaryLabelColor
        self.secondaryLabel = secondaryLabel
        // Configure grid view item
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view = NSView()
        view.wantsLayer = true
        view.addSubview(renditionView)
        view.addSubview(primaryLabel)
        view.addSubview(secondaryLabel)
        // Configure layout constraints
        NSLayoutConstraint.activate([
            renditionView.topAnchor.constraint(equalTo: view.topAnchor),
            renditionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            renditionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            renditionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -10),
            primaryLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondaryLabel.widthAnchor.constraint(equalTo: primaryLabel.widthAnchor),
            secondaryLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            guard let layer = renditionView.layer else { return }
            switch isSelected {
            case true:
                layer.backgroundColor = NSColor.selectedContentBackgroundColor.cgColor
                layer.borderColor = NSColor.selectedContentBackgroundColor.cgColor
                layer.borderWidth = 2
            case false:
                layer.backgroundColor = .clear
                layer.borderColor = NSColor.gray.withAlphaComponent(0.3).cgColor
                layer.borderWidth = 1
            }
        }
    }
    
}
