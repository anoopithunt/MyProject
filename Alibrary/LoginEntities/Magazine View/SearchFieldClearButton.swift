//
//  SearchFieldClearButton.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 03/04/23.
//

import Foundation
import SwiftUI


struct SearchFieldClearButton: ViewModifier {
    @Binding var fieldText: String

    func body(content: Content) -> some View {
        content
            .overlay{
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = ""
                        } label: {
                            Image(systemName: "multiply")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding(.trailing, 4)
                        }
                        .foregroundColor(.white)
                        .padding(.trailing, 4)
                    }
                }
            }
    }
}


