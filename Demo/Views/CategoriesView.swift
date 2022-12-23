//
//  CategoriesView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 21/12/22.
//

import SwiftUI


import Foundation

// MARK: - Welcome
public struct CategoryModel:Decodable {
    public let bookcategory: Bookcategory
    public let bookDetails: [BookDetail]
    public let subcategorycol: [SubCategorylist]
//    public let categoryBooks: [CategoriespageModel]
}


//public struct CategoriespageModel: Decodable {
//    public let data: [CateggoryData]
//
//
//}

// MARK: - BookDetail
public struct BookDetail: Decodable {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let title: String
    public let author_name: String
    public let tot_view: Int
    public let published: String
    public let book_media: BookMedia

}

// MARK: - BookMedia
public struct BookMedia:Decodable {
    public let id: Int
    public let url: String
}


public struct Bookcategory: Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
//    public let bookcategoryDescription: String
    public let desc_by: String
    public let url: String
    public let banner: String

}

public struct SubCategorylist: Decodable{
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
}





struct CategoriesView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var list = CategoriesViewModel(_httpUtility: HttpUtility())
    var apiurl = "https://alibrary.in/api/explore_categories"
    @State var offset: CGFloat = 0
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView{
            VStack {

                HStack(spacing: 25){

                    Button(action: {
                        dismiss()

                    }, label: {
                        Image(systemName: "arrow.left").font(.system(size: 25))
                    })


                    Text("All").font(.system(size: 25))
                    Spacer()
                }.padding(.horizontal).frame(height: 75).background(Color("orange")).foregroundColor(.white)
                ScrollView(.vertical, showsIndicators: false) {

                        Section(header:  HStack(spacing: 10){
                            ScrollView(.horizontal, showsIndicators: false){

                                HStack {

                                    if (list.bookName.capacity != 0){
                                        Button(action: {
//                                            showProgress = true
                                        }, label: {
                                            Text("All").foregroundColor(.white).font(.system(size: 15)).foregroundColor(.white).padding().frame(height: 35).background(Color("default_")).cornerRadius(22)
                                        })
                                    }
                                    ForEach(list.bookName,id: \.id){item in
                                        Button(action: {


                                        }, label: {

                                            Text(item.category_name).font(.system(size: 15)).foregroundColor(.white).padding().frame(height: 35).background(Color("default_")).cornerRadius(22)

                                        })


                                    }
                                }.frame(height: 65).background(Color.white)

                            }
                        }, content: {
                            CircleProgressView()


                        }
                               )
                }
            }.onAppear{
                list.getData()
            }
        }
    }


}


struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    
    }
}

class CategoriesViewModel: ObservableObject {

    @Published var datas = [CategoryModel]()
    @Published var bookName = [SubCategorylist]()
    @Published var totalPage = Int()
    @Published var currentPage = 1

    private let httpUtility: HttpUtility

        init(_httpUtility: HttpUtility) {
            httpUtility = _httpUtility
        }

        func getData()
        {
            let apiUrl = "https://alibrary.in/api/explore_categories/3?page="
//            let apiUrl = ApiUtils.searchBooksCollectionApiurl!
            let params = "\(self.currentPage)"
            var request = URLRequest(url: URL(string: apiUrl)!)

            request.httpMethod = "GET"
//            request.httpBody = params.data(using: .utf8)
            httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: CategoryModel.self) { (results) in
                DispatchQueue.main.async {
//                    self.datas = results.subcategorycol.
                    self.bookName = results.subcategorycol


                                    }



            }
        }

}



public struct PublisherModel: Decodable  {
    public let userslist: [PublisherUser]

}

// MARK: - Userslist
public struct PublisherUser: Decodable {
    public let id: Int
    public let userid: Int
    public let totalBookViews: String
    public let totalfollowers: Int
    public let fullAddress: String
    public let partner_media: [PartnerPublisherMedia]

}

public struct PartnerPublisherMedia: Decodable  {
    public let id: Int
    public let partner_media_type_id: Int
    public let media_type_id: Int
    public let partner_id: Int   //PartnerPublisherMedia
    public let url: String
    public let partner_media_type: PartnerMediaType

}









