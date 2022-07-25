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

public class WhatsNewMemoryStateStore: WhatsNewStateStore {
    public func hasBeenSeen(item: WhatsNewItem) -> Bool {
        false
    }

    public func markAsSeen(items: [WhatsNewItem]) {
        return
    }

    public init() {}
}

public class WhatsNewUserDefaultsStateStore: WhatsNewStateStore {
    var defaultsKey: String
    var userDefaults: UserDefaults

    public init(defaultsKey: String = "whats_new_seen_items", userDefaults: UserDefaults = .standard) {
        self.defaultsKey = defaultsKey
        self.userDefaults = userDefaults
    }

    public func hasBeenSeen(item: WhatsNewItem) -> Bool {
        guard
            let data = userDefaults.data(forKey: defaultsKey),
            let identifiers = try? JSONDecoder().decode([String].self, from: data)
        else { return false }

        return identifiers.contains(item.id)
    }

    public func markAsSeen(items: [WhatsNewItem]) {
        guard let data = try? JSONEncoder().encode(items) else {
            return
        }
        userDefaults.set(data, forKey: defaultsKey)
    }
}
