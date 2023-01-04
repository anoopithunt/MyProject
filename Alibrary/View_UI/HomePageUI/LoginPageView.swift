//
//  LoginPageView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/07/22.
//

import SwiftUI


struct secureTextField: View{
    @State var isSecuredField: Bool = true
    @Binding var text: String
    var body: some View{
        HStack {
            if isSecuredField{
                SecureField("Password",text: $text)
                    .foregroundColor(.black)
            } else{
                TextField("text",text: $text)
                    .foregroundColor(.black)
                    .padding()


            }
        }
        .font(.system(size: 24))
        .overlay(alignment: .trailing){
            Image(systemName: isSecuredField  ? "eye.slash" : "eye")
                .onTapGesture {
                    isSecuredField.toggle()


                }
        }
    }

}

struct LoginPageView: View {
    
    @State var isTapped = false
    @State private var showingModal = false
    @State var c_email = ""
    @State var isSecuredField: Bool = true

    @State var username = ""
    @State var password = ""
    @State var login = ""
    @State var flag = true
    @StateObject private var loginVM = GetAuthenticationViewModel()

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
                    .frame(width: UIScreen.main.bounds.width*0.6, height: UIScreen.main.bounds.height*0.15, alignment: .center)
                    .padding(.top)
//                Divider()
                    FloatingTextField(placeHolder: "UserName or Email id", leadingImage: "person.crop.rectangle.fill",text: $loginVM.username).padding()
                    
                    PasswordFloatingField(placeHolder: "Password", leadingImage: "lock.fill", text: $loginVM.password).padding()


                   
                
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
    
//                NavigationLink(destination: HomePage().navigationBarBackButtonHidden(false).navigationBarHidden(true)) {
                    
                    Button(action: {
                        loginVM.login()
                    }, label: {
                        ButtonView(btnName: "Login")
                    })
                    NavigationLink(destination: ContentView().navigationTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true), isActive: $loginVM.isAuthenticated) {
//                        EmptyView()
                                }
                
//                }
//                .navigationBarBackButtonHidden(true)
                
                    HStack(alignment: .center, spacing: 9){
                    Text("If you are Guest,please")
                        
                        .foregroundColor(.white)
//                        .padding()
                   
                   
                    NavigationLink(destination: RegistrationForm()){
                        
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
