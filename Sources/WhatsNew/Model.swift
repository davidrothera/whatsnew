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
        switch colorName {
        case "black":
            return .black
        case "blue":
            return .blue
        case "brown":
            return .brown
        case "cyan":
            return .cyan
        case "gray":
            return .gray
        case "green":
            return .green
        case "indigo":
            return .indigo
        case "mint":
            return .mint
        case "orange":
            return .orange
        case "pink":
            return .pink
        case "purple":
            return .purple
        case "red":
            return .red
        case "teal":
            return .teal
        case "white":
            return .white
        case "yellow":
            return .yellow
        default:
            return .blue
        }
    }

    public var icon: Image {
        Image(systemName: iconName)
    }

    // MARK: - Initializer
    public init(title: String, body: String, colorName: String, iconName: String) {
        self.title = title
        self.body = body
        self.colorName = colorName
        self.iconName = iconName
    }
}
