//
//  PublisherBookSuggestionViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/10/23.
//

import Foundation

// MARK: PublisherBookSuggestionViewModel
class PublisherBookSuggestionViewModel: ObservableObject {
    @Published var datas = [BookSuggestionDatum]()
    @Published var currentPage: Int = 1
    @Published var totalPage: Int = 1
    @Published var searchText: String = "" {
        didSet {
            currentPage = 1 // Reset currentPage when searchText changes
//            self.datas.removeAll()
            if self.searchText == "" {
                
                self.datas.removeAll()
                self.currentPage = 1
                getBookSuggestionData(currentPage: 1)
            }
            getBookSuggestionData(currentPage: currentPage)
        }
    }

    func getBookSuggestionData(currentPage: Int) {
        guard let searchTextEncoded = self.searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Failed to encode search text")
            return
        }

        guard let url = URL(string: APILoginUtility.bookRequestApi + "?id=61&bookSearch=\(searchTextEncoded)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
      

        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }

        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: BookSuggestionModel.self, token: token) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.books.last_page

                    if self.totalPage == 1 {
                        self.datas = results.books.data
                    } else {
                        self.datas.append(contentsOf: results.books.data)
                    }

                    if self.currentPage < self.totalPage {
                        self.currentPage += 1
                        self.getBookSuggestionData(currentPage: self.currentPage)
                    }

                }
            case .failure(let error):
                print(error.localizedDescription)
                // Handle the error here, e.g., display an alert or log the error.
            }
        }
    }
}

