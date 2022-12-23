//
//  SearchMenu.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 25/08/22.
//

import SwiftUI

struct SearchMenu: View {
    @State var text: String = ""
    var body: some View {
        HStack( spacing: 12){
            Image(systemName: "chevron.left")
                .resizable()
                .font(.system(size: 33))
                .frame(width: 35, height: 35, alignment: .leading)
                .padding(.leading)

            TextField("Search", text: $text)
                .frame(height: 55,alignment: .center)
                .background(Color.white)
                .cornerRadius(35)
                
            
            Spacer(minLength: 0)
        }
        
        .frame( height: 65)
        .contentShape(Rectangle())
        .background(Color.gray)
        
    }
}

struct SearchMenu_Previews: PreviewProvider {
    static var previews: some View {
        SearchMenu()
    }
}
