//
//  StackBookListAuthenticationService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import Foundation
//Authentication Class


class StacksBooksListService{
   
   func getStackBooksListData(token: String,id: Int, completion: @escaping (Result<StackBookListModel, NetworkError>) -> Void) {
       let apiurl = APILoginUtility.studentStacksBookListApi!+"\(id)"
       guard let url = URL(string: apiurl) else {
           completion(.failure(.invalidURL))
           return
       }
       
       var request = URLRequest(url: url)
       request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           
           guard let data = data, error == nil else {
               completion(.failure(.noData))
               return
           }
           
           guard let response = try? JSONDecoder().decode(StackBookListModel.self, from: data) else {
               completion(.failure(.decodingError))
               return
           }
           
           completion(.success(response))
           
       }.resume()
       
       
   }
   
}
