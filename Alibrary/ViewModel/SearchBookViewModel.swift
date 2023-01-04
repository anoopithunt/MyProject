//
//  SearchBookViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 02/12/22.
//

import Foundation
class SearchBookViewModel: ObservableObject {
    @Published var datas = [SearchBookDatum]()
    @Published var datas1 = [SearchBookUploadTypes]()
    @Published  var isLoading: Bool = true
    let url = "https://alibrary.in/api/book-search?text=&page=&upload_type_id=0&month=&year="
    
    init() {
        getData(url: url)
    }
    
    func getData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(SearchBookModel.self, from: data)
//                    let results1 = try JSONDecoder().decode(SearchBookModel.self, from: data).uploadTypes
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let results = try decoder.decode(SearchBookModel.self, from: data)
                    DispatchQueue.main.async {

                        self.datas = results.bookDetails.data
                        self.datas1 = results.uploadTypes
                        self.isLoading = false
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
    
}
