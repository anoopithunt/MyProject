//
//  GuestUserUploadViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation


//MARK:  View Model



class GuestUserUploadViewModel: ObservableObject{
    
    @Published var datas = [GuestUserUploadDatum]()
//    @Published var total = Int()
    @Published var currentPage = 0
    @Published var totalPage = Int()
    @Published var id = Int()
//    var filterData = false
//    var bookType = "all"
    
    func getGuestUserUploadBookData() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationGuestUserUploadService().getUserUploadBookData(token: token, currentPage: currentPage) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.bookDetails.data
                    self.totalPage = results.bookDetails.total
                    
                    
                }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}



