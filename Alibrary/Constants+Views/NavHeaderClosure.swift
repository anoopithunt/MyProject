//
//  NavHeaderClosure.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 11/04/23.
//

import SwiftUI

struct NavHeaderClosure<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    let content: () -> Content

    var body: some View {
       
            VStack(spacing: 0) {
                HStack(spacing: 25) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.white)
                    })
                    
                    Text(title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width, height: 65)
                .background(Color("orange"))
             
              
                // Call the content closure to add the dynamic content
                content()
               
                Spacer()
            }
        
    }
}

//struct NavHeaderClosure_Previews: PreviewProvider {
//    static var previews: some View {
//        NavHeaderClosure()
//    }
//}
