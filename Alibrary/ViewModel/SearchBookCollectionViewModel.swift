//
//  SearchBookCollectionViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/12/22.
//

import Foundation
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
