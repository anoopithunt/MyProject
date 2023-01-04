//
//  AuthenticationDashBoardService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 20/01/23.
//

import Foundation
class AuthenticationDashBoardService: ObservableObject {
 
    @Published var partnerBookRCs = Int()
    @Published var purchasedBooks = Int()
    
    @Published var guestBooks = Int()

    @Published var ownStacks = Int()

    @Published var totalRC = Int()

    @Published var bookRequestCount = Int()
    @Published var rcFundCounts = Int()
    @Published var successPayCount = Int()

    
    
    
    func getDashBoardData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationService().getDashBoardData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.partnerBookRCs =  results.partnerBookRCs
                        self.purchasedBooks = results.purchasedBooks
                        self.bookRequestCount = results.bookRequestCount
                        self.ownStacks = results.ownStacks
                        self.totalRC = results.totalRC
                        self.successPayCount = results.successPayCount
                        print(results)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
}



class AuthenticationService {
    
    func getDashBoardData(token: String, completion: @escaping (Result<DashBoardModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: APILoginUtility.loginDashboardApi!) else {
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



class AuthenticationListService: ObservableObject {
 
    @Published var partnerBookRCs = Int()
    @Published var purchasedBooks = Int()
    
    @Published var guestBooks = Int()

    @Published var ownStacks = Int()

    @Published var totalRC = Int()

    @Published var bookRequestCount = Int()
    @Published var rcFundCounts = Int()
    @Published var successPayCount = Int()
    @Published var rem_plan_days = String()

    
    
    
    func getDashBoardData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationService().getDashBoardData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.partnerBookRCs =  results.partnerBookRCs
                        self.purchasedBooks = results.purchasedBooks
                        self.bookRequestCount = results.bookRequestCount
                        self.ownStacks = results.ownStacks
                        self.totalRC = results.totalRC
                        self.successPayCount = results.successPayCount
                        self.rem_plan_days = results.rem_plan_days
                        print(results)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
}
