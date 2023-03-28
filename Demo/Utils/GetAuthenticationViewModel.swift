    //
    //  GetAuthenticationViewModel.swift
    //  Demo
    //
    //  Created by Sandeep Kesarwani on 27/12/22.
    //

    import Foundation
    
class GetAuthenticationViewModel: ObservableObject {

        @Published var isAuthenticated: Bool = false
        var username: String = "8299544315"
        var password: String = "12345678"
     
        func login() {

            let defaults = UserDefaults.standard

            AuthService().login(username: username, password: password) {
                result in
                switch result {
                    case .success(let token):
                        defaults.setValue(token, forKey: "access_token")
                        DispatchQueue.main.async {
                            self.isAuthenticated = true
                            print(token)
                           
                        }
                    case .failure(let error):
                    self.isAuthenticated = false
                    print(error.localizedDescription)

                }
            }
        }

        func logout() {

               let defaults = UserDefaults.standard
               defaults.removeObject(forKey: "access_token")
               DispatchQueue.main.async {
                   self.isAuthenticated = false
               }

           }
    }



 class AuthService{

    func login(username: String, password: String,completion: @escaping (Result<String, AuthenticationError>) -> Void) {

        guard let url = URL(string: APILoginUtility.loginAuthurl) else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }

        let body = LoginRequestBodyAuth(email: username, password: password, logout_consent: "1")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }

            

            guard let loginResponse = try? JSONDecoder().decode(LoginAuthResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }

            guard let token = loginResponse.access_token else {
                completion(.failure(.invalidCredentials))
                return
            }

            completion(.success(token))

        }.resume()

    }
    }
