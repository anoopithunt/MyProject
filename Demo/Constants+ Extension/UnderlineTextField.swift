//
//  UnderlineTextField.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 03/12/22.
//

import Foundation
import SwiftUI
extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical,10)
            .overlay(Rectangle().frame(height: 2).padding(.top,50))
//            .foregroundColor(.black)
            .padding(15)
    }
}



import SwiftUI

extension Image {
    
    func profileImageMod() -> some View {
        self
            .resizable()
            .frame(width: 120, height: 120)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
    
}
