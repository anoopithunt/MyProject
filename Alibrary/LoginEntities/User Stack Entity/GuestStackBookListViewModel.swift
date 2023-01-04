//
//  GuestStackBookListViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation
//MARK: GuestStackBookListViewModel



class GuestStackBookListViewModel: ObservableObject{
    
    @Published var datas = [GuestStackBookListDatum]()
//    @Published var total = Int()
    @Published var image: [String] = []
    @Published var currentPage = 0
    @Published var totalPage = Int()
//    @Published var id = Int()
    
    func getStackBookListData(id: Int) {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationGuestStackBookListService().getStackBookListData(token: token, currentPage: currentPage, id: id) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.datas.append(contentsOf: results.stackBook_details.data)
                    self.totalPage = results.stackBook_details.total
 
                }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
