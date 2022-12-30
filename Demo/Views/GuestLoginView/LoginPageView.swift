//
//  LoginPageView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 29/12/22.
//

import SwiftUI

struct LoginPageView: View {
    @Environment(\.dismiss) var dismiss
    @State var isTapped = false
    @State private var showingModal = false

    @State var isSecuredField: Bool = true
    @State var isAuthenticated: Bool = false
    @StateObject private var loginVM = GetAuthenticationViewModel()
    @StateObject private var accountListVM = AuthenticationPlanListService()

    @Namespace var animation
    var body: some View {
        NavigationView{
            ZStack(alignment: .center) {
                    Image("bg_black")
                    .resizable()

                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).ignoresSafeArea()

                VStack(alignment: .center) {
                Image("alib_black_logo")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width*0.6, height: UIScreen.main.bounds.height*0.16, alignment: .center)
                    .padding(.top)
//                Divider()
                    CustomFloatingTextField(placeHolder: "UserName or Email id", leadingImage: "person.crop.rectangle.fill",text: $loginVM.username).padding()
                    
                    PasswordField(placeHolder: "Password", text: $loginVM.password).padding()
             
                   
                
                HStack(alignment: .top, spacing: 10) {
                    
                    Image(systemName: isTapped ? "checkmark.square.fill": "square")
                        .font(.title).onTapGesture {
                            isTapped.toggle()
                        }
                        .foregroundColor(.white)
                        .animation(.easeInOut, value:  true)
                        
                        
                       
                    Text("Remember Me")
                        .foregroundColor(Color.white)
                        .padding(.leading, 5.0)
                    Spacer()

                    
                    ZStack {
                        VStack(spacing: 20) {
                                    Button( action: {
                                        self.showingModal = true}) {
                                        Text("Forgot Password ?")
                                            .foregroundColor(Color.white)
                                    }
                        }
                        
                    }
                    
                }
                
                .padding(.horizontal,5)
                .padding(.vertical,22)
    
//                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(false).navigationBarHidden(true)) {
// ButtonView(btnName: "Login")
//
//                }
                    
                    Button(action: {
                        loginVM.login()
                    }, label: {
                        ButtonView(btnName: "Login")
                    })
//                .navigationBarBackButtonHidden(true)
                    NavigationLink(destination: StacksView(), isActive: $loginVM.isAuthenticated){
                        EmptyView()
                    }.navigationTitle("").navigationBarBackButtonHidden(true).navigationBarHidden(true)
                    HStack(alignment: .center, spacing: 9){
                    Text("If you are Guest,please")
                        
                        .foregroundColor(.white)
//                        .padding()
                   
                   
                    NavigationLink(destination: EmptyView()){
                        
                        Text("Click here to Registration")
                            
                            .foregroundColor(.orange)
                     
                    }
                    .navigationBarHidden(true)
                 .padding(.horizontal,1)
                                   
                    }
                .frame(width: UIScreen.main.bounds.width, alignment: .center)
            
                .font(.custom("regular", size: 17))
                
                .padding(.top,35)
            }
                .frame(width: UIScreen.main.bounds.width-45, alignment: .center)
            .padding(.horizontal)

            
                }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .navigationViewStyle(StackNavigationViewStyle())
       .padding()
        
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoginPageView()
            Spacer()
        }
    }
}




struct FloatingTextFieldEx: View {
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





struct PasswordFloatingField: View{
    
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
                    if !isEditing{
                        TextField("", text: $text,onEditingChanged: {(edit) in
                            isEditing = edit
                            
                        })
                        .padding(.leading,40)
                        .padding(.trailing,50)
                        .foregroundColor(Color.white)
                        .accentColor(Color.teal)
                        .font(.system(size: 22))
                        .animation(.linear, value:  true)
                    }
                    else{
                        
                        
                        if isTapped{
                            SecureField("",text: $text)
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



struct ButtonView: View {
    
    let btnName: String
    
    var body: some View {
        
            Text(btnName)
            .font(.system(size: 18))
            .frame(width: UIScreen.main.bounds.width/1.2, height: 18, alignment: .center)
                .padding()
                .foregroundColor(.white)
                .background(Color("AccentColor"))
            .cornerRadius(25)

           }
}

