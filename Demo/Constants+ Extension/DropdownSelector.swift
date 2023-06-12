//
//  DropdownSelector.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 03/12/22.
//

import Foundation
import SwiftUI

struct DropdownSelector: View{
    @State var value = ""
    var placeholder = "Select Client"
    var dropDownList = ["Prayagraj", "Pratapgarh", "Agra", "Lucknow", "Varanasi", "Kanpur"]
    var body: some View {
       
        
        
        Menu {
            
                ForEach(dropDownList, id: \.self){ client in
                    Button(action: {
                        self.value = client
                    }, label: {
                        
                        Text(client)
                            .foregroundColor(.black)
                    })

            }
        } label: {
            VStack(spacing: 5){
                HStack{
                    Text(value.isEmpty ? placeholder : value)
                        .foregroundColor(value.isEmpty ? .gray : .black).font(.system(size: 22))
                    Spacer()
                    Image(systemName: "play.fill").rotationEffect(Angle(degrees: 90))
                        .foregroundColor(Color.gray)
                        .font(Font.system(size: 12, weight: .light))
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 2)
            }.padding()
        }
    }
}


struct DropdownSelector_Previews: PreviewProvider {

    static var previews: some View {

        DropdownSelector()
    }
}
