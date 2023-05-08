//
//  HTTPUtility.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/12/22.
//

import Foundation
struct HttpUtility{
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void){
        
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in

            if(error == nil && responseData != nil && responseData?.count != 0){
                
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


struct HttpUtility1 {

    func getApiData<T: Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping (_ result: T?, _ error: Error?) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in

            if let httpResponse = httpUrlResponse as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    //parse the responseData here
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(T.self, from: responseData!)
                        completionHandler(result, nil)
                    }
                    catch let error {
                        completionHandler(nil, error)
                        debugPrint("error occured while decoding = \(error.localizedDescription)")
                    }
                case 401:
                    // unauthorized, handle appropriately
                    completionHandler(nil, APIError.unauthorized)
                case 404:
                    // not found, handle appropriately
                    completionHandler(nil, APIError.notFound)
                default:
                    // some other error occurred, handle appropriately
                    completionHandler(nil, APIError.unknown)
                }
            } else if let error = error {
                completionHandler(nil, error)
                debugPrint("error occured = \(error.localizedDescription)")
            } else {
                completionHandler(nil, APIError.unknown)
            }
            
        }.resume()
    }
}

enum APIError: Error {
    case unauthorized
    case notFound
    case unknown
}
