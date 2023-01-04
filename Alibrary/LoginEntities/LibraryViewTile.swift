//
//  LibraryViewTile.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import SwiftUI

struct LibraryViewTile: View{
    @State var total: String
    @State var title: String
    @State var headTitle: String
    @State var icon: String
    var body: some View{
        
        VStack {
            HStack(alignment: .center){
                Spacer()
                Image(icon)
                    .resizable()
                    .frame(width: 120, height: 105)
                
                Spacer()
                
                VStack(spacing: 12){
                    Text(headTitle)
                        .font(.system(size: 26, weight: .bold)).foregroundColor(.black)
                    Spacer()
                    Text(total)
                        .foregroundColor(Color("default_"))
                        .font(.system(size: 32, weight: .black))
                }.padding(.vertical)
                Spacer()
            }.padding(22)
            Spacer()
            ZStack(alignment: .center){
                Color.black.frame(height: 55)
                Text(title).foregroundColor(.white).font(.system(size: 24, weight: .bold)).padding(.bottom)
                
            }
        }.frame(height: 213).background(Color.white).cornerRadius(12).shadow(radius: 3).padding()
    }
    
}


//struct LibraryViewTile_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryViewTile()
//    }
//}
