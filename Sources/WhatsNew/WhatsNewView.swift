//
//  WhatsNewView.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI

struct WhatsNewView: View {
    var whatsNew: WhatsNew

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Whats New…")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .padding()

            ScrollView {
                ForEach(whatsNew.items) { item in
                    WhatsNewItemView(item: item)
                }
            }

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
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}

struct WhatsNewItemView: View {
    var item: WhatsNewItem

    var body: some View {
        HStack {
            item.icon
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(item.color)
                .padding()
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .foregroundColor(.primary)
                    .font(.system(.headline, design: .rounded))
                Text(item.body)
                    .foregroundColor(.secondary)
                    .font(.system(.subheadline, design: .rounded))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct WhatsNewViewModifier: ViewModifier {
    let whatsNew: WhatsNew
    @State private var shouldShow: Bool

    init(whatsNew: WhatsNew) {
        self.whatsNew = whatsNew
        _shouldShow = .init(wrappedValue: whatsNew.shouldShow())
    }

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $shouldShow, onDismiss: didDismiss) {
                WhatsNewView(whatsNew: whatsNew)
            }
    }

    func didDismiss() {
        whatsNew.markAsSeen()
    }
}

public extension View {
    func whatsNew(whatsNew: WhatsNew) -> some View {
        modifier(WhatsNewViewModifier(whatsNew: whatsNew))
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView(whatsNew: .init(items: []))
    }
}
