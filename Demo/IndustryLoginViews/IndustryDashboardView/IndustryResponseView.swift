//
//  IndustryResponseView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 05/12/23.
//

import SwiftUI

struct IndustryResponseView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{
                VStack{
                    HStack(spacing: 24){
                        Image(systemName: "plus")
                        Text("Responsive View")
                        Spacer()
                    }
                    .padding()
                    .frame(height: 105)
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .bold))
                    .background(Color.orange)
                    Spacer()
                    Text("Hello World").foregroundColor(.red)
                        .font(.system(size: 32, weight: .bold))
                    Spacer()
                     
                }
            }
        } else {
            NavigationView{
                VStack{
                    HStack(spacing: 24){
                        Image(systemName: "plus")
                        Text("Example View")
                        Spacer()
                    }.padding()
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold))
                        .background(Color.orange)
                    
                    Spacer()
                    
                    HStack{
                        Text("Hello, World!")
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct IndustryResponseView_Previews: PreviewProvider {
    static var previews: some View {
        IndustryResponseView()
    }
}
