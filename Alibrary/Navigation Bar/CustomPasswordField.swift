//
//  CustomPasswordField.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 27/08/22.
//

import SwiftUI

struct CustomPasswordField: View {
   @State var isTapped = true
 
    var image: String
    var title: String
    var animation: Namespace.ID
    @Binding var value: String
    var body: some View {
        VStack(spacing:12){
            HStack(alignment: .bottom){
                Image(systemName: "lock.fill")
                    .font(.system(size: 26))
                    .padding(.bottom,35)
                    .foregroundColor(.white)
                VStack(alignment: .leading, spacing: 12){

                if value != "" {
                     Text(title)
                         .font(.title2)
                         .foregroundColor(.white)
                         .matchedGeometryEffect(id: title, in: animation)
                 }

                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                   
                   if value == "" {
                       
                        Text(title)
                           .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading,5)
                            .padding(.bottom,12)
//                            .matchedGeometryEffect(id: title, in: animation)
                    }
                       
                    if isTapped{
                        SecureField("",text: $value)
                            .foregroundColor(.white)
                            .padding(.bottom,12)
                            .font(.system(size: 28))
                  
                    } else{
                        TextField("",text: $value)
                            .foregroundColor(.white)
                            .font(.system(size: 28))
                            .padding(.bottom)
                     
                    }

                    }
                .padding()
            
            }

              
            }
            .overlay(alignment: .trailing){
                Image(systemName: isTapped  ? "eye.slash" : "eye")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .padding()
                    .onTapGesture{
                        isTapped.toggle()


                    }
                
                
            }
            .underlineTextField()
            
        }
    
   
        .frame( height: 75)

        .padding(.vertical,10)
        .background(Color.black.opacity(value == "" ? 0.1 : 0.7))

        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)

        .padding(.top)
        .animation(.easeIn)

    }
}





struct TextExa: View{
    @State  var email: String = ""
    @State  var password: String = ""
    @Namespace var animation
    var body: some View{
        
        VStack{
            CustomPasswordField(image: "envolop", title: "Password", animation: animation, value: $email)
            PasswordFloatingField(placeHolder: "Password", leadingImage: "lock.fill", text: $password)
           
        
        }.background(Color.black)

    }
}


struct TextExa_Previews: PreviewProvider {
    static var previews: some View {
        TextExa()
    }
}


struct PasswordFloatingField: View{
    
//    @State var isTapped = true
//
//    let textFieldHeight: CGFloat = 50
//    private var placeHolderText: String = ""
//    @State var leadingImage: String
//
//    @Binding var text: String
//    @State private var isEditing = false
//    public init(placeHolder: String, leadingImage: String,
//                text: Binding<String>) {
//        self._text = text
//        self.placeHolderText = placeHolder
//        self.leadingImage = leadingImage
//
//    }
//    var shouldPlaceHolderMove: Bool {
//        isEditing || (text.count != 0)
//    }
//
//
//    var body: some View {
//        ZStack(alignment: .leading) {
//
//
//
//
//
//
//
//                ZStack {
//                    if !isEditing{
//                        TextField("", text: $text,onEditingChanged: {(edit) in
//                            isEditing = edit
//
//                        })
//                        .padding(.leading,40)
//                        .padding(.trailing,50)
//                        .foregroundColor(Color.white)
//                        .accentColor(Color.teal)
//                        .font(.system(size: 22))
//                        .animation(.linear, value:  true)
//                    }
//                    else{
//
//
//                        if isTapped{
//                            SecureField("",text: $text)
//                                .padding(.leading,40)
//                                .padding(.trailing,50)
//                                .foregroundColor(Color.white)
//                                .accentColor(Color.teal)
//                                .font(.system(size: 22))
//                                .animation(.linear, value:  true)
//
//                        } else{
//                            TextField("", text: $text, onEditingChanged: { (edit) in
//                                isEditing = edit
//                            })
//                            .padding(.leading,40)
//                            .padding(.trailing,50)
//                            .foregroundColor(Color.white)
//                            .accentColor(Color.teal)
//                            .font(.system(size: 22))
//                            .animation(.linear, value:  true)
//
//                        }
//                    }
//                }.overlay(alignment: .trailing){
//                    Image(systemName: isTapped ? "eye.slash.fill": "eye.fill").font(.system(size: 28))
//                        .foregroundColor(.white).padding(4).onTapGesture{
//                            isTapped.toggle()
//
//                        }
//                }
//
//            ///Floating Placeholder
//            Text(placeHolderText)
//                .foregroundColor(.white)
//                .foregroundColor(shouldPlaceHolderMove ? Color.white: Color.gray)
//            .padding(shouldPlaceHolderMove ?
//                     EdgeInsets(top: 2, leading:40, bottom: textFieldHeight, trailing: 0) :
//                     EdgeInsets(top: 0, leading:50, bottom: 0, trailing: 0))
//            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
//
//            .animation(.easeInOut, value: 91)
//            .overlay(alignment: .leading){
//                Image(systemName: leadingImage)
//                    .foregroundColor(Color.gray)
//                    .font(.system(size: 28)).padding(4)
//            }
//
//        }
//        .underlineTextField()
//        .foregroundColor(shouldPlaceHolderMove ? Color.teal: Color.white)
//        .frame( height: 90)
//
//    }
    
    
    
    @State var isTapped = true

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
            ZStack {
                
                if isTapped{
//                    SecureField("",text: $text)
                    ZStack {
                         SecureField("", text: $text)
                              .font(.system(size: 22))
                                    
                         TextField("", text: $text, onEditingChanged: { (edit) in
                             isEditing = edit
                         })
                           .foregroundColor(.clear)
                           .disableAutocorrection(false)
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
//                .foregroundColor(shouldPlaceHolderMove ? Color.white: Color.gray)
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



