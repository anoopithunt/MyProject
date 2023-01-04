//
//  HomePublisherVM.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/22.
//

import Foundation
class HomePublisherVM: ObservableObject {
    @Published var datas = [UsersList]()
    let url = "https://www.alibrary.in/api/web-home"


    init() {
        getData(url: url)
    }
    
    func getData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(HomePublisherModel.self, from: data)
                    DispatchQueue.main.async {
                        self.datas = results.userslists
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}
