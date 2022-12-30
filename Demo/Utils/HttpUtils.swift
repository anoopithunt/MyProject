//
//  HttpUtils.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 19/12/22.
//

import Foundation

struct HttpUtility
{
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

struct HTTPLoginUtility{
    
    
    func getLData<T:Decodable, E:Error>(token: String,requestUrl: URL, resultType: T.Type, completion: @escaping (_ result: T,_ error: E) -> Void){
        let url = requestUrl
       var request = URLRequest(url: url)
       request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           
           if(error == nil && data != nil && data?.count != 0)
           {
               //parse the responseData here
               let decoder = JSONDecoder()
               do {
                   let result = try decoder.decode(T.self, from: data!)
                   _=completion(result, error as! E)
               }
               catch let error{
                   debugPrint("error occured while decoding = \(error.localizedDescription)")
               }
           }

       }.resume()
        
        
    }
    
//    func getLoginApiData<T:Decodable>(token: String,requestUrl: URL, resultType: T.Type, completion: @escaping (Result<T.Type, NetworkError>) -> Void) {
//
//         let url = requestUrl
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if(error == nil && data != nil && data?.count != 0)
//            {
//                //parse the responseData here
//                let decoder = JSONDecoder()
//                do {
//                    let result = try decoder.decode(T.self, from: data!)
//                    _=completion(result as! Result<T.Type, NetworkError>)
//                }
//                catch let error{
//                    debugPrint("error occured while decoding = \(error.localizedDescription)")
//                }
//            }
//
//        }.resume()
//
//        }
    
    
}



//enum DataError: Error {
//    case invalidResponse
//    case invalidURL
//    case invalidData
//    case network(Error?)
//}
//
//typealias Handler<T> = (Result<T, DataError>) -> Void
//
//final class APIManager {
//
//    static let shared = APIManager()
//    private init() {}
//
//    func request<T: Codable>(
//        modelType: T.Type,
//        type: EndPointType,
//        completion: @escaping Handler<T>
//    ) {
//        guard let url = type.url else {
//            completion(.failure(.invalidURL)) // I forgot to mention this in the video
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = type.method.rawValue
//
//        if let parameters = type.body {
//            request.httpBody = try? JSONEncoder().encode(parameters)
//        }
//
//        request.allHTTPHeaderFields = type.headers
//
//        // Background task
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data, error == nil else {
//                completion(.failure(.invalidData))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse,
//                  200 ... 299 ~= response.statusCode else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            // JSONDecoder() - Data ka Model(Array) mai convert karega
//            do {
//                let products = try JSONDecoder().decode(modelType, from: data)
//                completion(.success(products))
//            }catch {
//                completion(.failure(.network(error)))
//            }
//
//        }.resume()
//    }
//
//
//    static var commonHeaders: [String: String] {
//        return [
//            "Content-Type": "application/json"
//        ]
//    }
//
//}


