//
//  WhatsNewStateStore.swift
//  
//
//  Created by David Rothera on 24/07/2022.
//

import Foundation

public protocol WhatsNewStateStore {
    var whatsNew: WhatsNew? { get set }
    func hasBeenSeen(item: WhatsNewItem) -> Bool
    func markAllAsSeen()
}

public class WhatsNewMemoryStateStore: WhatsNewStateStore {
    public weak var whatsNew: WhatsNew?

    public func hasBeenSeen(item: WhatsNewItem) -> Bool {
        false
    }

    public func markAllAsSeen() {
        return
    }

    public init() {}
}

public class WhatsNewUserDefaultsStateStore: WhatsNewStateStore {
    var defaultsKey: String
    var userDefaults: UserDefaults
    public weak var whatsNew: WhatsNew?

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

    public func markAllAsSeen() {
        guard let identifiers = whatsNew?.items.map({ $0.id }),
              let data = try? JSONEncoder().encode(identifiers) else {
            return
        }
        userDefaults.set(data, forKey: defaultsKey)
    }
}
