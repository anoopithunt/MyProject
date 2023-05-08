//
//  WelcomeView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 30/06/22.
//

import SwiftUI
import Marquee

struct WelcomeView: View {
    
    var body: some View {
        ZStack
        {
        Image("bg_black")
                .resizable().frame(height: UIScreen.main.bounds.height)
               .ignoresSafeArea()
                
            VStack(alignment: .center) {
                Spacer()
                    Image("background")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/1.7, height: 235)
                    LinearProgressView().frame(height: 25)
                Spacer()

            }.frame(height: 275)
    
    }

    
    }
    


}
   
                    
   


struct WelcomeView_Previews: PreviewProvider {
  
    
    static var previews: some View {
        WelcomeView()
            .previewInterfaceOrientation(.portrait)
    }
}







