//
//  DonateView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 08/07/22.
//

import SwiftUI

struct DonateView: View {
    
    @State private var overText = false

    
    
    var body: some View {
        VStack{
        CustomNavBarView()
        Spacer()
       
            Image("alibdonateicons")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.7,  alignment: .center)
                .padding()
        
            Spacer()
                
            VStack (alignment:.center, spacing: 34){
                
                Text("Donate \nOur Foundation")
                    .foregroundColor(Color("AccentColor"))
                    .bold()
                    .font(.custom("Arial", size: 36))
                    .fixedSize()
                Image("upi-apps")
                    .padding()
                Image(systemName: "chevron.down")
                    .imageScale(.large)
                   
                
                
                Text("Donate Now")
                    .frame(width: 334, height: 60, alignment: .center)
                    //.background(.orange)
                    .foregroundColor(.white)
                    
                    .hoverEffect(.highlight)
//                    .padding(.top)

                    
                    .background(overText ? .green : .orange)
                                .onHover { over in
                                    overText = over
                                }
                                .cornerRadius(11)
                
         }
            //.padding()

            .frame(width: 365, height: 380, alignment: .center)
            .background(.white)
            .cornerRadius(22)

            .padding()
            Spacer()
            HStack(alignment: .center, spacing: 15){
                
                Image("fb_blue")
                Image("twt_blue")
               
                Image("you_tube_blue")
            }
            Spacer()
            Group{
            Text("Copyright 2022 by ")
                .foregroundColor(.white)
            Text("HELF Innovations Pvt. Ltd.")
                .foregroundColor(.white)
           // padding()
            
                    AsyncImage(url: URL(string: "https://www.alibrary.in/images/icons/alibfevicon.png")) {
                        image in
                        image.resizable()
            
                            .frame(width: 22, height: 22)
                            .padding()
            
            
                    }placeholder: {
                        Color.black
                     
                    }
            }
        }
        .background(Color("AccentColor"))
        .ignoresSafeArea(edges: .bottom)
        
        
        
    }
        
       
    
        
}


struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
      
//        VStack {
            DonateView()
               
//            Spacer()
//        }
//        .previewInterfaceOrientation(.portraitUpsideDown)

        
    }
}
