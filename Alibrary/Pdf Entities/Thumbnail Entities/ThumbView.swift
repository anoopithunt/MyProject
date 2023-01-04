//
//  ThumbView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/03/23.
//

import SwiftUI

struct ThumbView: View {
    @State var isOpenThumbnail: Bool = false
    @State var currentPage:Int  = 3
    var body: some View {
        VStack{
            Button(action: {
                self.isOpenThumbnail.toggle()
            }) {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.green)
                    .imageScale(.large)
            }
            
            ZStack{
                PDFKitView()
                BookThumbnailView(isOpenThumbnail: $isOpenThumbnail, currentPage: $currentPage)
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(x: self.isOpenThumbnail ? 0 : 2*UIScreen.main.bounds.width)
                    .animation(.linear(duration: 0.45))
            }
        }
    }
}

struct ThumbView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbView()
    }
}
