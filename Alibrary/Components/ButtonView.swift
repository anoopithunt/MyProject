//
//  ButtonView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 06/07/22.
//

import SwiftUI

struct ButtonView: View {
    
    let btnName: String
    
    var body: some View {
        
            Text(btnName)
            .font(.system(size: 18))
            .frame(width: UIScreen.main.bounds.width/1.2, height: 18, alignment: .center)
                .padding()
                .foregroundColor(.white)
                .background(Color("AccentColor"))
            .cornerRadius(25)

           }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(btnName: "Give Button Name")
    }
}
