//
//  SearchBarView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 26/07/22.
//

import SwiftUI

struct SearchBarView: View {
    @State var searchBox: String = ""
    var body: some View {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 42))
                            .font(.title)
                            .padding(.leading,25)
                            .foregroundColor(.gray)
        
                        HStack{
                            TextField("Search Publishers..", text: $searchBox)
                                .padding()
                            Image(systemName: "magnifyingglass")
                                .padding()
                        }
                        .frame( height: 40)
//                        .padding()
                        .overlay(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color.blue, lineWidth: 1)
        
        
                        )
                        .padding()
        
                        Image(systemName: "qrcode.viewfinder")
                            .frame(width: 45, height: 40, alignment: .center)
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(Circle())
                            .padding(.trailing, 24)
                    }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
