//
//  UserAuth.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 06/08/22.
//

import Combine

class UserAuth: ObservableObject{
    @Published var isLoggedIn: Bool = false
    func login(){
        self.isLoggedIn = true
    }
    
}
