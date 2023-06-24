//
//  HttpUtils.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 19/12/22.
//

import Foundation

struct HttpUtility{
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            }
            
        }.resume()
        
    }
    
    
}
 

//class HTTPLoginUtility {
//    func getLoginData<T: Decodable>(from url: URL, model: T.Type, token: String, completion: @escaping (Result<T, Error>) -> Void) {
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                completion(.failure(error!))
//                return
//            }
//
//            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
//                completion(.failure(error!))
//                return
//            }
//
//            completion(.success(response))
//        }.resume()
//    }
//}


class HTTPLoginUtility {
    func getLoginData<T: Decodable>(from url: URL, model: T.Type, token: String, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for network errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check for non-HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                let nonHTTPResponseError = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
                completion(.failure(nonHTTPResponseError))
                return
            }
            
            // Check for HTTP error status codes
            guard (200...299).contains(httpResponse.statusCode) else {
                let httpError = NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(httpError))
                return
            }
            
            // Check if data is available
            guard let data = data else {
                let noDataError = NSError(domain: NSURLErrorDomain, code: NSURLErrorDataNotAllowed, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            // Attempt to decode the data
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
