//
//  MenuSlider.swift
//  Alibrary
//
//  Created by Anoop Mishra on 13/07/22.
//

import SwiftUI



struct InputFieldView: View {


        
    @State var text: String = ""
    
//        @State var textColor: String = "red"
    
    
        @State var isTapped = false
        
        var body: some View{
        VStack{
           VStack(alignment: .leading, spacing: 8, content:{
               HStack(spacing: 15){
                   
                   Image(systemName: "person.crop.square.fill")

                       .padding(.trailing)
                   
                   TextField("UserName", text: $text)
                   {
                       (status) in
                       if status{
                           isTapped = true
                       }
                   }
                  
               onCommit: {
                   if text == ""{
                       withAnimation(.easeIn){
                           isTapped = false
                       }
                           
                       }
                      
                  
               }.foregroundColor(.white)

               .padding(.horizontal)
               .padding(.bottom,22)
                   Image(systemName: "lock")
                       .padding(.trailing)


                   
                   
               }
           
           .padding(.top,isTapped ? 33 : 0)
           .padding(.bottom)
           .background(
           
           Text("UserName or Email id")
            .font(.custom("title", size: 24))
            .padding(.leading)
            .padding(.bottom)
            .scaleEffect(0.8)
            .offset(x: isTapped ? -6 : 0 , y: isTapped ? -28 : 0)
            .foregroundColor(.white)
            
           ,alignment: .leading
           
           
           )
        
           }  )
          
           .padding(.top,12)
           .padding(.horizontal)
     
      
        }
        .underlineTextField()
        .background(Color.black.opacity(0))
//        .padding()
        .padding(.top,isTapped ? 33 : 0)
        .padding(.bottom,isTapped ? 33 : 0)
            
            
           
        }


    }


struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputFieldView()
//        PasswordField(text: "")
    }
}








//Password Field View Start..........



struct PasswordField: View {
    
    
    @State var isTapped = false
    @State var isSecuredField: Bool = true
    @State var text: String
    var body: some View
    {
        HStack {



            if isSecuredField{
                SecureField("Password",text: $text)
                    .foregroundColor(.white)
                    .padding(.horizontal,35)
                


            } else{
                TextField(text,text: $text)
                    .foregroundColor(.white)
                    .padding(.horizontal,33)

            }
        }
        .underlineTextField()
        .background(Color.white.opacity(0.09))
        .overlay(alignment: .leading){
            Image(systemName: "lock.fill")
                .foregroundColor(.white)
                .padding(.horizontal)
        }
        .overlay(alignment: .trailing){
            Image(systemName: isSecuredField  ? "eye.slash" : "eye")
                .foregroundColor(.white)
                .padding()
                .onTapGesture {
                    isSecuredField.toggle()


                }
        }
        
        .background(Color.gray)
        
        
        
//        VStack {
//            VStack(alignment: .leading, spacing: 8, content:{
//                HStack(spacing: 15){
//
//                    Image(systemName: "person.crop.square.fill")
//
//                        .padding(.trailing)
//
//                    TextField("Password", text: $text)
//                    {
//                        (status) in
//                        if status{
//                            isTapped = true
//                        }
//                    }
//
//
//                onCommit: {
//                    if text == ""{
//                        withAnimation(.easeIn){
//                            isTapped = false
//                        }
//
//                        }
//
//
//                }
//
//                .padding(.horizontal)
//                .padding(.bottom,22)
//                    Image(systemName: isSecuredField  ? "eye.slash" : "eye")
//                        .padding(.trailing)
//
//
//
//
//                }
//
//            .padding(.top,isTapped ? 33 : 0)
//            .padding(.bottom)
//            .background(
//
//            Text("UserName or Email id")
//             .font(.custom("title", size: 24))
//             .padding(.leading)
//             .padding(.bottom)
//             .scaleEffect(0.8)
//             .offset(x: isTapped ? -7 : 0 , y: isTapped ? -24 : 0)
//             .foregroundColor(.white)
//
//            ,alignment: .leading
//
//
//            )
//
//            }  )
//
//            .padding(.top,12)
//        .padding(.horizontal)
//        }
    }
}

