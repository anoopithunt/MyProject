//
//  PrimeBooksCollectionView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 19/12/22.
//

import SwiftUI


struct SearchBooksCollectionTileView:View{
    @State var image:String = "soft"
    @State var author:String = "Anoop Mishra"
    @State var published:String = ""
    @State var like:String = ""
    @State var by:String = ""
    var body: some View{
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 12).fill(Color.white)
                VStack(alignment: .leading,spacing: 4){
                    AsyncImage(url: URL(string: image)){
                        image in
                        image.resizable().frame(width: UIScreen.main.bounds.width/2.2, height: UIScreen.main.bounds.height/3.6).padding(11)
                    }placeholder: {
                        Image("logo_gray").resizable().frame(width: UIScreen.main.bounds.width/2.2, height: UIScreen.main.bounds.height/3.6).padding(11)
                    }
                    
                    
                    Text("\(author)").foregroundColor(.black).padding(.horizontal).font(.system(size: 12))
                    Text("By:\(by)").foregroundColor(.brown).multilineTextAlignment(.leading).padding(.horizontal).font(.system(size: 13))
                    Text("Published: \(published)").foregroundColor(.black).padding(.horizontal).font(.system(size: 13))
                    Text("Like: \(like)").foregroundColor(.black).padding(.horizontal).font(.system(size: 14))
                    HStack{
                        Text("Add Now").bold().padding(10).background(Color.cyan).foregroundColor(.white).cornerRadius(22)
                        Spacer()
                        Text("prime").bold().foregroundColor(.cyan)
                    }.padding(11)
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width/2.2).padding(.horizontal,13)
            }.background(Color.white).frame(width: UIScreen.main.bounds.width/2.18,height: UIScreen.main.bounds.height/2.2)
                .cornerRadius(12).shadow(color: .gray.opacity(0.5),radius: 1)
            Spacer()
        }.padding(11)
    }
}

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
                SearchViewTile(searchText: searchText).frame(height: 65)
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
                                    SearchBooksCollectionTileView(image: item.url, author: item.name, published: item.published, like: "\(item.totalLikes)", by: item.publisherName)
//
                                }.padding(2)
                                if list.currentPage < list.totalPage{
                                    ProgressView().frame(alignment: .center).onAppear{
                                            list.currentPage = list.currentPage + 1
                                            print("\(list.currentPage)")
                                            list.getData()
                                        }
                                    }
                            }
                            .padding(.horizontal,2)
                        }
                  
//                Spacer()
            }.onAppear{
                list.getData()
            }
            if showProgress{
                Text("Refreshing...")
                    .onAppear{
//                        list.getData()
                    }
            }
        }
    }
}

struct PrimeBooksCollectionView_Previews: PreviewProvider {
    static var previews: some View {
//        PrimeBooksCollectionTileView()
        SearchBooksCollectionView()
//        SearchViewTile()
    }
}


struct SearchViewTile:View{
    @State var searchText: String = ""
    var body: some View{
        ZStack{
            Rectangle().fill(Color("orange"))

            TextField("search books", text: $searchText).font(.system(size: 24)).padding().foregroundColor(.gray).frame(height: 55).background(Color.white).cornerRadius(10).padding(.horizontal,11).overlay{
                HStack{
                    Spacer()
                    Image(systemName: "magnifyingglass").font(.system(size: 26, weight: .heavy)).foregroundColor(.gray.opacity(0.7)).padding(.trailing,20)
                }.frame(height: 55)
            }
        }
    }
}

// Model Of Prome Book Collection


import Foundation

public struct SearchBookCollectionModel:Decodable {
    public let bookDetails: SearchBookCollectionBookDetails
    public var uploadTypes: [SearchBookUploadType]
}

public struct SearchBookCollectionBookDetails:Decodable {
    public let data: [SearchBookCollectionData]
    public let last_page: Int
//    public let per_page: Int
//    public var last_page_url: String
}

public struct SearchBookCollectionData:Decodable {
        public let id: Int
        public let upload_type_id: Int
        public let name: String
        public let title: String
        public let author_name: String
        public let tot_view: Int
        public let published: String
        public let categroy_id: Int
        public let category_name: String
        public let totalLikes: Int
        public let url: String
        public let publisherName: String
        public let upload_type: PrimeBookUploadType

}

public struct PrimeBookUploadType:Decodable {
    public let id: Int
    public let name: String
    public let description: String

  
}

public struct SearchBookUploadType:Decodable{
  var  id: Int
    var name: String
    var description: String
}

class SearchBookCollectionViewModel:ObservableObject{
    @Published var datas = [SearchBookCollectionData]()
    @Published var bookName = [SearchBookUploadType]()
    @Published var totalPage = Int()
    @Published var currentPage = 1

    private let httpUtility: HttpUtility

        init(_httpUtility: HttpUtility) {
            httpUtility = _httpUtility
        }

        func getData()
        {
//            let apiUrl = "https://alibrary.in/api/book-search?is_prime=&upload_type_id=&page="
            let apiUrl = ApiUtils.searchBooksCollectionApiurl!
            let params = "\(self.currentPage)"
            var request = URLRequest(url: URL(string: apiUrl)!)
                                     
            request.httpMethod = "GET"
            request.httpBody = params.data(using: .utf8)
            httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: SearchBookCollectionModel.self) { (results) in
                DispatchQueue.main.async {
                    self.bookName = results.uploadTypes
                self.totalPage = results.bookDetails.last_page
                    self.datas.append(contentsOf: results.bookDetails.data)
                    
              
                                      
                                    }

                
            }
        }
}
