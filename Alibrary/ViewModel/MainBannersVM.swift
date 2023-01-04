//
//  MainBannersVM.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/22.
//

import Foundation
class MainBannersVM: ObservableObject {
    @Published var datas = [MainBanners]()
    let url = "https://www.alibrary.in/api/web-home"


    init() {
        getData(url: url)
    }
    
    func getData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(MainBannerModel.self, from: data)
                    DispatchQueue.main.async {
                        self.datas = results.mainBanners
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}
