//
//  TextFieldClearButton.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 03/04/23.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var fieldText: String

    func body(content: Content) -> some View {
        content
            .overlay {
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = ""
                        } label: {
                            Image(systemName: "multiply").font(.title).padding(.trailing, 4)
                        }
                        .foregroundColor(.gray)
                        .padding(.trailing, 4)
                    }
                }
                else {
                    HStack {
                        Spacer()
                        Image("magnifying_glass_right").resizable().frame(width: 25, height: 25).shadow(color: .black, radius: 1).padding(.trailing)
                        
                    }
                }
            }
    }
}



extension View {
    func showClearButton(_ text: Binding<String>) -> some View {
        self.modifier(TextFieldClearButton(fieldText: text))
        
    }
    func showClearButtonOfSearchField(_ text: Binding<String>) -> some View {
        self.modifier(SearchFieldClearButton(fieldText: text))
    }
}
