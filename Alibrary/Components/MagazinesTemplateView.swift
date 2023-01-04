//
//  MagazinesTemplateView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 07/11/22.
//

import SwiftUI

struct MagazinesTemplateView: View {
    @State var imgUrl:String
    @State var authorName:String
    @State var publisherName:String
    @State var published:String
    @State var totalLikes:Int
    
    
    var body: some View {
        Group {
            VStack(alignment: .leading){
                AsyncImage(url: URL(string: imgUrl)){ image in
                    image.resizable().frame(maxHeight: 245)
                }placeholder: {
                    Image("logo_gray").resizable().frame(height: 235)
                }
                Text(authorName).lineLimit(1).foregroundColor(Color("default_"))
                Text("**By:** \(publisherName)").foregroundColor(Color.brown.opacity(0.8)).font(.system(size: 14))
                Text("Published:\(published)").foregroundColor(Color("default_")).font(.system(size: 16))
                Text("**Like** \(totalLikes)").foregroundColor(Color("default_"))
                HStack{
                    Text("Add Now").foregroundColor(.white).padding(.horizontal).padding(.vertical,7).background(Color(.tintColor)).cornerRadius(28)   .overlay(
                        RoundedRectangle(cornerRadius: 25).offset(x: 2.3)
                            .stroke(Color.white, lineWidth: 3)
                )
                 
                    Text("prime").foregroundColor(.blue).fontWeight(.heavy)
                }
            }
        }.background(Color(.white)).padding(12).cornerRadius(21).overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray, lineWidth: 1)
    )
    }
}

struct MagazinesTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        MagazinesTemplateView(imgUrl: "", authorName: "", publisherName: "", published: "", totalLikes: 0)
    }
}
