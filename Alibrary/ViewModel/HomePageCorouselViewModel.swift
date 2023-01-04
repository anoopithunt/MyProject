//
//  HomePageCorouselVM.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 14/09/22.
//

import Foundation


class HomePageCorouselViewModel: ObservableObject {
    
    @Published var datas = [BookDetailModel]()
    
    private let httpUtility: HttpUtility
    
    init(_httpUtility: HttpUtility) {
        httpUtility = _httpUtility
        
    }
    
    func getData()
    {
        let apiUrl = ApiUtils.homePageApi
        let request = URLRequest(url: URL(string: apiUrl)!)
        
        httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: BookDetailCorouselModel.self) { (results) in
            DispatchQueue.main.async {
                self.datas = results.bookDetails
                
                
            }
            
            
            
        }
    }
}



