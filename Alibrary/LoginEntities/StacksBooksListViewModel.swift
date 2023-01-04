//
//  StacksBooksListViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import Foundation

class StacksBooksListViewModel: ObservableObject{
   
    @Published var datas = [StackBookListDatum]()
//    @Published var image: [String] = []
    @Published var totalPage = Int()
    @Published var currentPage = 1
    func getStackBooksListData(id: Int) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        StacksBooksListService().getStackBooksListData(token: token,id: id){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.datas = results.stackBook_details.data
                        self.totalPage = results.stackBook_details.total
                        
//                        self.datas.append(contentsOf: results.studentStacks.data)
                    
                        print(self.datas)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}
