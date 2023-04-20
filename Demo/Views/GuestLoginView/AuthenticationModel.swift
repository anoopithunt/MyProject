//
//  AuthenticationModel.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 26/12/22.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}




// Login dashBoard Model Authentication Model
struct LoginRequestBodyAuth: Codable {
    let email: String
    let password: String
    let logout_consent:String
}

struct LoginAuthResponse: Codable {
    let access_token: String?
    let email: String?
    let message: String?
    let agent: Agent?
}

struct Agent: Codable{
    let full_name: String
    let partner_role: AuthPartnerRole?
}

struct AuthPartnerRole: Codable{
    let name: String
}



// Get  Authentication ViewModel Here Written


class AuthenticationService {
    
    func getDashBoardData(token: String, completion: @escaping (Result<DashBoardModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: ApiUtils.loginDashboardApi!) else {
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
            
            guard let response = try? JSONDecoder().decode(DashBoardModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
          
            
        }.resume()
        
        
    }
}



//    func login(username: String, password: String,completion: @escaping (Result<String, AuthenticationError>) -> Void) {
//
//        guard let url = URL(string: APILoginUtility.loginAuthurl) else {
//            completion(.failure(.custom(errorMessage: "URL is not correct")))
//            return
//        }
//
//        let body = LoginRequestBodyAuth(email: username, password: password, logout_consent: "1" )
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONEncoder().encode(body)
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                completion(.failure(.custom(errorMessage: "No data")))
//                return
//            }
//
//
//
//            guard let loginResponse = try? JSONDecoder().decode(LoginAuthResponse.self, from: data) else {
//                completion(.failure(.invalidCredentials))
//                return
//            }
//
//            guard let token = loginResponse.access_token else {
//                completion(.failure(.invalidCredentials))
//                return
//            }
//
//
//            completion(.success(token))
//
//        }.resume()
//
//    }
//
//
//}
