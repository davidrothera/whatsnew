//
//  WhatsNewStateStore.swift
//  
//
//  Created by David Rothera on 24/07/2022.
//

import Foundation

public protocol WhatsNewStateStore {
    func hasBeenSeen(item: WhatsNewItem) -> Bool

    func markAsSeen(items: [WhatsNewItem])
}

public class WhatsNewMemoryStore: WhatsNewStateStore {
    public func hasBeenSeen(item: WhatsNewItem) -> Bool {
        false
    }

    public func markAsSeen(items: [WhatsNewItem]) {
        return
    }

    public init() {}
}

public class WhatsNewUserDefaultsStore: WhatsNewStateStore {
    var defaultsKey: String
    var userDefaults: UserDefaults

    public init(defaultsKey: String = "whats_new_seen_items", userDefaults: UserDefaults = .standard) {
        self.defaultsKey = defaultsKey
        self.userDefaults = userDefaults
    }

    public func hasBeenSeen(item: WhatsNewItem) -> Bool {
        guard
            let identifiers = getIdentifiersFromStorage()
        else { return false }

        return identifiers.contains(item.id)
    }

    public func markAsSeen(items: [WhatsNewItem]) {
        var identifiers = getIdentifiersFromStorage() ?? []

        items.forEach { identifiers.append($0.id) }

        guard let data = try? JSONEncoder().encode(identifiers) else {
            return
        }
        userDefaults.set(data, forKey: defaultsKey)
    }

    private func getIdentifiersFromStorage() -> [String]? {
        guard
            let data = userDefaults.data(forKey: defaultsKey),
            let identifiers = try? JSONDecoder().decode([String].self, from: data)
        else { return nil }
        return identifiers
    }
}
