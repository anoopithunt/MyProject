//
//  CustomFloatingTextField.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 03/12/22.
//

import Foundation
import SwiftUI
struct CustomFloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private var placeHolderText: String = ""
    @State var leadingImage: String
    
    @Binding var text: String
    @State private var isEditing = false
    public init(placeHolder: String, leadingImage: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
        self.leadingImage = leadingImage
 
    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    
    
    var body: some View {
        ZStack(alignment: .leading) {
          
            
            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            })
            .padding(.leading,40)
            .padding(.trailing,35)
            .foregroundColor(Color.gray)
            .accentColor(Color.orange)
            .font(.system(size: 22))
            .animation(.linear, value:  true)
//            .overlay(alignment: .trailing){
//                Image(systemName: "eye")
//                    .foregroundColor(.black)
//            }
            ///Floating Placeholder
            Text(placeHolderText)
            
                .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
            .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 2, leading:40, bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:55, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
            
            .animation(.easeInOut, value: 91)
            .overlay(alignment: .leading){
                Image(systemName: leadingImage)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 24))
            }
                                
        }
        .underlineTextField()
        .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
        .frame( height: 50)

    }
}

struct CustomFloatingTextField_Previews: PreviewProvider {

    static var previews: some View {
        Ex()
    }
}


struct FloatingTextField: View {
    let textFieldHeight: CGFloat = 50
     var placeHolderText: String = ""
    @Binding var text: String
    
    @State private var isEditing = false
    public init(placeHolder: String, text: Binding<String>
                ) {
        self._text = text
        self.placeHolderText = placeHolder


    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    
    
    var body: some View {
        ZStack(alignment: .leading) {
          
            
            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            })
            .padding(.horizontal,12)
//            .padding(.trailing,35)
            .foregroundColor(Color.gray)
            .accentColor(Color.orange)
            .font(.system(size: 22))
            .animation(.linear, value:  true)

            ///Floating Placeholder
            Text(placeHolderText)
            
                .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
            .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 2, leading:12, bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:22, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
            
            .animation(.easeInOut, value: 91)
           
                                
        }
        .underlineTextField().padding(.horizontal)
        .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
        .frame( height: 50)

    }
}

 
struct Ex: View{
    @State var text: String = ""
    var body: some View{
        CustomFloatingTextField(placeHolder: "Demo PlaceHolder", leadingImage: "lock", text: $text)
    }
}
