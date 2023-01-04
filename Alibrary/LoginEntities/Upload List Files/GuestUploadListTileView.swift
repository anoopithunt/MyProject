//
//  GuestUploadListTileView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/03/23.
//

import SwiftUI


struct GuestUploadListTileView:View{
    @Binding var uploadData: Int
    @State var uploadIcon: String = ""
    @State var uploadImage: String = ""
    @State var uploadType: String = ""
    
    
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack(spacing: 12){
                Spacer()
                Image(uploadIcon).resizable().frame(width: 17, height: 19)
                Text("\(uploadData)").foregroundColor(.gray).font(.system(size: 22, weight: .semibold))
            }.padding(8)
            Image(uploadImage).resizable().frame(width: 75, height: 75).padding(.leading)
            VStack(alignment: .leading){
                Rectangle().foregroundColor(.black).frame(width: UIScreen.main.bounds.width/2.2,height: 2.0)
                Text(uploadType).foregroundColor(.white).font(.system(size: 20, weight: .medium)).padding(.leading)
            }.padding(.bottom,2).background(Color.gray)
            
        }.background(Color("gray")).cornerRadius(6).frame(width: UIScreen.main.bounds.width/2.2 ).padding(2)
    }
}

