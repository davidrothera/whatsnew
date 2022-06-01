//
//  WhatsNew.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import Foundation

public class WhatsNew {
    private(set) var items: [WhatsNewItem]

    public enum SourceType {
        case json
        case plist
    }

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
}
