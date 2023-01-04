//
//  AuthenticationGuestStackBookListService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation


class AuthenticationGuestStackBookListService {
    
    
    func getStackBookListData(token: String,currentPage:Int,id:Int, completion: @escaping (Result<GuestStackBookListModel, NetworkError>) -> Void) {
        
//
        guard let url = URL(string: "https://alibrary.in/api/student/stack-book-list?id=\(id)&bookSearch=&page=\(currentPage)") else {
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
            
            guard let response = try? JSONDecoder().decode(GuestStackBookListModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}
