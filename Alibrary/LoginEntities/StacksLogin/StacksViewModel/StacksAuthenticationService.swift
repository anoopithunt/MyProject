//
//  StacksAuthenticationService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import Foundation


// View Model of Stacks for get Authentication
class StacksService{
    
    func getStacksData(token: String, completion: @escaping (Result<StacksModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: APILoginUtility.studentStacksApi!) else {
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
            
            guard let response = try? JSONDecoder().decode(StacksModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
    
}
