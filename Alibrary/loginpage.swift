//
//  loginpage.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/06/22.
//

import SwiftUI

struct loginpage: View {
    
    @State var email = ""
    @State var password = ""
    @State var isTapped = false
    
    
    var body: some View {
        
        
        
        
        ZStack {
                    Image("bg_black")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(alignment: .leading, spacing: 4, content: {
                
                
               
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person.crop.square.fill")
                                                .foregroundColor(Color.gray)
                                                .padding(.leading, 16.0)
                                                .frame(width: 55, height: 51, alignment: .center)
                    
                    
                    TextField("" , text: $email){(status) in
                        
                                                    if status{
                                                        withAnimation(.easeIn){
                                                        isTapped = true
                                                        }
                                                    }
                    
                    
                    
                    } onCommit: {
                        if email == ""{
                                                        withAnimation(.easeOut){
                                                            isTapped = false
                                                        }
                                                    }
                    }
                    Image(systemName: "qrcode.viewfinder")
                                                .foregroundColor(.white)
                                                .padding(.trailing, 16.0)
                }
                .padding(.top,isTapped ? 15 : 0)
                .overlay(
                    Text("Email or Username")
                        .scaleEffect(isTapped  ? 0.8 : 1)
                        .offset(x: isTapped  ? -7 : 0, y: isTapped  ? -15 : 0)
                        .foregroundColor(.white)
                        
                    ,alignment: .center
                )
                
                
               // Divider()
                
                
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person.crop.square.fill")
                                                .foregroundColor(Color.white)
                                                .padding(.leading, 16.0)
                                                .frame(width: 55, height: 51, alignment: .center)
                    
                    
                    TextField("" , text: $password){(status) in
                        
                                                    if status{
                                                        withAnimation(.easeIn){
                                                        isTapped = true
                                                        }
                                                    }
                    
                    
                    
                    }
                    
                
                
                onCommit: {
                        if email == ""{
                                                        withAnimation(.easeOut){
                                                            isTapped = false
                                                        }
                                                    }
                    }
                    Image(systemName: "qrcode.viewfinder")
                                                .foregroundColor(.white)
                                                .padding(.trailing, 16.0)
                    
                }
                .foregroundColor(.white)
                .padding(.top,isTapped ? 15 : 0)
                .overlay(
                    Text("Password")
                        .scaleEffect(isTapped  ? 0.8 : 1)
                        .offset(x: isTapped  ? -7 : 0, y: isTapped  ? -22 : 0)
                        .foregroundColor(.white)
                    
                        
                    ,alignment: .center
                    
                    
                )
                Rectangle()
                    .frame(height:1)
            })
                   
            
    }
        
}
}

struct loginpage_Previews: PreviewProvider {
    static var previews: some View {
        loginpage()
    }
}
