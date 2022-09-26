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
    func firstAppLaunch() -> Bool
}

public class WhatsNewMemoryStateStore: WhatsNewStateStore {
    public weak var whatsNew: WhatsNew?

    public func hasBeenSeen(item: WhatsNewItem) -> Bool {
        false
    }

    public func markAllAsSeen() {
        return
    }

    public func firstAppLaunch() -> Bool {
        false
    }

    public init() {}
}

public class WhatsNewUserDefaultsStateStore: WhatsNewStateStore {
    var defaultsKey: String
    var userDefaults: UserDefaults
    private var appHasLaunched: Bool
    public weak var whatsNew: WhatsNew?

    public init(defaultsKey: String = "whats_new_seen_items", userDefaults: UserDefaults = .standard) {
        self.defaultsKey = defaultsKey
        self.userDefaults = userDefaults

        appHasLaunched = userDefaults.bool(forKey: "whats_new_launched")
        if !appHasLaunched {
            userDefaults.set(true, forKey: "whats_new_launched")
        }
    }

    public func hasBeenSeen(item: WhatsNewItem) -> Bool {
        guard
            let data = userDefaults.data(forKey: defaultsKey),
            let identifiers = try? JSONDecoder().decode([String].self, from: data)
        else { return false }

        return identifiers.contains(item.id)
    }

    public func markAllAsSeen() {
        guard let identifiers = whatsNew?.rawItems.map({ $0.id }),
              let data = try? JSONEncoder().encode(identifiers) else {
            return
        }
        userDefaults.set(data, forKey: defaultsKey)
    }

    public func firstAppLaunch() -> Bool {
        !appHasLaunched
    }
}
