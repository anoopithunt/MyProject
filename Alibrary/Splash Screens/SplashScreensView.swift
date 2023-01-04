//
//  SplashScreensView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/07/22.
//

import SwiftUI

struct SplashScreensView: View {
    @AppStorage("currentPage") var currentPage = 0
    var body: some View {

     ZStack {

        
            Image("premium_stories")
                .resizable()

                .frame(width: UIScreen.main.bounds.width)

         VStack(alignment: .center, spacing: 1){
             Spacer()
                 .frame(height: 472)
            Text("My School")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.bottom)
                
//            Spacer()
               
            Text("If you are a student you can explore School Library, stacks, activitis and notification.")
                 .font(.custom("Regular", size: 22))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(.horizontal,65)
             
             Spacer()
             

         }

//         .ignoresSafeArea()
         .padding(.bottom)
        }
//        WalkthroughScreen()
    
        
    }
}

struct SplashScreensView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreensView()
    }
}

