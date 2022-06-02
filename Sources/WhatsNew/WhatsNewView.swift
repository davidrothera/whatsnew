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

    @State private var buttonOffset: CGFloat = 500

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
    static var previews: some View {
        WhatsNewView(whatsNew: .init(items: []))
    }
}
