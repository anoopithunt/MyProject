//
//  FirebaseLoginExample.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 04/08/22.
//

import SwiftUI
import Firebase
import SystemConfiguration

struct FirebaseLoginExample: View {
        @State var email = ""
        @State var password = ""

        var body: some View {
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button(action: {}) {
                    Text("Sign in")
                }
            }
            .padding()
        }

//        func login() {
////           Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//                if error != nil {
//                    print(error?.localizedDescription ?? "")
//                } else {
////                    print("success")
//                    EmptyView()
//                }
//            }
//}
}
struct FirebaseLoginExample_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseLoginExample()
    }
}
