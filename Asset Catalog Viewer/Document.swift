//
//  Document.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import AppKit
import Quartz

/// A document that represent the asset catalog data.
final class Document: NSDocument {
    
    /// The Asset Catalog.
    private var catalog: AssetCatalog!
    
    /// Visible renditions shown in the grid view and list view.
    private var visibleRenditions: ContiguousArray<Rendition> {
        didSet {
            gridView.reloadData()
            listView.reloadData()
        }
    }
    
    /// The file promise queue for drag and drop operation.
    private let filePromiseQueue: OperationQueue
    
    /// The document window.
    private let window: NSWindow
    
    /// The sidebar view.
    private let outlineView: NSOutlineView
    
    /// The grid vIew.
    private let gridView: CollectionView
    
    /// The list view.
    private let listView: TableView
    
    /// QuickLook preview items.
    ///
    /// The URLs of the selected renditions which are exported to the temporary directory.
    private var previewItems: ContiguousArray<URL>
    
    
    override init() {
        self.visibleRenditions = .init()
        self.filePromiseQueue = OperationQueue()
        filePromiseQueue.qualityOfService = .userInitiated
        self.window = NSWindow(contentViewController: NSSplitViewController())
        self.outlineView = NSOutlineView()
        self.gridView = CollectionView()
        self.listView = TableView()
        self.previewItems = .init()
        super.init()
        guard #available(OSX 11.0, *) else { return }
        window.subtitle = "Loading..."
    }
    
    override func makeWindowControllers() {
        
        guard let splitVC = window.contentViewController as? NSSplitViewController else { return }
        splitVC.splitView.wantsLayer = true
        
        // Configures window.
        window.styleMask.insert(.fullSizeContentView)
        window.setContentSize(CGSize(width: 1024, height: 600))
        window.appearance = NSApp.effectiveAppearance
        window.center()
        
        // Configures outline view.
        outlineView.selectionHighlightStyle = .sourceList
        outlineView.wantsLayer = true
        outlineView.headerView = nil
        outlineView.floatsGroupRows = false
        outlineView.addTableColumn(NSTableColumn())
        outlineView.delegate = self
        let outlineScrollView = NSScrollView()
        outlineScrollView.hasVerticalScroller = true
        outlineScrollView.autoresizingMask = .width
        outlineScrollView.documentView = outlineView
        let outlineVC = NSViewController()
        outlineVC.view = outlineScrollView
        splitVC.addSplitViewItem(NSSplitViewItem(sidebarWithViewController: outlineVC))
        
        // Configures collection view.
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 100, height: 145)
        flowLayout.minimumInteritemSpacing = 30
        flowLayout.minimumLineSpacing = 30
        flowLayout.sectionInset = NSEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        gridView.wantsLayer = true
        gridView.collectionViewLayout = flowLayout
        gridView.register(GridViewItem.self, forItemWithIdentifier: GridViewItem.reuseIdentifier)
        gridView.isSelectable = true
        gridView.allowsMultipleSelection = true
        gridView.setDraggingSourceOperationMask(.copy, forLocal: false)
        gridView.delegate = self
        let gridScrollView = NSScrollView()
        gridScrollView.documentView = gridView
        let gridVC = NSViewController()
        gridVC.view = gridScrollView
        
        // Configures list view.
        listView.wantsLayer = true
        listView.usesAlternatingRowBackgroundColors = true
        listView.intercellSpacing = CGSize(width: 17, height: 2)
        listView.allowsMultipleSelection = true
        listView.setDraggingSourceOperationMask(.copy, forLocal: false)
        listView.delegate = self
        let listScrollView = NSScrollView()
        listScrollView.hasVerticalScroller = true
        listScrollView.hasHorizontalScroller = true
        listScrollView.documentView = listView
        let listVC = NSViewController()
        listVC.view = listScrollView
        
        // Configures loading progress indicator.
        let progressIndicator = NSProgressIndicator()
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.style = .spinning
        progressIndicator.startAnimation(nil)
        let loadingVC = NSViewController()
        let loadingView = NSView()
        loadingVC.view = loadingView
        loadingVC.view.addSubview(progressIndicator)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: progressIndicator.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: progressIndicator.centerYAnchor)
        ])
        
        // Configures tab view controller.
        let tabVC = NSTabViewController()
        tabVC.tabStyle = .unspecified
        tabVC.addChild(loadingVC)
        tabVC.addChild(gridVC)
        tabVC.addChild(listVC)
        splitVC.addSplitViewItem(NSSplitViewItem(viewController: tabVC))
        splitVC.splitView.setPosition(200, ofDividerAt: 0)
        
        // Creates and add window controller to the document.
        addWindowController(WindowController(window: window, tabVC: tabVC))
    }
    
    override func read(from url: URL, ofType typeName: String) throws {
        // Locates the asset catalog URL if user opens an application bundle.
        let fileURL: URL
        if let bundle = Bundle(url: url), let catalogURL = bundle.url(forResource: "Assets", withExtension: "car") {
            displayName += " - Assets.car"
            fileURL = catalogURL
        } else {
            fileURL = url
        }
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            do {
                // Parses the asset catalog file on background queue.
                self.catalog = try AssetCatalog(url: fileURL)
                let attributeIDs = catalog.attributeIDs
                // Updates UI on the main queue.
                DispatchQueue.main.async {
                    // Adds the table columns based on the available rendition attributes in specific order.
                    listView.addRenditionColumn()
                    listView.addTableColumn(.AssetName, width: 125)
                    listView.addTableColumn(.RenditionName, width: 175)
                    listView.addTableColumn(.Kind)
                    if attributeIDs.contains(.Scale) {
                        listView.addTableColumn(.Scale)
                    }
                    if attributeIDs.contains(.Idiom) {
                        listView.addTableColumn(.Device)
                    }
                    if !catalog.appearances.isEmpty {
                        listView.addTableColumn(.Appearance)
                    }
                    if !catalog.localizations.isEmpty {
                        listView.addTableColumn(.Localization, width: 100)
                    }
                    if attributeIDs.contains(.Gamut) {
                        listView.addTableColumn(.Gamut)
                    }
                    if attributeIDs.contains(.GlyphWeight) {
                        listView.addTableColumn(.GlyphWeight)
                    }
                    if attributeIDs.contains(.GlyphSize) {
                        listView.addTableColumn(.GlyphSize)
                    }
                    if attributeIDs.contains(.Graphics) {
                        listView.addTableColumn(.Graphics, width: 125)
                    }
                    if attributeIDs.contains(.Memory) {
                        listView.addTableColumn(.Memory, width: 100)
                    }
                    // Configures the data source for outline view, grid view and list view.
                    outlineView.dataSource = self
                    gridView.dataSource = self
                    listView.dataSource = self
                    // Expands the node items and select the first node (i.e. all renditions).
                    outlineView.expandItem(nil, expandChildren: true)
                    outlineView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
                    // Removes the loading progress indicator (at tab view index 0) upon completion.
                    if let windowController = window.windowController as? WindowController {
                        windowController.tabVC.removeChild(at: 0)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    // Presents error(s) and close the document window.
                    presentError(error)
                    close()
                }
            }
        }
    }
    
    // MARK: - Validate Menu States
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        // Note: Tag 1001 = "Export Selected Assets…" NSMenuItem
        guard menuItem.tag == 1001 else { return true }
        return !gridView.selectionIndexes.isEmpty
    }
    
    // MARK: - Search
    
    /// Performs rendition search.
    /// - Parameter sender: The search field that calls for the search function.
    @objc func runSearch(_ sender: NSSearchField) {
        if sender.stringValue.isEmpty {
            outlineView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        } else {
            outlineView.deselectAll(nil)
            let searchString = sender.stringValue.lowercased()
            visibleRenditions = catalog.renditions.filter {
                $0.assetName.lowercased().contains(searchString)
            }
            setSubtitle(suffix: " found")
        }
    }
    
}


private extension Document {
    
    // MARK: - Export
    
    /// Exports all renditions.
    /// - Parameter sender: The "Export All Assets... " NSMenuItem object that calls for the exportAll IBAction.
    @IBAction func exportAll(_ sender: NSMenuItem) {
        export()
    }
    
    /// Exports selected renditions.
    /// - Parameter sender: The "Export Selected Assets... " NSMenuItem object that calls for the exportSelected IBAction.
    @IBAction func exportSelected(_ sender: NSMenuItem) {
        export(selectedAssets: true)
    }
    
    /// Exports renditions from an asset catalog.
    /// - Parameter selectedAssets: A Boolean value indicating whether to export selected renditions or not.
    func export(selectedAssets: Bool = false) {
        let dialog = NSOpenPanel();
        dialog.prompt = "Export"
        dialog.title = "Choose destination folder for exported renditions"
        dialog.canChooseFiles = false
        dialog.canChooseDirectories = true
        dialog.canCreateDirectories = true
        dialog.beginSheetModal(for: window) { modalResponse in
            guard modalResponse == .OK, let folderURL = dialog.url else { return }
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                if selectedAssets {
                    // Export selected renditions
                    gridView.selectionIndexes.forEach {
                        let rendition = visibleRenditions[$0]
                        try? rendition.write(to: folderURL.appendingPathComponent(rendition.fileName))
                    }
                } else {
                    // Export all renditions
                    catalog.renditions.forEach {
                        try? $0.write(to: folderURL.appendingPathComponent($0.fileName))
                    }
                }
            }
        }
    }
    
    // MARK: - Window Subtitle
    
    /// Sets the subtitle of the window to the number of renditions.
    ///
    /// @available(OSX 11.0, *)
    ///
    /// - Parameter suffix: The suffix to be added end of the subtitle.
    func setSubtitle(suffix: String? = nil) {
        guard #available(OSX 11.0, *) else { return }
        // The localized plural variant of the rendition count.
        var renditionCount = String.localizedStringWithFormat(NSLocalizedString("Rendition Count", comment: String()), visibleRenditions.endIndex)
        if let suffix = suffix {
            renditionCount += suffix
        }
        window.subtitle = renditionCount
    }
    
}


// MARK: - File Promise Provider Delegate

extension Document: NSFilePromiseProviderDelegate {
    
    func filePromiseProvider(_ filePromiseProvider: NSFilePromiseProvider, fileNameForType fileType: String) -> String {
        guard let rendition = filePromiseProvider.userInfo as? Rendition else { return "Rendition" }
        return rendition.fileName
    }
    
    func filePromiseProvider(_ filePromiseProvider: NSFilePromiseProvider, writePromiseTo url: URL, completionHandler: @escaping (Error?) -> Void) {
        do {
            if let rendition = filePromiseProvider.userInfo as? Rendition {
                try rendition.write(to: url)
                completionHandler(nil)
            }
        } catch let error {
            OperationQueue.main.addOperation {
                self.presentError(error, modalFor: self.window, delegate: nil, didPresent: nil, contextInfo: nil)
            }
            completionHandler(error)
        }
    }
    
    func operationQueue(for filePromiseProvider: NSFilePromiseProvider) -> OperationQueue {
        return filePromiseQueue
    }
    
}


// MARK: - Outline View Delegate

extension Document: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        guard let item = item as? Item else { return false }
        return item.isGroup
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let item = item as? Item else { return nil }
        if item.isGroup {
            let identifier = NSUserInterfaceItemIdentifier("GroupLabel")
            if let textField = outlineView.makeView(withIdentifier: identifier, owner: self) as? NSTextField {
                textField.stringValue = item.name
                return textField
            } else {
                let textField = NSTextField(labelWithString: item.name)
                textField.cell?.lineBreakMode = .byTruncatingTail
                textField.identifier = identifier
                return textField
            }
        } else {
            let identifier = NSUserInterfaceItemIdentifier("AssetLabel")
            if let contentView = outlineView.makeView(withIdentifier: identifier, owner: self) as? TextCell {
                contentView.textField.stringValue = item.name
                return contentView
            } else {
                let contentView = TextCell(text: item.name)
                contentView.identifier = identifier
                return contentView
            }
        }
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        // Updates visible renditions based on the selection on the sidebar and update window subtitle.
        guard let outlineView = notification.object as? NSOutlineView,
              let item = outlineView.item(atRow: outlineView.selectedRow) as? Item else { return }
        listView.sortDescriptors = .init()
        if item.kind == .All {
            visibleRenditions = catalog.renditions
            setSubtitle()
        } else {
            visibleRenditions = catalog.renditions.filter {
                if item.isGroup {
                    return $0.kind == item.kind
                } else {
                    return $0.kind == item.kind && $0.assetName == item.name
                }
            }
            setSubtitle(suffix: " shown")
        }
    }
    
}


// MARK: - Outline View Data Source

extension Document: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        guard let item = item as? Item else { return catalog.assets.endIndex }
        return item.children.endIndex
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        guard let item = item as? Item else { return catalog.assets[index] }
        return item.children[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        guard let item = item as? Item else { return true }
        return item.isLeaf
    }
    
}


// MARK: - Collection View Delegate

extension Document: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        let rendition = visibleRenditions[indexPath.item]
        guard let fileType = rendition.fileType else { return nil }
        let provider = NSFilePromiseProvider(fileType: fileType, delegate: self)
        provider.userInfo = rendition
        return provider
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItemsAt indexPaths: Set<IndexPath>) {
        // Unhides CollectionViewItem during dragging session.
        indexPaths.forEach {
            collectionView.item(at: $0)?.view.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        // Synchronizes selection between List View and Grid View.
        guard gridView.canBecomeKeyView else { return }
        listView.selectRowIndexes(gridView.selectionIndexes, byExtendingSelection: false)
        reloadPreviewItems()
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        // Synchronizes selection between List View and Grid View.
        guard gridView.canBecomeKeyView else { return }
        listView.selectRowIndexes(gridView.selectionIndexes, byExtendingSelection: false)
        reloadPreviewItems()
    }
    
}


// MARK: - Collection View Data Source

extension Document: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleRenditions.endIndex
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let viewItem = collectionView.makeItem(withIdentifier: GridViewItem.reuseIdentifier, for: indexPath) as? GridViewItem else { fatalError() }
        let rendition = visibleRenditions[indexPath.item]
        viewItem.renditionView.image = rendition.previewImage
        viewItem.primaryLabel.stringValue = rendition.assetName
        viewItem.secondaryLabel.stringValue = rendition.renditionName
        viewItem.view.toolTip = rendition.assetName + "\n" + rendition.fileName
        return viewItem
    }
    
}


// MARK: - Table View Delegate

extension Document: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let rendition = visibleRenditions[row]
        let text: String
        guard let columnID = TableColumn(rawValue: tableColumn!.title) else { return nil }
        switch columnID {
        case .Rendition:
            guard let previewImage = rendition.previewImage else { return nil }
            let identifier = NSUserInterfaceItemIdentifier("ImageView")
            let imageView: NSImageView
            if let view = tableView.makeView(withIdentifier: identifier, owner: self) as? NSImageView {
                imageView = view
                imageView.image = previewImage
            } else {
                imageView = NSImageView(image: previewImage)
                imageView.identifier = identifier
            }
            return imageView
        case .AssetName:        text = rendition.assetName
        case .RenditionName:    text = rendition.renditionName
        case .Kind:             text = rendition.kind.string
        case .Scale:            text = rendition.key.scale.string
        case .Device:           text = rendition.key.idiom.string
        case .Appearance:       text = catalog.appearances[rendition.key.appearance] ?? String()
        case .Localization:     text = catalog.localizations[rendition.key.localization] ?? "-"
        case .Gamut:            text = rendition.key.displayGamut.string
        case .GlyphWeight:      text = rendition.key.glyphWeight.string
        case .GlyphSize:        text = rendition.key.glyphSize.string
        case .Graphics:         text = rendition.key.graphicsClass.string
        case .Memory:           text = rendition.key.memoryClass.string
        }
        let identifier = NSUserInterfaceItemIdentifier("TextField")
        let textCell: TextCell
        if let view = tableView.makeView(withIdentifier: identifier, owner: self) as? TextCell {
            textCell = view
            textCell.textField.stringValue = text
        } else {
            textCell = TextCell(text: text)
            textCell.identifier = identifier
        }
        return textCell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        // Synchronizes selection between Grid View and List View.
        guard listView.canBecomeKeyView else { return }
        gridView.selectionIndexes = listView.selectedRowIndexes
        reloadPreviewItems()
    }
    
}


// MARK: - Table View Data Source

extension Document: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return visibleRenditions.endIndex
    }
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let rendition = visibleRenditions[row]
        guard let fileType = rendition.fileType else { return nil }
        let provider = NSFilePromiseProvider(fileType: fileType, delegate: self)
        provider.userInfo = rendition
        return provider
    }
    
    func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        guard !tableView.sortDescriptors.isEmpty else { return }
        var renditions = visibleRenditions
        // Sorts the first 4 descriptors only to minimize calculation.
        for sortDescriptor in tableView.sortDescriptors.prefix(4).reversed() {
            guard let sortKey = sortDescriptor.key,
                  let column = TableColumn(rawValue: sortKey) else { continue }
            switch column {
            case .Rendition:
                continue
            case .AssetName:
                if sortDescriptor.ascending {
                    renditions.sort { $0.assetName.lowercased() < $1.assetName.lowercased() }
                } else {
                    renditions.sort { $0.assetName.lowercased() > $1.assetName.lowercased() }
                }
            case .RenditionName:
                if sortDescriptor.ascending {
                    renditions.sort { $0.renditionName.lowercased() < $1.renditionName.lowercased() }
                } else {
                    renditions.sort { $0.renditionName.lowercased() > $1.renditionName.lowercased() }
                }
            case .Kind:
                if sortDescriptor.ascending {
                    renditions.sort { $0.kind.string < $1.kind.string }
                } else {
                    renditions.sort { $0.kind.string > $1.kind.string }
                }
            case .Scale:
                if sortDescriptor.ascending {
                    renditions.sort { $0.key.scale < $1.key.scale }
                } else {
                    renditions.sort { $0.key.scale > $1.key.scale }
                }
            case .Device:
                if sortDescriptor.ascending {
                    renditions.sort { $0.key.idiom.string < $1.key.idiom.string }
                } else {
                    renditions.sort { $0.key.idiom.string > $1.key.idiom.string }
                }
            case .Appearance:
                if sortDescriptor.ascending {
                    renditions.sort { catalog.appearances[$0.key.appearance] ?? String() < catalog.appearances[$1.key.appearance] ?? String() }
                } else {
                    renditions.sort { catalog.appearances[$0.key.appearance] ?? String() > catalog.appearances[$1.key.appearance] ?? String() }
                }
            case .Localization:
                if sortDescriptor.ascending {
                    renditions.sort { catalog.localizations[$0.key.localization] ?? String() < catalog.localizations[$1.key.localization] ?? String() }
                } else {
                    renditions.sort { catalog.localizations[$0.key.localization] ?? String() > catalog.localizations[$1.key.localization] ?? String() }
                }
            case .Gamut:
                // Ascending: P3 < sRGB, i.e. rawValue in reverse order
                if sortDescriptor.ascending {
                    renditions.sort { $0.key.displayGamut > $1.key.displayGamut }
                } else {
                    renditions.sort { $0.key.displayGamut < $1.key.displayGamut }
                }
            case .GlyphWeight:
                if sortDescriptor.ascending {
                    renditions.sort { $0.key.glyphWeight < $1.key.glyphWeight }
                } else {
                    renditions.sort { $0.key.glyphWeight > $1.key.glyphWeight }
                }
            case .GlyphSize:
                if sortDescriptor.ascending {
                    renditions.sort { $0.key.glyphSize < $1.key.glyphSize }
                } else {
                    renditions.sort { $0.key.glyphSize > $1.key.glyphSize }
                }
            case .Graphics:
                if sortDescriptor.ascending {
                    renditions.sort { $0.key.graphicsClass < $1.key.graphicsClass }
                } else {
                    renditions.sort { $0.key.graphicsClass > $1.key.graphicsClass }
                }
            case .Memory:
                // The raw values of memory class (3GB and 4GB) are not in sequential order
                if sortDescriptor.ascending {
                    renditions.sort { $0.key.memoryClass.string < $1.key.memoryClass.string }
                } else {
                    renditions.sort { $0.key.memoryClass.string > $1.key.memoryClass.string }
                }
            }
        }
        visibleRenditions = renditions
    }
    
}


// MARK: - QuickLook Preview Panel Delegate & Data Source

extension Document: QLPreviewPanelDataSource, QLPreviewPanelDelegate {
    
    /// Prepares preview items for QuickLook.
    ///
    /// This method will export the selected renditions to the temporary directory and reset the URLs of the preview items.
    func preparePreviewItems() {
        previewItems = ContiguousArray<URL>()
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let selectedIndexes = listView.selectedRowIndexes
        previewItems.reserveCapacity(selectedIndexes.count)
        selectedIndexes.forEach {
            let rendition = visibleRenditions[$0]
            let fileURL = temporaryDirectoryURL.appendingPathComponent(rendition.fileName)
            previewItems.append(fileURL)
            try? rendition.write(to: fileURL)
        }
    }
    
    /// Asks the preview panel to reload its preview items.
    ///
    /// This method should be called when the selection has changed.
    private func reloadPreviewItems() {
        guard QLPreviewPanel.sharedPreviewPanelExists(),
              let panel = QLPreviewPanel.shared(),
              panel.isVisible else { return }
        preparePreviewItems()
        panel.reloadData()
    }
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return previewItems.endIndex
    }
    
    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        return previewItems[index] as QLPreviewItem
    }
    
    func previewPanel(_ panel: QLPreviewPanel!, handle event: NSEvent!) -> Bool {
        // Redirects all key down events to the collection view or table view.
        if event.type == .keyDown {
            if listView.canBecomeKeyView {
                listView.keyDown(with: event)
            } else {
                gridView.keyDown(with: event)
            }
            return true
        } else {
            return false
        }
    }
    
}
