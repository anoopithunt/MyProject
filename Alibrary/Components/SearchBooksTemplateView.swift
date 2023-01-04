//
//  SearchBooksTemplateView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 02/12/22.
//

import SwiftUI

struct SearchBooksTemplateView: View {

    @State var img: String = "https://storage.googleapis.com/pdffilesalib/pdf/coverpage/20211024174855_11.png"
    @State var author: String = "Anoop"
    @State var publication: String = "Blue StonePublication"
    @State var published: String = "11 months ago"
    @State var like: Int = 0
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading,spacing: 5) {
                AsyncImage(url: URL(string: img )){ image in
                    image.resizable().frame( height: 210)
                    
                }placeholder: {
                    Image("logo_gray").resizable().frame( height: 210)
                }
                Text("**Author**:  \(author)").padding(.leading,1).lineLimit(1).font(.system(size: 10))
                Text("**By:** \(publication)" ).padding(.leading,1).lineLimit(1).font(.system(size: 10))
                Text("**Published**: \(published)").padding(.leading,1).lineLimit(1).font(.system(size: 10))
                Text("Like: \(like)")
                
                HStack{
                    Text("Add Now").font(.system(size: 18)).foregroundColor(.white).frame(height: 22).padding(10).background(Color.cyan).cornerRadius(22).overlay(RoundedRectangle(cornerRadius: 22).offset(x: 2, y: -1)
                        .stroke(Color.white, lineWidth: 3))
                    Spacer()
                    Text("**Prime**").font(.system(size: 16)).foregroundColor(.cyan)
                }
              
                
            }
            .frame(width: UIScreen.main.bounds.width/2.7,  alignment: .center)
            .padding(.horizontal).padding(.vertical,8)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.white)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.1))
                    .shadow(radius: 4)
            )
        }
        .frame(maxWidth: UIScreen.main.bounds.width/2.1, maxHeight: .infinity)
    }
}


struct SearchBooksTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksTemplateView()
    }
}
