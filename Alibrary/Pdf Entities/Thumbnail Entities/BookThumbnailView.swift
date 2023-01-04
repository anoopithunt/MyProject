//
//  BookThumbnailView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/03/23.
//

import SwiftUI

struct BookThumbnailView: View {
    @StateObject var list = PreviewBooksViewModel()
    @Binding var isOpenThumbnail: Bool
    @Binding var currentPage: Int
        let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
        var body: some View {
            VStack{
//                Spacer().frame(height: 45)
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 5){
                        ForEach(0..<list.pdfs, id: \.self) { thumb in
                            VStack(spacing: 0){
                                VStack{
                                    
                                    AsyncImage(url: URL(string: "\(list.thumbnail)\(thumb+1).png")){ img in
                                        
                                        Button(action: {
                                            self.currentPage = thumb//-1
                                            self.isOpenThumbnail = false
                                        }, label: {
                                            img.resizable().frame( height: 195)//.cornerRadius(10)
                                        })
                                       
                                    }placeholder: {
                                        Color.white.frame( height: 195)//.cornerRadius(10)
                                    }
                                }.background(Color.white)
                                Divider()
                                Text("Page No. \(thumb+1)")
                                    .padding(.bottom)
                                    .foregroundColor(.black)
                            }.background(Color.gray)
                                .frame( height: 235)
                                .shadow(radius: 1)
                        }

                    }
                }
            }.onAppear{
                list.getBookData()
            }
        }
}

//struct BookThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookThumbnailView()
//    }
//}
