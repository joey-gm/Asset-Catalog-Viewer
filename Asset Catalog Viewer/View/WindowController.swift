//
//  WindowController.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import AppKit
import Quartz

/// Asset Catalog Viewer's  window controller.
final class WindowController: NSWindowController {
    
    /// Tab view controller.
    unowned let tabVC: NSTabViewController
    
    /// Display mode segmented control to switch between grid view and list view.
    private let displayModeControl: NSSegmentedControl
    
    /// Global search field.
    weak private var searchField: NSSearchField!
    
    
    /// Returns a window controller initialized with a given window and a given tab view controller.
    /// - Parameters:
    ///   - window: The window object to manage.
    ///   - tabVC: The tab view controller object to manage.
    init(window: NSWindow, tabVC: NSTabViewController) {
        self.tabVC = tabVC
        self.displayModeControl = NSSegmentedControl(images: [NSImage(named: NSImage.iconViewTemplateName)!, NSImage(named: NSImage.listViewTemplateName)!], trackingMode: .selectOne, target: nil, action: #selector(toggleDisplayMode))
        super.init(window: window)
        // Configure window’s toolbar
        displayModeControl.target = self
        displayModeControl.setSelected(true, forSegment: 0)
        let toolbar = NSToolbar(identifier: "Toolbar")
        toolbar.allowsUserCustomization = true
        toolbar.displayMode = .iconOnly
        toolbar.delegate = self
        window.toolbar = toolbar
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension WindowController: NSWindowDelegate {
    
    // MARK: - Update Menu States
    
    func windowDidBecomeKey(_ notification: Notification) {
        Self.updateMenu(displayModeControl.selectedSegment)
        Self.updateMenu(window?.appearance?.name == .darkAqua)
    }
    
}


// MARK: - Window Toolbar

private extension NSToolbarItem.Identifier {
    
    /// The toolbar item identifier for switching the window appearance between dark and light mode.
    static let appearance = NSToolbarItem.Identifier("Appearance")
    
    /// The toolbar item identifier for switching the display mode between grid view and list view.
    static let displayMode = NSToolbarItem.Identifier("Display Mode")
    
    /// The toolbar item identifier for the searchbar.
    static let searchbar = NSToolbarItem.Identifier("Search")
    
    /// The toolbar item identifier for the custom sidebar toggle.
    static let sidebar = NSToolbarItem.Identifier("Sidebar")
    
}


extension WindowController: NSToolbarDelegate {
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        if #available(OSX 11.0, *) {
            return [.sidebar, .displayMode, .appearance, .searchbar, .space]
        } else {
            return [.toggleSidebar, .displayMode, .appearance, .searchbar, .flexibleSpace, .space]
        }
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        if #available(OSX 11.0, *) {
            // The default NSToolbarItem.Identifier.toggleSidebar button will be positioned next to the TrackingSeparator on Big Sur / OSX 11.0 regardless of its position relative to .sidebarTrackingSeparator in the array.
            // Instead of the default .toggleSidebar, initializes a bespoke sidebar toggle button that can be placed directly on top of the sidebar.
            return [.sidebar, .sidebarTrackingSeparator, .displayMode, .appearance, .searchbar]
        } else {
            return [.toggleSidebar, .displayMode, .appearance, .flexibleSpace, .searchbar]
        }
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let toolbarView: NSView
        let identifier = itemIdentifier.rawValue
        switch itemIdentifier {
        case .appearance:
            let imageName = "circle.lefthalf.fill"
            let buttonImage: NSImage
            if #available(OSX 11.0, *), let image = NSImage(systemSymbolName: imageName, accessibilityDescription: identifier) {
                buttonImage = image
            } else if let image = NSImage(named: imageName) {
                buttonImage = image
            } else {
                return nil
            }
            let appearanceButton = NSButton(image: buttonImage, target: self, action: #selector(toggleAppearance))
            appearanceButton.bezelStyle = .texturedRounded
            toolbarView = appearanceButton
        case .displayMode:
            toolbarView = displayModeControl
        case .sidebar:
            let sidebarButton = NSButton(image: NSImage(named: NSImage.touchBarSidebarTemplateName)!, target: contentViewController, action: #selector(NSSplitViewController.toggleSidebar))
            sidebarButton.bezelStyle = .texturedRounded
            toolbarView = sidebarButton
        case .searchbar:
            let searchField = NSSearchField()
            searchField.action = #selector(Document.runSearch)
            if #available(OSX 11.0, *) {
                let searchBarItem = NSSearchToolbarItem(itemIdentifier: itemIdentifier)
                searchBarItem.searchField = searchField
                return searchBarItem
            } else {
                toolbarView = searchField
            }
        default:
            return nil
        }
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        toolbarItem.view = toolbarView
        toolbarItem.label = identifier
        return toolbarItem
    }
    
    func toolbarWillAddItem(_ notification: Notification) {
        // Sets a weak reference to the search bar added to the window's toolbar, which allows the search bar to accept first responder status upon the function call of `focusSearchField`
        guard let item = notification.userInfo?["item"] as? NSToolbarItem,
              item.itemIdentifier == .searchbar else { return }
        if #available(macOS 11.0, *),
           let searchbar = item as? NSSearchToolbarItem {
            searchField = searchbar.searchField
        } else if let searchbarView = item.view as? NSSearchField {
            searchField = searchbarView
        }
    }
    
}


// MARK: - Menu Item

private extension WindowController {
    
    /// The view "As Grid" menu item.
    ///
    /// View > As Grid (`⌘1`)
    static unowned let gridViewMenu: NSMenuItem = viewMenuItem(at: 0)
    
    /// The view "As List" menu item.
    ///
    /// View > As List (`⌘2`)
    static unowned let listViewMenu: NSMenuItem = viewMenuItem(at: 1)
    
    /// The "Light" appearance menu item.
    ///
    /// View > Appearance > Light (`⌘3`)
    static unowned let lightModeMenu: NSMenuItem = appearanceMenuItem(at: 0)
    
    /// The "Dark" appearance menu item.
    ///
    /// View > Appearance > Dark (`⌘4`)
    static unowned let darkModeMenu: NSMenuItem = appearanceMenuItem(at: 1)
    
    /// Updates the status in the display mode menu.
    /// - Parameter selectedDisplayMode: The display mode index.
    ///
    /// Display mode index 0 = Grid View
    ///
    /// Display mode index 1 = List View
    static func updateMenu(_ selectedDisplayMode: Int) {
        if selectedDisplayMode == 0 {
            gridViewMenu.state = .on
            listViewMenu.state = .off
        } else {
            gridViewMenu.state = .off
            listViewMenu.state = .on
        }
    }
    
    /// Updates the status in the appearance menu.
    /// - Parameter darkMode: A Boolean value indicating whether the current appearance is in dark mode or not.
    static func updateMenu(_ darkMode: Bool) {
        if darkMode {
            darkModeMenu.state = .on
            lightModeMenu.state = .off
        } else {
            darkModeMenu.state = .off
            lightModeMenu.state = .on
        }
    }
    
    /// Returns the NSMenuItem at the given index under the 'View' menu.
    /// - Parameter index: The index of the NSMenuItem under the 'View' menu.
    /// - Returns: A NSMenuItem object.
    static func viewMenuItem(at index: Int) -> NSMenuItem {
        // Index 3 = "View" menu
        guard let mainMenu = NSApp.mainMenu,
              let viewItem = mainMenu.item(at: 3),
              let viewMenu = viewItem.submenu,
              let item = viewMenu.item(at: index) else { return NSMenuItem() }
        return item
    }
    
    /// Returns the NSMenuItem at the given index under the 'View > Appearance' menu.
    /// - Parameter index: The index of the NSMenuItem under the 'Appearance' menu.
    /// - Returns: A NSMenuItem object.
    static func appearanceMenuItem(at index: Int) -> NSMenuItem {
        // Index 12 = "Appearance" menu under the 'View' menu
        guard let appearanceMenu = viewMenuItem(at: 12).submenu,
              let item = appearanceMenu.item(at: index) else { return NSMenuItem() }
        return item
    }
    
    
    // MARK: - Toggle Appearance
    
    /// Toggles between Dark mode and Light mode from the appearance button in the window's toolbar.
    /// - Parameter sender: NSToolbar appearance button.
    @objc func toggleAppearance(sender: NSButton) {
        setAppearance(toDarkMode: window?.appearance?.name != .darkAqua)
    }
    
    /// Toggles between Dark mode and Light mode from the `Appearance` menu.
    /// - Parameter sender: NSMenuItem appearance item.
    @IBAction func toggleAppearanceMenu(_ sender: NSMenuItem) {
        setAppearance(toDarkMode: sender.tag == 1)
    }
    
    /// Sets the window appearance and updates NSMenu status accordingly.
    /// - Parameter toDarkMode: A Boolean value indicating whether to set the new appearance as the dark system appearance or not.
    func setAppearance(toDarkMode: Bool) {
        window?.appearance = NSAppearance(named: toDarkMode ? .darkAqua : .aqua)
        Self.updateMenu(toDarkMode)
    }
    
    
    // MARK: - Toggle Display Mode
    
    /// Toggles between grid view and list view from the display mode segmented control in the window's toolbar.
    /// - Parameter sender: The display mode NSSegmentedControl.
    @objc func toggleDisplayMode(_ sender: NSSegmentedControl) {
        setDisplayMode(displayMode: sender.selectedSegment)
    }
    
    /// Toggles between grid view and list view from the `View` menu.
    /// - Parameter sender: NSMenuItem view item.
    @IBAction func toggleDisplayModeMenu(_ sender: NSMenuItem) {
        let selectedDisplayMode = sender.tag
        displayModeControl.setSelected(true, forSegment: selectedDisplayMode)
        setDisplayMode(displayMode: selectedDisplayMode)
    }
    
    /// Sets the display mode and updates NSMenu status accordingly.
    /// - Parameter displayMode: The display mode index.
    func setDisplayMode(displayMode: Int) {
        tabVC.selectedTabViewItemIndex = displayMode
        Self.updateMenu(displayMode)
    }
    
    
    // MARK: - Toggle Find
    
    /// Makes the search field as the first responder for the window when the user has selected the "Find..." menu or pressed `⌘F`.
    /// - Parameter sender: The "Find..." NSMenuItem item.
    @IBAction func focusSearchField(_ sender: NSMenuItem) {
        window?.makeFirstResponder(searchField)
    }
    
}


// MARK: - QuickLook Preview Panel

extension WindowController {
    
    override func acceptsPreviewPanelControl(_ panel: QLPreviewPanel!) -> Bool {
        // Accept control for the quick look preview panel.
        // The responder chain stops at window controller and does not pass through NSDocument.
        // WindowController is the only custom class that captures quick look preview requests from both grid view and list view (without creating another subclass of NSTabViewController or NSSplitViewController)
        return true
    }
    
    override func beginPreviewPanelControl(_ panel: QLPreviewPanel!) {
        guard let document = document as? Document else { return }
        document.preparePreviewItems()
        panel.delegate = document
        panel.dataSource = document
    }
    
    override func endPreviewPanelControl(_ panel: QLPreviewPanel!) {
        panel.delegate = nil
        panel.dataSource = nil
    }
    
}
