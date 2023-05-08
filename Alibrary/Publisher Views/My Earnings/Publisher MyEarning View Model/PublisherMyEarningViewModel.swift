//
//  PublisherMyEarningViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation



//MARK: PublisherMyEarningViewModel
class  PublisherMyEarningViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var totalPage:Int = 1//Int()
    @Published var totalbookcount: Int = 0//Int()
    @Published var totalPublisehrEarned: Int = 0//Int()
    @Published var totCountRC: Int = 0//Int()
    @Published var totalRCEarn: Int = 0//Int()
    @Published var totalEarned: Int = 0//Int()
    
    func getEarningData() {
        
                let apiurl = APILoginUtility.publisherMyEarningApi
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: PublisherMyEarningModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
                    self.totCountRC = results.totCountRC
                    self.totalPublisehrEarned = results.totalPublisehrEarned
                    self.totalRCEarn = results.totalRCEarn
                    self.totalbookcount = results.totalbookcount
                    self.totalEarned = results.totalEarned
                    print(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
        
    }

}
