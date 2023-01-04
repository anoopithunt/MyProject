//
//  SearchBooksCollectionTileView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/12/22.
//

import SwiftUI

struct SearchBooksCollectionTileView:View{
    @State var image:String = "soft"
    @State var author:String = "Anoop Mishra"
    @State var published:String = ""
    @State var like:String = ""
    @State var by:String = ""
    var body: some View{
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 12).fill(Color.white)
                VStack(alignment: .leading,spacing: 4){
                    AsyncImage(url: URL(string: image)){
                        image in
                        image.resizable().frame(width: UIScreen.main.bounds.width/2.2, height: UIScreen.main.bounds.height/3.6).padding(11)
                    }placeholder: {
                        Image("logo_gray").resizable().frame(width: UIScreen.main.bounds.width/2.2, height: UIScreen.main.bounds.height/3.6).padding(11)
                    }
                    
                    
                    Text("\(author)").foregroundColor(.black).padding(.horizontal).font(.system(size: 12))
                    Text("By:\(by)").foregroundColor(.brown).multilineTextAlignment(.leading).padding(.horizontal).font(.system(size: 13))
                    Text("Published: \(published)").foregroundColor(.black).padding(.horizontal).font(.system(size: 13))
                    Text("Like: \(like)").foregroundColor(.black).padding(.horizontal).font(.system(size: 14))
                    HStack{
                        Text("Add Now").font(.system(size: 18)).foregroundColor(.white).frame(height: 22).padding(10).background(Color.cyan).cornerRadius(22).overlay(RoundedRectangle(cornerRadius: 22).offset(x: 2, y: -1)
                            .stroke(Color.white, lineWidth: 3))
                        Spacer()
                        Text("**Prime**").font(.system(size: 16)).foregroundColor(.cyan)
                    }.padding(11)
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width/2.2).padding(.horizontal,13)
            }.frame(width: UIScreen.main.bounds.width/2.18,height: UIScreen.main.bounds.height/2.2, alignment: .center).padding(.horizontal,6).padding(.vertical,8)
                .cornerRadius(12).shadow(color: .gray.opacity(0.5),radius: 1).background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.white)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.1))
                    .shadow(radius: 4)
            )
            Spacer()
        }.padding(11)
    }
}

struct SearchBooksCollectionTileView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksCollectionTileView()
    }
}
