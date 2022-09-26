//
//  ContentView.swift
//  WhatsNewExample
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI
import WhatsNew

let whatsNewItems: [WhatsNewItem] = [
    .init(id: "first", title: "Test", body: "Something long which can be written so that we make sure that the text spills over into the next line. Once t does then it gives us a good chance to look at layout issues.", colorName: "blue", iconName: "scribble.variable"),
    .init(id: "second", title: "Test", body: "Something", colorName: "yellow", iconName: "trash.fill"),
    .init(id: "third", title: "Test", body: "Something", colorName: "mint", iconName: "tray.fill"),
    .init(id: "fourth", title: "Test", body: "Something", colorName: "indigo", iconName: "moon.fill"),
]

struct ContentView: View {
    @State private var showWhatsNew = false
    @State private var showTip = false

    let whatsNew = WhatsNew(items: whatsNewItems, stateStore: WhatsNewUserDefaultsStateStore())
    let whatsNewAdhoc = WhatsNew(items: whatsNewItems, stateStore: WhatsNewMemoryStateStore())

    var body: some View {
        VStack(spacing: 16) {
            Button {
                showWhatsNew.toggle()
            } label: {
                Text("Show whats new!")
            }

            Button {
                clearLaunched()
            } label: {
                Text("Clear launched")
            }

            Button {
                clearSeenItems()
            } label: {
                Text("Clear seen items")
            }
        }
        .padding()
        .whatsNew(whatsNew: whatsNew) {
            Button {
                showTip.toggle()
            } label: {
                Label("Automatic", systemImage: "person.circle.fill")
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showTip) {
                Text("HI")
            }
        }
        .whatsNew(whatsNew: whatsNewAdhoc, shouldShow: $showWhatsNew) {
            Button {
                showTip.toggle()
            } label: {
                Label("Manual", systemImage: "person.circle.fill")
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showTip) {
                Text("HI")
            }
        }
    }

    func clearLaunched() {
        UserDefaults.standard.removeObject(forKey: "whats_new_launched")
    }

    func clearSeenItems() {
        UserDefaults.standard.removeObject(forKey: "whats_new_seen_items")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
