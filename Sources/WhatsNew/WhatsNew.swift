//
//  WhatsNew.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import Foundation

public class WhatsNew {
    // MARK: - Variables
    private(set) var items: [WhatsNewItem] = []
    var stateStore: WhatsNewStateStore

    // MARK: - Enums
    public enum SourceType {
        case json
        case plist
    }

    enum DefaultsKeys: String {
        case seenVersion = "whatsnew_seen_version"
    }

    // MARK: - Public Initializers
    public init(items: [WhatsNewItem], stateStore: WhatsNewStateStore) {
        self.stateStore = stateStore
        self.items = filterItems(items)
    }

    public init(fromPath path: String, withSourceType type: SourceType, stateStore: WhatsNewStateStore) throws {
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)

        switch type {
        case .json:
            let decoder = JSONDecoder()
            let items = try decoder.decode([WhatsNewItem].self, from: data)
            self.items = items
        case .plist:
            let decoder = PropertyListDecoder()
            let items = try decoder.decode([WhatsNewItem].self, from: data)
            self.items = items
        }

        self.stateStore = stateStore
    }

    // MARK: - Private methods
    /// Whether we should show the WhatsNew or not
    func shouldShow() -> Bool {
        if items.isEmpty {
            return false
        }
        return true
    }

    /// Mark the current items as "seen" so that they are not shown on future launches
    func markAsSeen() {
        stateStore.markAsSeen(items: items)
    }

    func filterItems(_ items: [WhatsNewItem]) -> [WhatsNewItem] {
        return items.filter { !stateStore.hasBeenSeen(item: $0) }
    }
}
