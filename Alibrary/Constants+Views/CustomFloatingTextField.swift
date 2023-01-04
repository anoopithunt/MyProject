//
//  CustomFloatingTextField.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 09/11/22.
//

import Foundation
import SwiftUI



struct CustomFloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @State var rightImage: String
    
    @Binding var text: String
    @State private var isEditing = false
    public init(placeHolder: String, rightImage: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
        self.rightImage = rightImage
 
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
                     EdgeInsets(top: 2, leading:43, bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:43, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
            
            .animation(.easeInOut, value: 91)
            .overlay(alignment: .leading){
                Image(systemName: rightImage)
                    .foregroundColor(.gray)
                    .font(.system(size: 24))
            }
                                
        }
        .underlineTextField()
        .foregroundColor(shouldPlaceHolderMove ? Color.teal: Color.gray)
        .frame( height: 50)

    }
}


struct FloatingTextField: View {
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
            .padding(.leading,50)
            .padding(.trailing,40)
            .foregroundColor(Color.white)
            .accentColor(Color.teal)
            .font(.system(size: 22))
            .animation(.linear, value:  true)
            .overlay(alignment: .trailing){
                Image(systemName: "qrcode").font(.system(size: 28))
                    .foregroundColor(.white).padding(4)
            }
            ///Floating Placeholder
            Text(placeHolderText)
                .foregroundColor(.white)
//                .foregroundColor(shouldPlaceHolderMove ? Color.white: Color.gray)
            .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 2, leading:50, bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:60, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
            
            .animation(.easeInOut, value: 91)
            .overlay(alignment: .leading){
                Image(systemName: leadingImage)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 28)).padding(4)
            }
                                
        }
        .underlineTextField()
        .foregroundColor(shouldPlaceHolderMove ? Color.teal: Color.white)
        .frame( height: 90)

    }
}


struct CustomFloatingTextField_Previews: PreviewProvider {

    static var previews: some View {
        Ex()
    }
}



struct Ex: View{
    @State var text: String = ""
    var body: some View{
        ZStack {
            Color.black
            VStack{
                FloatingTextField(placeHolder: "Demo PlaceHolder", leadingImage: "person.crop.rectangle.fill", text: $text)
    //            CustomFloatingTextField(placeHolder: "Demo PlaceHolder", rightImage: "lock", text: $text)
            }.padding()
        }
        
    }
}
