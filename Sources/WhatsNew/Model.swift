//
//  Model.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI

public struct WhatsNewItem: Identifiable, Codable {

    public let id = UUID()

    public var title: String
    public var body: String
    public var colorName: String
    public var iconName: String

    // Be specific so that the `let id` doesn't complain
    enum CodingKeys: String, CodingKey {
        case title, body, colorName, iconName
    }

    // MARK: - Computed properties
    public var color: Color {
        return .blue
    }

    public var icon: Image {
        Image(systemName: "clipboard")
    }

    // MARK: - Initializer
    public init(title: String, body: String, colorName: String, iconName: String) {
        self.title = title
        self.body = body
        self.colorName = colorName
        self.iconName = iconName
    }
}
