//
//  BooksView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/09/22.
//

import SwiftUI

struct BooksView: View {
    @State var imageUrl: String?
     @State  var bookTitle: String?
     @State var bookPublished: String?
//    @State var bgColor = "default"
     var body: some View{
         VStack(alignment: .leading){
             AsyncImage(url: URL(string: "\(imageUrl!)")) { image in
                 image
                     .resizable().aspectRatio(contentMode: .fit)
                     .frame(width: 150, height: 215)
             } placeholder: {
                 Image("logo_gray").resizable().aspectRatio(contentMode: .fit)
                     .frame(width: 150, height: 215)
             }
             Text(bookTitle!).padding(.leading,4)
                 .multilineTextAlignment(.leading)
                 .font(.system(size: 13)).lineLimit(1)
             Text(" Published: \(bookPublished!)")
                 .font(.system(size: 11))
                 .fontWeight(.light).lineLimit(1).padding(.bottom)
         }
         .padding(2)
         .frame(width: 150,height: 250)
         .background(Color.white).cornerRadius(5)
         .shadow(color: .gray, radius: 1).offset(y: -4)
         
     }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView(imageUrl: "Anoop", bookTitle: "Books Title", bookPublished: "2 days ago")
    }
}

