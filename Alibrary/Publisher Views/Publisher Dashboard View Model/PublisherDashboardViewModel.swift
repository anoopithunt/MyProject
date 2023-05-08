//
//  PublisherDashboardViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation

class  PublisherDashboardViewModel: ObservableObject {
    @Published var datas:PublisherDashboardModel?
    @Published var months = [String]()
    @Published var purchBookCounts = [Int]()
    @Published var totreadbooks = [Double]()
    @Published var finalRCCounts = [Double]()
    @Published var totalUploads = [Int]()
    @Published var uploadTotMags = [Double]()
    func getDashboardData() {

        let apiurl = APILoginUtility.publisherDashboardApi
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

        service.getLoginData(from: url, model: PublisherDashboardModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.self
                    self.months = results.months
                    self.purchBookCounts = results.purchBookCounts
                    self.totreadbooks = results.totreadbooks
                    self.finalRCCounts = results.finalRCCounts
                    self.totalUploads = results.totalUploads
                    self.uploadTotMags = results.uploadTotMags
                    print(self.uploadTotMags)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
