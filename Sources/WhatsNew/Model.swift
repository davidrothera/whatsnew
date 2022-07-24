//
//  Model.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI

public struct WhatsNewItem: Identifiable, Codable, Hashable {

    /// String used for identifying a `WhatsNewItem`
    ///
    /// This should **not** be something which is generated at run-time as it will be
    /// used for marking an object as "seen"
    public let id: String

    public var title: String
    public var body: String
    public var shownOnVersion: String?
    public var colorName: String
    public var iconName: String

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
    public init(id: String, title: String, body: String, shownOnVersion: String? = nil, colorName: String, iconName: String) {
        self.id = id
        self.title = title
        self.body = body
        self.shownOnVersion = shownOnVersion
        self.colorName = colorName
        self.iconName = iconName
    }
}
