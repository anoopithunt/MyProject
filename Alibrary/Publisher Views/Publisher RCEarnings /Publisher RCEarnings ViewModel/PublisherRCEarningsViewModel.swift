//
//  PublisherRCEarningsViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation


//MARK: PublisherRCEarningsViewModel
class  PublisherRCEarningsViewModel: ObservableObject {
   @Published var currentPage: Int = 1
   @Published var years  = [Int]()
   @Published var totalPage: Int = 0
   @Published var datas = [PublisherRCEarningDatum]()
   @Published var sel_month = ""
   @Published var sel_year = ""
   @Published var months: [String: String] = [:]
   func getRCEarningsData(currentPage: Int) {
       
     let apiurl = APILoginUtility.publisherRCEarningApi + "?month=\(self.sel_month)&year=\(self.sel_year)&page=\(self.currentPage)"
       guard let url = URL(string: apiurl) else {
           // handle invalid URL error
           print("This is incorrect API URL...")
           return
       }
       let defaults = UserDefaults.standard
       guard let token = defaults.string(forKey: "access_token") else {
           return
       }
//        let service = HTTPLoginUtility()

       HTTPLoginUtility().getLoginData(from: url, model: PublisherRCEarningModel.self, token: token){ (result) in
           switch result {
           
           case .success(let results):
               DispatchQueue.main.async {
                   self.totalPage = results.rcbooks.last_page
                    
                   self.months = results.months
                   
                   self.years = results.years
                   print(self.datas)
                   if !results.rcbooks.data.isEmpty {
                       if self.totalPage == 1{
                           self.datas = results.rcbooks.data
                           
                           print(self.datas.last!)
                       }
                       else{
                           self.datas.append(contentsOf: results.rcbooks.data)
                           print(self.currentPage)
                           
                       }
                       
                   }
                   else {
                       print("empty")
                   }
               }
           case .failure(let error):
               print(error.localizedDescription)
               
           }
           
       }
   }

}
