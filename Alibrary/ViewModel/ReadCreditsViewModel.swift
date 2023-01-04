//
//  ReadCreditsViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/11/22.
//

import Foundation
class ReadCreditsViewModel: ObservableObject{

    @Published var rcDatas = [RCPricing]()

    let url = "https://www.alibrary.in/api/plans"

    init() {
        getData(url: url)
    }
    
    func getData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                  let result  = try JSONDecoder().decode(PlanModel.self, from: data)
                    DispatchQueue.main.async {
                        self.rcDatas = result.rcPricings
                      
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }

    
    

}
