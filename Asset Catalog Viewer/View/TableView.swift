//
//  TableView.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import Foundation
import Quartz

/// A table view that displays the selected renditions.
final class TableView: NSTableView {
    
    override func keyDown(with theEvent: NSEvent) {
        // Invoke Quicklook preview panel when the user has pressed space bar (keyCode 49 = space key)
        if theEvent.keyCode == 49, !selectedRowIndexes.isEmpty {
            guard let panel = QLPreviewPanel.shared() else { return }
            if QLPreviewPanel.sharedPreviewPanelExists() && panel.isVisible {
                panel.orderOut(nil)
            } else {
                panel.makeKeyAndOrderFront(nil)
            }
        } else {
            super.keyDown(with: theEvent)
        }
    }
    
    /// Adds a column as the last column of the table view with the given column ID and column width.
    /// - Parameters:
    ///   - id: The ID of the table column’s header, which is the column title in form of an enum case.
    ///   - width: The table column’s width, in points.
    func addTableColumn(_ id: TableColumn, width: CGFloat = 75) {
        let title = id.rawValue
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(title))
        column.title = title
        column.sortDescriptorPrototype = NSSortDescriptor(key: title, ascending: true)
        column.width = width
        addTableColumn(column)
    }
    
    /// Adds the rendition column to the table view.
    func addRenditionColumn() {
        let title = TableColumn.Rendition.rawValue
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(title))
        column.title = title
        column.width = 75
        addTableColumn(column)
    }
    
}


/// An enumeration of table columns.
enum TableColumn: String {
    
    /// Rendition Column
    case Rendition = "Rendition"
    
    /// Asset Name Column
    case AssetName = "Asset Name"
    
    /// Rendition Name Column
    case RenditionName = "Rendition Name"
    
    /// Rendition Kind Column
    case Kind = "Kind"
    
    /// Scale Column
    case Scale = "Scale"
    
    /// Device Column
    case Device = "Device"
    
    /// Appearance Column
    case Appearance = "Appearance"
    
    /// Localization Column
    case Localization = "Localization"
    
    /// Display Gamut Column
    case Gamut = "Gamut"
    
    /// Glyph Weight Column
    case GlyphWeight = "Glyph Weight"
    
    /// Glyph Size Column
    case GlyphSize = "Glyph Size"
    
    /// Graphics Feature Set Class Column
    case Graphics = "Graphics"
    
    /// Memory Class Column
    case Memory = "Memory"
    
}

