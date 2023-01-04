//
//  CategoriesFilterBooksModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/10/22.
//

import Foundation
import UIKit
import SwiftUI


public struct FilterBooks:Decodable {
    public let subcategorycol: [FilterSubcategory]
    public let categoryBooks: FilterCategoryBooks
}

public struct FilterSubcategory:Decodable{
    public let id: Int
    public let category_name: String
}


public struct FilterCategoryBooks:Decodable{
    public let data: [FilterDatum]
    public let last_page: Int
    public let current_page: Int
    public let next_page_url: String?
//    public let path: String
    public let per_page: Int

}



public struct FilterDatum:Decodable{
    public let id: Int
    public let book_media: FilterbookMedia
}
public struct FilterbookMedia: Decodable,Identifiable{
    public let id: Int
    public let url: String
    
}



//struct FilterPageApi: View{
//    @State var listData:FilterCategoriesViewModel = FilterCategoriesViewModel(id: 1, subId: 19)
//    @State var id: Int = 1
//    @State var subId: Int = 19
//    @State var pressed:Bool = false
//    var body: some View{
//        NavigationView{
//            VStack{
//
//                HStack{
//                    Button(action: {
//                        method(id: 3)
//                    }, label: {
//                        Text("All")
//                    })
//                    Button(action: {
//                        self.pressed = true
//                        method(id: 4)
//                    }, label: {
//                        Text("SubCat")
//                    })
//                }
//                if pressed{
//                    FilterCategoryView(id: id, subId: subId)
//                }
//                else{
//                    FilterCategoryView(id: id, subId: subId)
//                }
//
//
//
//            }   .navigationBarTitle("Home")
//
//        }
//    }
//    func method(id: Int){
//        self.id = id
//    }
//}
//
//struct FilterPageApi_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterPageApi()
//
//    }
//}










struct FilterCategoryView: View {
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 110)), count: 3)
      }
    @ObservedObject var listData: FilterCategoriesViewModel
    @State var id: Int
    @State var subId: Int
    init(id: Int, subId: Int){
        self.id = id
        self.subId = subId
        listData = FilterCategoriesViewModel(id: id, subId: subId)
    }
    
   
    var body: some View{
      ScrollView {

          
          
          LazyVGrid(columns: items, spacing: 10)  {
//              ForEach(0..<(listData.datas.count), id: \.self){ i in
//
//                  if i == self.listData.datas.count-1{
//
//                      filtercellApiView(data: self.listData.datas[i], isLast: true, listData: self.listData)
//
//
//                  }
//                  else{
//                      filtercellApiView(data: self.listData.datas[i], isLast: false, listData: self.listData )
//
//                  }
//
//              }
              
              ForEach(listData.datas, id: \.id){ item in
                  AsyncImage(url: URL(string: item.book_media.url)){
                      image in
                      image.resizable().frame(height:235).cornerRadius(12)
                  }placeholder: {
                      Image("logo_gray").frame(height:235).cornerRadius(12)
                  }
                  
              }
              if listData.count < listData.totalPage{
                  CircleProgressView().frame(alignment: .center).onAppear{
                      listData.count = listData.count + 1
                      print("\(listData.count)")
                      listData.updateData()
                  }
              }
          }
        }
    }
}

//struct FilterCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterCategoryView(id: 2)
//    }
//}


class FilterCategoriesViewModel: ObservableObject{
    @Published var datas = [FilterDatum]()
   @Published var btns = [FilterSubcategory]()
    @Published var count = 1
//    @Published var per_page:Int = 1
    var id: Int
    
    var subId: Int = 21
    var totalPage: Int = 1
    init(id: Int, subId: Int){
        self.subId = subId
        self.id = id
        updateData()
      
    }
    func updateData(){
      
            let url = "https://www.alibrary.in/api/explore_categories/\(id)/\(subId)?page=\(count)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, _) in
            do{
                let results = try JSONDecoder().decode(FilterBooks.self, from: data!)
                let oldData = self.datas
                DispatchQueue.main.async {
                    self.datas = oldData + results.categoryBooks.data
                    self.totalPage = results.categoryBooks.last_page
//                    self.per_page = results.categoryBooks.per_page
//                    if self.count <= self.totalPage{
//                        self.count += 1
//                        print(self.totalPage)
//                    }
                }
            }catch{
                print("Anoop==\(url)")
//
            }
           
       
        }.resume()
        }

    
}




struct filtercellApiView: View{
    
    var data: FilterDatum
    var isLast: Bool
    @StateObject var listData:FilterCategoriesViewModel
    var body: some View{
        VStack{
            if isLast{
                
               
                HStack(alignment: .center) {
                  
                    AsyncImage(url: URL(string: data.book_media.url)){ image in
    
    
                            image
                            .resizable().scaledToFit().cornerRadius(12)}placeholder: {
    
                                ProgressView()
    
    
                    }
                        .onAppear{
                           
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                             
                                if self.listData.datas.count != self.listData.totalPage{
                                    self.listData.updateData()
                                }
                            }
                    }
                   
                   
                }
            }
            else{
            
                
                AsyncImage(url: URL(string: data.book_media.url)){ image in
                    
                    
                    image
                    .resizable().scaledToFit().cornerRadius(12)}placeholder: {
                        Image("logo_gray").resizable().scaledToFit().cornerRadius(12)

                    }

            }
        }

        .padding(.horizontal, 10)
    }

}
