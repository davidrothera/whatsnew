//
//  WhatsNew.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import Foundation

public class WhatsNew {
    // MARK: - Variables
    private(set) var items: [WhatsNewItem]

    // MARK: - Enums
    public enum SourceType {
        case json
        case plist
    }

    enum DefaultsKeys: String {
        case seenVersion = "whatsnew_seen_version"
    }

    // MARK: - Public Initializers
    public init(items: [WhatsNewItem]) {
        self.items = items
    }

    public init(fromPath path: String, withSourceType type: SourceType) throws {
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
    }

    // MARK: - Private methods
    /// Whether we should show the WhatsNew or not
    ///
    /// Based on whether the last recorded seen version matches the current version or not
    func shouldShow() -> Bool {
        guard let seenVersion = UserDefaults.standard.string(forKey: DefaultsKeys.seenVersion.rawValue),
              let currentVersion = Bundle.main.releaseVersionNumber
        else {
            return true
        }
        return seenVersion != currentVersion
    }

    /// Mark the current app version as "seen" so that we don't show the popup in future
    func markAsSeen() {
        guard let currentVersion = Bundle.main.releaseVersionNumber else {
            return
        }
        UserDefaults.standard.set(currentVersion, forKey: DefaultsKeys.seenVersion.rawValue)
    }
}
