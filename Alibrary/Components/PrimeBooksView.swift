//
//  PrimeBooksView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/09/22.
//

import SwiftUI

struct PrimeBooksView: View{
    @StateObject var list = PrimeBookVM()
    var color = ["#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0"]
    var body: some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:15) {
      
                ForEach(list.datas, id: \.self){ item in

                    BooksView(imageUrl: item.url,bookTitle: item.title,bookPublished: item.published)
                        .padding(.leading,5)
             
                }
            }
            
            
        }
    }
}


struct PrimeBooksView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeBooksView()
    }
}
