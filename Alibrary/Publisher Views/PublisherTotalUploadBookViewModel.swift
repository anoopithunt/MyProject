//
//  PublisherTotalUploadBookViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation
//MARK: PublisherTotalUploadBookViewModel
class  PublisherTotalUploadBookViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var fromDate: String = ""
    @Published var toDate: String =  ""
    @Published var totalPage: Int = 0
    @Published var datas = [PublisherTotalBooksUploadDatum]()
    
    func getTotalBookUploadData(currentPage: Int) {
        
              //  let apiurl = APILoginUtility.publisherMyEarningApi
        guard let url = URL(string: "https://www.alibrary.in/api/publisher/tot-book-upload?from_date=\(self.fromDate)&to_date=\(self.toDate)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: PublisherTotalBooksUploadModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
//                    self.datas = results.books.data
                    self.totalPage = results.books.last_page
                    
                    if !results.books.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.books.data
                        }
                        else{
                            self.datas.append(contentsOf: results.books.data)
                           print(self.currentPage)

                        }

                    }
                    else {
                        print("empty")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
        
    }

}
