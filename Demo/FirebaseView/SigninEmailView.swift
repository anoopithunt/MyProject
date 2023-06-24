//
//  SigninEmailView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 06/12/23.
//

import SwiftUI
final class SignInViewModel:ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    
    
}




struct SigninEmailView: View {
    @StateObject private var viewmodel = SignInViewModel()
    var body: some View {
        VStack{
            TextField("Email id", text: $viewmodel.email).padding()
                .background(Color.green.opacity(0.4))
                .cornerRadius(12).padding(5)
            SecureField("Password", text: $viewmodel.password)
                .padding()
                    .background(Color.green.opacity(0.4))
                    .cornerRadius(12).padding(5)
            Button(action: {
                
            }, label: {
                Text("Sign In ")
                    .foregroundColor(.white)
                    .font(.system(size: 32,weight: .medium))
                    .frame(height: 65)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(4)
            })
        }.navigationTitle("Sign In with Email")
    }
}

struct SigninEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SigninEmailView()
        }
    }
}
