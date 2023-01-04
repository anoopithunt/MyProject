//
//  SearchBooksCollectionView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/12/22.
//

import SwiftUI

struct SearchBooksCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var list = SearchBookCollectionViewModel(_httpUtility: HttpUtility())
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    @State var searchText:String = ""
   @State var showProgress: Bool = false
    var body: some View {
        ZStack {
            Image("u").resizable().ignoresSafeArea()
            NavigationView{
                VStack(spacing: 0) {
                    HStack(spacing: 25){
                        
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.backward").font(.system(size:22, weight:.heavy)).foregroundColor(.white)
                        })
                        
                        Text("Book Collection").font(.system(size: 26, weight: .regular)).foregroundColor(.white)
                        Spacer()
                        
                        
                    }.padding().frame(width: UIScreen.main.bounds.width, height: 65).background(Color("orange"))
                    SearchViewTile(searchText: searchText).frame(height: 60)
                    ScrollView(.horizontal,showsIndicators: false){
                        
                        HStack{
                            if (list.bookName.capacity != 0){
                                Button(action: {
                                    showProgress = true
                                }, label: {
                                    Text("All").foregroundColor(.white).font(.system(size: 22)).padding(.horizontal,22).padding(.vertical,8).background(Color("default_")).cornerRadius(20)
                                })
                            }
                            
                            ForEach(list.bookName,id: \.id){ books in
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text(books.name).foregroundColor(.white).font(.system(size: 22)).padding(.horizontal).padding(.vertical,8).background(Color("default_")).cornerRadius(22)
                                })
                            }
                        }
                    }.padding(5)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(list.datas, id: \.id){ item in
                                
                                NavigationLink(destination: ShowBooksDetailsView(id: "\(item.id)").navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)){
                                        SearchBooksCollectionTileView(image: item.url, author: item.name, published: item.published, like: "\(item.totalLikes)", by: item.publisherName)
                                        //
                                    }.padding(4)
                            }
                            if list.currentPage < list.totalPage{
                                CircleProgressView().frame(width: 90,height: 82,alignment: .center).onAppear{
                                    list.currentPage = list.currentPage + 1
                                    print("\(list.currentPage)")
                                    list.getData()
                                }
                            }
                        }
                        .padding(.horizontal,2)
                    }
                    
                }.onAppear{
                    list.getData()
                }
//                if showProgress{
//                    Text("Refreshing...")
//                        .onAppear{
//                            //                        list.getData()
//                        }
//                }
            }
        }
    }
}


struct SearchBooksCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksCollectionView()
    }
}
