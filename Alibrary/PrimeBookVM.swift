//
//  PrimeBookVM.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/09/22.
//

import Foundation


class PrimeBookVM: ObservableObject {
    @Published var datas = [Datum]()
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://alibrary.in/api/book-search?is_prime") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(BooksModel.self, from: data)
                    DispatchQueue.main.async {
                        self.datas = results.bookDetails.data
                        print(self.datas)
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}
