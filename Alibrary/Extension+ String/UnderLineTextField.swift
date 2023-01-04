//
//  UnderLineTextField.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/12/22.
//

import SwiftUI



extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical,10)
            .overlay(Rectangle().frame(height: 2).padding(.top,50))
//            .foregroundColor(Color.black)
//            .padding(15)
    }
}
