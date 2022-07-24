//
//  WhatsNewStore.swift
//  
//
//  Created by David Rothera on 24/07/2022.
//

import Foundation

protocol WhatsNewStore {
    func hasBeenSeen(item: WhatsNewItem) -> Bool

    func markAsSeen(items: [WhatsNewItem])
}

class WhatsNewMemoryStore: WhatsNewStore {
    func hasBeenSeen(item: WhatsNewItem) -> Bool {
        false
    }

    func markAsSeen(items: [WhatsNewItem]) {
        return
    }
}

class WhatsNewUserDefaultsStore: WhatsNewStore {
    var defaultsKey: String
    var userDefaults: UserDefaults

    init(defaultsKey: String = "whats_new_seen_items", userDefaults: UserDefaults = .standard) {
        self.defaultsKey = defaultsKey
        self.userDefaults = userDefaults
    }

    func hasBeenSeen(item: WhatsNewItem) -> Bool {
        guard
            let identifiers = getIdentifiersFromStorage()
        else { return false }

        return identifiers.contains(item.id)
    }

    func markAsSeen(items: [WhatsNewItem]) {
        guard
            var currentIdentifiers = getIdentifiersFromStorage()
        else { return }

        items.forEach { currentIdentifiers.append($0.id) }

        guard let data = try? JSONEncoder().encode(currentIdentifiers) else {
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
