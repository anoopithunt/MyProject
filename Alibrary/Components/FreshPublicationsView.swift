//
//  FreshPublicationsView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/09/22.
//

import SwiftUI

struct FreshPublicationsView: View {
    @StateObject var freshPublicationObject = FreshPublicationsVM()
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
         
            HStack(spacing:15) {
                ForEach(freshPublicationObject.datas, id: \.self){ item in
                    BooksView(imageUrl: item.url,bookTitle: item.title,bookPublished: item.published)
                        .padding(.leading,5)
                }
            }
        }
    }
}

struct FreshPublicationsView_Previews: PreviewProvider {
    static var previews: some View {
        FreshPublicationsView()
    }
}
