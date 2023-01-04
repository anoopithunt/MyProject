//
//  AuthenticationPreviewBookService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/03/23.
//

import Foundation


class AuthenticationPreviewBookService {
    func getBookData(token: String, completion: @escaping (Result<PreviewBooksModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: "\(APILoginUtility.preViewBooksApi)?id=17") else {
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
            
            guard let response = try? JSONDecoder().decode(PreviewBooksModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}
