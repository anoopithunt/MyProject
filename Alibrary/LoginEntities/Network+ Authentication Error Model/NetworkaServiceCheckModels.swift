//
//  NetworkaServiceCheckModels.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 28/12/22.
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
    let agent: Agent
}

struct Agent: Codable{
    let full_name: String
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
   
}
