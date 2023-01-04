//
//  LibrariesViewTile.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import SwiftUI

struct LibrariesViewTile: View{
    @State var title: String
    @State var image: String
     var stackCount: String
     var pdfCount: String
    
    var body: some View{
        
        VStack(spacing:22){
            HStack{
                Image(image).resizable().frame(width: 100, height: 115)
                VStack(spacing:10){
                    Image("stack_gray")
                        .resizable()
                        .frame(width: 20, height: 25)
                    Image("pdf_gray")
                        .resizable()
                        .frame(width: 20, height: 25)
                }
                VStack(spacing:10){
                    Text(stackCount).font(.system(size: 22, weight: .semibold)).foregroundColor(Color(.black))
                    Text(pdfCount).font(.system(size: 20, weight: .semibold)).foregroundColor(.black)
                }

            }
            
          ZStack(alignment: .center){
                Color.gray.frame(height: 45)
              VStack(spacing:0){
                  Rectangle()
                      .frame(height: 2)
                      .foregroundColor(.black)
                  Spacer()
                  Text(title)
                      .font(.system(size: 20,weight: .bold))
                      .foregroundColor(.white)
                  Spacer()
              }
            }.frame(height: 45)
        }.background(Color("gray")).frame(width: UIScreen.main.bounds.width*0.47)
            .cornerRadius(12)
            .shadow(color: .gray,radius: 3)
        
    }
}


//struct LibrariesViewTile_Previews: PreviewProvider {
//    static var previews: some View {
//        LibrariesViewTile()
//    }
//}
