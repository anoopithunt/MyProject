//
//  PublisherIssueBookViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation

class  PublisherIssueBookViewModel: ObservableObject {
    @Published var datas = [PublisherTotIssueBookDatum]()
    @Published var currentPage: Int = 1
    @Published var totalPage:Int = 1
    @Published var bookType = "all"
    func getDashboardData(currentPage: Int) {
        
                let apiurl = APILoginUtility.publisherIssueBooksApi
        guard let url = URL(string: "\(apiurl)?book_type=\(self.bookType)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: PublisherTotIssueBookModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.bookDetails.last_page
                    print(results)
                    if !results.bookDetails.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.bookDetails.data
                        }
                        else{
                            self.datas.append(contentsOf: results.bookDetails.data)
                            
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
