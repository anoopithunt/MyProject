//
//  StacksViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import Foundation



// Stacks View Model for data fetching


class StacksViewModel: ObservableObject{
   
    @Published var datas = [StacksDatum]()
    @Published var image: [String] = []
    @Published var totalPage = Int()
    @Published var currentPage = 1
    func getStacksData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        StacksService().getStacksData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.datas = results.studentStacks.data
                        self.totalPage = results.studentStacks.total
//                        self.datas.append(contentsOf: results.studentStacks.data)
                        for data in self.datas {
                            for imgdata in data.stack_book_link.reversed(){
                                self.image.append(imgdata.book_url)
                             
                            }
//                            self.image =  self.revimage.reversed()
                            
                        }
                        print(self.datas)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}
