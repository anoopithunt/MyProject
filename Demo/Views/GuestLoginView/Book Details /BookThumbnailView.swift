//
//  BookThumbnailView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 22/03/23.
//

import SwiftUI

struct BookThumbnailView: View {
    @StateObject var list = PreviewBooksViewModel()
    @Binding var isOpenThumbnail: Bool
    @Binding var currentPage: Int
        let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    @State var id: Int = 17
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
                list.getBookData(id: self.id)
            }
        }
}

struct BookThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbView()
       
    }
}



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
                PDFKitViews(id: 17)
                BookThumbnailView(isOpenThumbnail: $isOpenThumbnail, currentPage: $currentPage)
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(x: self.isOpenThumbnail ? 0 : 2*UIScreen.main.bounds.width)
                    .animation(.linear(duration: 0.45))
            }
        }
    }
}
