//
//  PublicProfilePublisherViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 03/04/23.
//

import Foundation


class PublicProfilePublisherViewModel: ObservableObject{
    
    @Published var datas = [PublicProfilePublisherDatum]()
    @Published var banner = String()
    @Published var logo = String()
    @Published var followers = Int()
    @Published var total = Int()
    @Published var full_name = String()
    @Published var currentPage = 0
    @Published var totalPage = Int()
    var filterData = false
    var bookType = "all"
    
    func getBookData() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationPublicProfilePublisherService().getBookData(token: token, currentPage: currentPage, type: bookType) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.books.last_page ?? 1
                    self.followers = results.followers ?? 0
                    self.full_name = results.userDetails.full_name
                    self.total = results.books.total ?? 0
                    for img in results.userDetails.partner_media {
                        
                        if img.partnerMediatype == "Logo"{
                            self.logo = img.url
                            print(self.currentPage + self.datas.count)
                                           
                        }
                                           
                        else if img.partnerMediatype == "Banner"{
                                              
                            self.banner = img.url
                                                
                            //         print(self.banner)
                                            }
                                        }
                    if self.filterData {
                        self.datas.removeAll()
                    }
                    
                    self.currentPage += 1
                    self.datas.append(contentsOf: results.books.data)
                    
                    self.filterData = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMoreContentIfNeeded(currentItem item: PublicProfilePublisherDatum?) {
        guard let item = item else {
            getBookData()
            return
        }
        let thresholdIndex = datas.index(datas.endIndex, offsetBy: -5)
        if datas.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            getBookData()
        }
    }
    
}

