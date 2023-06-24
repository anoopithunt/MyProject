//
//  AuthenticateView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 06/12/23.
//

import SwiftUI

struct AuthenticateView: View {
    var body: some View {
        VStack{
            NavigationLink{
                SigninEmailView()
            }  label: {
                Text("SignIn with Email Id..")
                    .foregroundColor(.white)
                    .font(.system(size: 32,weight: .medium))
                    .frame(height: 75)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(4)
            }
        }
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{
                AuthenticateView()
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
