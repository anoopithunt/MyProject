//
//  MagazineBookDetailsViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 07/11/22.
//

import Foundation

class MagazineBookDetailsViewModel: ObservableObject{
    @Published var data = [MagazineData]()
    @Published var count = 1
    @Published var per_page:Int = 1

    var totalPage: Int = 1
    init(){
    
        updateData()
      
    }
    func updateData(){
      
            let url = "https://alibrary.in/api/book-search?is_magazine&page=\(count)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, _) in
            do{
                let results = try JSONDecoder().decode(MagazineBookDetailsModel.self, from: data!)
                let oldData = self.data
                DispatchQueue.main.async {
                    self.data = oldData + results.bookDetails.data
                    self.totalPage = results.bookDetails.last_page
                    self.per_page = results.bookDetails.per_page
                    if self.count <= self.totalPage{
                        self.count += 1
                    }
                }
            }catch{
                print(url)

            }
           
       
        }.resume()
        }
    
}
