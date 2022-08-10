//
//  WhatsNewView.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI

struct WhatsNewView<Content>: View where Content: View {
    var whatsNew: WhatsNew
    var linkView: Content

    @Environment(\.dismiss) var dismiss

    @State private var buttonOffset: CGFloat = 500

    internal init(whatsNew: WhatsNew, @ViewBuilder linkView: () -> Content) {
        self.whatsNew = whatsNew
        self.linkView = linkView()
    }

    var body: some View {
        VStack {
            Text("Whats New…")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .padding()

            ScrollView {
                ForEach(Array(zip(whatsNew.items.indices, whatsNew.items)), id: \.1) { index, item in
                    WhatsNewItemView(item: item, index: index)
                        .padding(.bottom)
                }
            }

            VStack(spacing: 16) {
                linkView

                Button(role: .cancel) {
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("Continue")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                            .frame(minHeight: 44)
                        Spacer()
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .animation(.spring().delay(0.5 + 0.4 * Double(whatsNew.items.count)), value: buttonOffset)
            .offset(y: buttonOffset)
            .onAppear {
                buttonOffset = 0
            }
        }
        .padding()
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static let items: [WhatsNewItem] = [
        .init(
            id: "1",
            title: "Something awesome!",
            body: "This is something new which is awesome in the app",
            colorName: "blue",
            iconName: "scribble.variable"
        ),
    ]

    static var whatsNew: WhatsNew = {
        let whatsNew = WhatsNew(items: items, stateStore: WhatsNewMemoryStateStore())
        return whatsNew
    }()

    static var previews: some View {
        WhatsNewView(whatsNew: whatsNew) {
            Label("Hello", systemImage: "person.circle.fill")
        }
    }
}
