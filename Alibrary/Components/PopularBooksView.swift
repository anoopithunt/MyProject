//
//  PopularBooksView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/09/22.
//

import SwiftUI

struct PopularBooksView: View {
    @StateObject var popularObject = PopularBookVM()
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:15) {
                ForEach(popularObject.datas, id: \.self){ item in

                    BooksView(imageUrl: item.url,bookTitle: item.title,bookPublished: item.published)
                        .padding(.leading,5)
                }
            }
            
            
        }
    }
}

struct PopularBooksView_Previews: PreviewProvider {
    static var previews: some View {
        PopularBooksView()
    }
}
