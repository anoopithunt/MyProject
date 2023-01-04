//
//  CustomTextField.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
     var placeHolderText: String = ""
    @Binding var text: String
    
    @State private var isEditing = false
    public init(placeHolder: String, text: Binding<String>
                ) {
        self._text = text
        self.placeHolderText = placeHolder


    }
    var body: some View {

            TextField(placeHolderText, text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            })
            .foregroundColor(Color.black)
            .font(.system(size: 22))
     
        .underlineTextField().padding(.horizontal)
        .foregroundColor(isEditing ? Color.black: Color.gray)
        
    }
}
