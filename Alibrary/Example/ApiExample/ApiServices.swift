//
//  ApiServices.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 28/07/22.
//

import Foundation
import SwiftUI
import Combine
import SwiftyJSON
class ApiServices: ObservableObject{
   
    @Published var datatotal = [PublisherListModel]()

//    init(){
//         let source =  "https://alibrary.in/api/publisherList"
//       let url = URL(string: source)!
//        let session =  URLSession(configuration: .default)
//
//        session.dataTask(with: url){
//            (data, _, error) in
//           if error != nil{
//               print(error?.localizedDescription ?? "ERROR OCCURED")
//               return
//           }
//            let result = try!JSON(data: data!)
//           for i in result["userlist"] {
//               let totalBookViews = i.1["totalBookViews"].stringValue
//               let full_name = i.1["full_name"].stringValue
//               let totalBooks  = i.1["totalBooks"].stringValue
//               let totalfollowers  = i.1["totalfollowers"].stringValue
//
//               DispatchQueue.main.async {
//                   self.datatotal.append(PublisherListModel(full_name: full_name, totalBookViews: totalBookViews, totalfollowers: totalfollowers, totalBooks: totalBooks))
//
//               }
//
//           }
//
//       }
//       .resume()
//   }
    
    
    init(){
        let source = "https://alibrary.in/api/publisherList"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url){
            (data, _, err) in
            if err != nil{
                print(err?.localizedDescription ?? "Hello Error")
                return
            }
            
            let json = try!JSON(data: data!)
            for i in json["userslist"]{
                let totalBookViews = i.1["totalBookViews"].stringValue
                let full_name = i.1["full_name"].stringValue
                let totalBooks  = i.1["totalBooks"].stringValue
                let totalfollowers  = i.1["totalfollowers"].stringValue
//                let url = i.1["url"].stringValue

                DispatchQueue.main.async {
                 
                    self.datatotal.append(PublisherListModel(totalBooks: totalBooks, full_name: full_name, totalBookViews: totalBookViews, totalfollowers: totalfollowers))
                    
                }
               
            }
               
        }
        .resume()
    }



}



class PublisherViewModel: ObservableObject {
    
    @Published var datas = [PublisherUserslist]()
   
    
    private let httpUtility: HttpUtility1
    
    init(_httpUtility: HttpUtility1) {
        httpUtility = _httpUtility
        
    }
    
    func getData()
    {
        let apiUrl = "https://alibrary.in/api/publisherList"
        let request = URLRequest(url: URL(string: apiUrl)!)
        
        httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: PublisherModel.self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                // Handle error
            } else if let result = result {
                DispatchQueue.main.async {
                    self.datas = result.userslist
                  
                }
            }
        }    }
}
