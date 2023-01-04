//
//  GuestUploadListDashboardService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/03/23.
//

import Foundation

class GuestUploadListDashboardService{
    
    func getUploadListDashboardData(token: String, completion: @escaping (Result<UploadListDashboardModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: APILoginUtility.guestUploadListDashboardApi!) else {
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
            
            guard let response = try? JSONDecoder().decode(UploadListDashboardModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
}
