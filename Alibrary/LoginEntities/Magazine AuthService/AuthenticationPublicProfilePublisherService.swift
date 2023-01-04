//
//  AuthenticationPublicProfilePublisherService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 03/04/23.
//

import Foundation

class AuthenticationPublicProfilePublisherService {
    func getBookData(token: String,currentPage:Int,type: String, completion: @escaping (Result<PublicProfilePublisher, NetworkError>) -> Void) {
        let apiUrl = "https://alibrary.in/api/student/publicProfile?id=128&bookSearch=&page="
        let params = "\(currentPage)"
        
        guard let url = URL(string: "\(apiUrl)\(currentPage)&type=\(type)") else {
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
            
            guard let response = try? JSONDecoder().decode(PublicProfilePublisher.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}
