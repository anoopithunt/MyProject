//
//  PublisherBannerVM.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/09/22.
//

import Foundation
class PublisherBannerVM: ObservableObject {
    @Published var datas = [PublisherBanners]()
    
    let url = "https://www.alibrary.in/api/web-home"
    
    init() {
        getData(url: url)
    }
    
    
    func getData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(BannerModel.self, from: data)
                    DispatchQueue.main.async {
                        self.datas = results.publisherBanners
                      
                      
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}
