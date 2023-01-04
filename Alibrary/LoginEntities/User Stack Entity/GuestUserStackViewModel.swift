//
//  GuestUserStackViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation
//MARK:  View Model



class GuestUserStackViewModel: ObservableObject{
    
    @Published var datas = [GuestUserStackDatum]()
//    @Published var total = Int()
    @Published var image: [String] = []
    @Published var currentPage = 0
    @Published var totalPage = Int()
    @Published var id = Int()
    
    func getUserStackBookData() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationGuestUserStackService().getUserStackBookData(token: token, currentPage: currentPage) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.datas.append(contentsOf: results.stacks.data)
                    self.totalPage = results.stacks.total
                    for data in self.datas {
                        for imgdata in data.stack_book_links.reversed(){
                             self.image.append(imgdata.url)
                           
                        }
                        
                        }
                    
                    
                }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
