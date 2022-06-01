//
//  ContentView.swift
//  WhatsNewSampleApp
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI
import WhatsNew

struct ContentView: View {
    func foo() {
        var item = WhatsNewItem(title: "fooo", body: "bar", colorName: "hi", iconName: "")
        item.title = "foo"
        item.body = "hi"
    }

    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
