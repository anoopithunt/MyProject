//
//  PopularBooksVM.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/09/22.
//

import Foundation
import SwiftUI

class PopularBookVM: ObservableObject {
    @Published var datas = [Datum]()
    let url = "https://alibrary.in/api/book-search?is_popular"
    
    init() {
        getData(url: url)
    }
    
    
    func getData(url: String) {
        guard let url = URL(string: "\(url)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(BooksModel.self, from: data)
                    DispatchQueue.main.async {
                        self.datas = results.bookDetails.data
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}
