//
//  CustomFloatingTextField.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 03/12/22.
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
            .foregroundColor(Color.white)
            .accentColor(Color.orange)
            .font(.system(size: 22))
            .animation(.linear, value:  true)
//            .overlay(alignment: .trailing){
//                Image(systemName: "eye")
//                    .foregroundColor(.black)
//            }
            ///Floating Placeholder
            Text(placeHolderText)
            
                .foregroundColor(.white)
            .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 2, leading:40, bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:55, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
            
            .animation(.easeInOut, value: 91)
            .overlay(alignment: .leading){
                Image(systemName: leadingImage)
                    .foregroundColor(Color.white)
                    .font(.system(size: 24))
            }
                                
        }
        .underlineTextField()
        .foregroundColor(shouldPlaceHolderMove ? Color.teal: Color.gray)
        .frame( height: 90)

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
    @State private var text = ""
    @State private var originalPassword = ""
       @State private var maskedPassword = ""
       @State private var isMasked = false
    var body: some View{
        
        
        ZStack {
            Color.green.opacity(0.4)
            VStack{
//               CustomFloatingTextField(placeHolder: "Hello FloatingTF", leadingImage: "person.fill", text: $text)
                CustomTextField(placeHolder: "Password", text: $text)
                CustomTextField(placeHolder: "Password", text: $originalPassword)
               
            }
        }
    }
}

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


struct PasswordField: View{
    
    @State var isTapped = true

    let textFieldHeight: CGFloat = 50
    private var placeHolderText: String = ""
    @State var leadingImage: String = "lock.fill"
   
    @Binding var text: String
    @State private var isEditing = false
    public init(placeHolder: String, 
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
            ZStack {
                
                if !isTapped{
//                    SecureField("",text: $text)
                    ZStack {
                         SecureField("Password", text: $text)
                            .font(.system(size: 22)).padding(.leading,6)
                                    
                         TextField("", text: $text, onEditingChanged: { (edit) in
                             isEditing = edit
                         })
                           .foregroundColor(.clear)
                           .disableAutocorrection(true)
                           .font(.system(size: 22))
                                
                    }
                    
                        .padding(.leading,40)
                        .padding(.trailing,50)
                        .foregroundColor(Color.white)
                        .accentColor(Color.teal)
                        .font(.system(size: 22))
                        .animation(.linear, value:  true)
                    
                } else{
                    TextField("", text: $text, onEditingChanged: { (edit) in
                        isEditing = edit
                    })
                    .padding(.leading,40)
                    .padding(.trailing,50)
                    .foregroundColor(Color.white)
                    .accentColor(Color.teal)
                    .font(.system(size: 22))
                    .animation(.linear, value:  true)
                    
                }
                
            }.overlay(alignment: .trailing){
                    Image(systemName: isTapped ? "eye.slash.fill": "eye.fill").font(.system(size: 28))
                        .foregroundColor(.gray).padding(4).onTapGesture{
                            isTapped.toggle()
                           
                        }
                }
           
            ///Floating Placeholder
            Text(placeHolderText)
                .foregroundColor(.white)
                .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 2, leading:40, bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:50, bottom: 0, trailing: 0))
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




