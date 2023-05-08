//
//  HTTPLoginUtility.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 08/05/23.
//

import Foundation

class HTTPLoginUtility {
    func getLoginData<T: Decodable>(from url: URL, model: T.Type, token: String, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(response))
        }.resume()
    }
}
