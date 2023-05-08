//
//  FilterCategoriesModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/10/22.
//

import Foundation
import SwiftUI

public struct PageBooks:Decodable {
//    public let id: Int
    public let subcategorycol: [FilterSubcategorycol]
    public let categoryBooks: PageCategoryBooks
}

public struct PageCategoryBooks:Decodable{
    public let data: [PageDatum]
    public let last_page: Int

}

public struct FilterSubcategorycol:Decodable{
    public let id: Int
    public let category_name: String
}

public struct PageDatum:Decodable{
    public let id: Int
    public let book_media: PagebookMedia
}
public struct PagebookMedia: Decodable,Identifiable{
    public let id: Int
    public let url: String
    
}


// ExploreCategories Books View Model


class ExploreCategoriesViewModel: ObservableObject{
    @Published var data = [PageDatum]()
    @Published var count = 1
//    @Published var per_page:Int = 1
   
    var id: Int
    var totalPage: Int = 1
    init(id: Int){
        self.id = id
        updateData()
      
    }
    func updateData(){
      
            let url = "https://www.alibrary.in/api/explore_categories/\(id)?page=\(count)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, _) in
            do{
                let results = try JSONDecoder().decode(PageBooks.self, from: data!)
                let oldData = self.data
                DispatchQueue.main.async {
                    self.data = oldData + results.categoryBooks.data
                    self.totalPage = results.categoryBooks.last_page
//                    self.per_page = results.categoryBooks.per_page
                    if self.count <= self.totalPage{
                        self.count += 1
                    }
                }
            }catch{
//                print(url)
                print(error.localizedDescription)    // At the Last this exception catch By this Code
            }
           
       
        }.resume()
        }
    
}












struct PageApi_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(sentid: "2")
     
            
    }
}



struct AllFilterExploreCategoryBooks:View{
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 110)), count: 3)
      }
    @ObservedObject var listData: ExploreCategoriesViewModel
    @State var id: Int
    init(id: Int){
        self.id = id
         listData = ExploreCategoriesViewModel(id: id)
    }
    
   
    var body: some View{
      ScrollView {
          
          LazyVGrid(columns: items, spacing: 10)  {
              ForEach(0..<(listData.data.count), id: \.self){ i in
                  
                    if i == self.listData.data.count-1{

                        AllFilterCellApiView(data: self.listData.data[i], isLast: true, listData: self.listData)

                        
                    }
                    else{
                        AllFilterCellApiView(data: self.listData.data[i], isLast: false, listData: self.listData )
                        
                    }
                    
              }
          }
        }
    }
}



struct AllFilterCellApiView: View{
    
    var data: PageDatum
    var isLast: Bool
    @StateObject var listData:ExploreCategoriesViewModel
    var body: some View{
        VStack{
            if isLast{
                
               
                    
                AsyncImage(url: URL(string: data.book_media.url)){ image in
                        
                        
                        image
                        .resizable().scaledToFit().cornerRadius(12)}placeholder: {
                         
                            ProgressView()
                       
                    
                }
                    .onAppear{
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                         
                            if self.listData.data.count != self.listData.totalPage{
                                self.listData.updateData()
                            }
                        }
                    }
            }
            else{
                
                
//                ProgressView()
                
                AsyncImage(url: URL(string: data.book_media.url)){ image in
                    
                    
                    image
                    .resizable().scaledToFit().cornerRadius(12)}placeholder: {
                        Image("logo_gray").resizable().scaledToFit().cornerRadius(12)
//                        ProgressView()
                    }

            }
        }

        .padding(.horizontal, 10)
    }

}



struct SearchViewTile1:View{
    @Environment(\.dismiss) var dismiss
    @StateObject var list = PrimeBookCollectionViewModel(_httpUtility: HttpUtility())
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
                                Text(books.category_name).foregroundColor(.white).font(.system(size: 22)).padding(.horizontal).padding(.vertical,8).background(Color("default_")).cornerRadius(22)
                            })
                        }
                    }
                }.padding(5)
                ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(list.datas, id: \.id){ item in
                                    AsyncImage(url: URL(string: item.book_media.url)){
                                        image in
                                        image.resizable().frame( height: 125).cornerRadius(25)
                                    }placeholder: {
                                        Image("logo_gray").resizable().frame( height: 125)
                                    }
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
                        list.getData()
                    }
            }
        }
    }
}



class PrimeBookCollectionViewModel:ObservableObject{
    @Published var datas = [PageDatum]()
    @Published var bookName = [FilterSubcategorycol]()
    @Published var totalPage = Int()
    @Published var currentPage = 1

    private let httpUtility: HttpUtility

        init(_httpUtility: HttpUtility) {
            httpUtility = _httpUtility
        }

        func getData()
        {
            let apiUrl = "https://www.alibrary.in/api/explore_categories/3?page="
//            let apiUrl = ApiUtils.searchBooksCollectionApiurl!
            let params = "\(self.currentPage)"
            var request = URLRequest(url: URL(string: apiUrl)!)
                                     
            request.httpMethod = "GET"
            request.httpBody = params.data(using: .utf8)
            httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: PageBooks.self) { (results) in
                DispatchQueue.main.async {
                    self.bookName = results.subcategorycol
                    self.totalPage = results.categoryBooks.last_page
                    self.datas.append(contentsOf: results.categoryBooks.data)
                    
              
                                      
                                    }

                
                
            }
        }
}












