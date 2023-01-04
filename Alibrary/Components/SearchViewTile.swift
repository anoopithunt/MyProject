//
//  SearchViewTile.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/12/22.
//

import SwiftUI

struct SearchViewTile:View{
    @State var searchText: String = ""
    var body: some View{
        ZStack{
            Rectangle().fill(Color("orange")).frame(height: 60)

            TextField("search books", text: $searchText).font(.system(size: 24)).padding().foregroundColor(.gray).frame(height: 45).background(Color.white).cornerRadius(10).padding(.horizontal,11).overlay{
                HStack{
                    Spacer()
                    Image(systemName: "magnifyingglass").font(.system(size: 26, weight: .heavy)).foregroundColor(.gray.opacity(0.7)).padding(.trailing,20)
                }.frame(height: 50)
            }
        }.frame(maxHeight: 70)
    }
}
struct SearchViewTile_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewTile()
    }
}
