//
//  ContentView.swift
//  WhatsNewExample
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI
import WhatsNew

struct ContentView: View {
    func foo() {
        let whatsNew = WhatsNew(items: [])
    }

    var body: some View {
        Text("Hello, world!")
            .padding()
            .whatsNew(whatsNew: .init(items: [
                .init(title: "Test", body: "Something long which can be written so that we make sure that the text spills over into the next line. Once t does then it gives us a good chance to look at layout issues.", colorName: "blue", iconName: "scribble.variable"),
                .init(title: "Test", body: "Something", colorName: "yellow", iconName: "trash.fill"),
                .init(title: "Test", body: "Something", shownOnVersion: "1.0", colorName: "mint", iconName: "tray.fill"),
                .init(title: "Test", body: "Something", shownOnVersion: "123", colorName: "indigo", iconName: "moon.fill"),
            ], forceShow: true))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
