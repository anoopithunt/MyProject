//
//  JWTAuthExample.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 07/12/22.
//

import SwiftUI
//import ListPagination

struct JWTAuthExample: View {
    @StateObject private var loginVM = LoginViewModel()
       @StateObject private var accountListVM = AccountListViewModel()
       
       var body: some View {
           VStack {
               Form {
                   HStack {
                       Spacer()
                       Image(systemName: loginVM.isAuthenticated ? "lock.fill": "eye")
                   }
                   TextField("Username", text: $loginVM.username)
                   SecureField("Password", text: $loginVM.password)
                   HStack {
                       Spacer()
                       Button("Login") {
                           loginVM.login()
                       }
                       Button("Signout") {
                           loginVM.signout()
                           accountListVM.accounts.removeAll()
                       }
                       Spacer()
                   }
               }.buttonStyle(PlainButtonStyle())
               
               VStack {
                   
                   Spacer()
                   if loginVM.isAuthenticated && accountListVM.accounts.count > 0 {
                       List(accountListVM.accounts, id: \.id) { account in
                           HStack {
                               Text("\(account.name)")
                               Spacer()
                               Text(String(format: "$%.2f", account.balance))
                           }.background(Color.gray)
                       }.listStyle(PlainListStyle())
                   } else {
                       Text("Login to see your accounts!")
                   }
                   
                   Spacer()
                   
                   Button("Get Accounts") {
                       accountListVM.getAllAccounts()
                   }
                   .padding()
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                   
               }.frame(maxWidth: .infinity, maxHeight: .infinity)
               
              
           } .onAppear(perform: {
              
           })
           .navigationTitle("Login")
           .embedInNavigationView()
       }
}

struct JWTAuthExample_Previews: PreviewProvider {
    static var previews: some View {
        JWTAuthExample()
       
        
//        PaginationDataView()
//        Group {
//            PaginationDataView()
//                     .environment(\.colorScheme, .light)
//
//            PaginationDataView()
//                     .environment(\.colorScheme, .dark)
//               }
       
    }
}


class LoginViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(username: username, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
           
           let defaults = UserDefaults.standard
           defaults.removeObject(forKey: "jsonwebtoken")
           DispatchQueue.main.async {
               self.isAuthenticated = false
           }
           
       }
    
}



struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

class Webservice {

    func getAllAccounts(token: String, completion: @escaping (Result<[Account], NetworkError>) -> Void) {
           
           guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/accounts") else {
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
               
               guard let accounts = try? JSONDecoder().decode([Account].self, from: data) else {
                   completion(.failure(.decodingError))
                   return
               }
               
               completion(.success(accounts))
               
               
               
           }.resume()
           
           
       }
       
       
       func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
           
           guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/login") else {
               completion(.failure(.custom(errorMessage: "URL is not correct")))
               return
           }
           
           let body = LoginRequestBody(username: username, password: password)
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.httpBody = try? JSONEncoder().encode(body)
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in
               
               guard let data = data, error == nil else {
                   completion(.failure(.custom(errorMessage: "No data")))
                   return
               }
               
               try! JSONDecoder().decode(LoginResponse.self, from: data)
               
               guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                   completion(.failure(.invalidCredentials))
                   return
               }
               
               guard let token = loginResponse.token else {
                   completion(.failure(.invalidCredentials))
                   return
               }
               
               completion(.success(token))
               
           }.resume()
           
       }
    
    
}



import Foundation

enum API {
    case login
    case posts
    
    var url: URL {
        var component = URLComponents()
        switch self {
        case .login:
            component.scheme = "https"
            component.host = "reqres.in"
            component.path = path
        case .posts:
            component.scheme = "https"
            component.host = "jsonplaceholder.typicode.com"
            component.path = path
        }
        return component.url!
    }
}

extension API {
    fileprivate var path: String {
        switch self {
        case .login:
            return "/api/login"
        case .posts:
            return "/posts"
        }
    }
}




class AccountListViewModel: ObservableObject {
    
    @Published var accounts: [AccountViewModel] = []
    
    func getAllAccounts() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        Webservice().getAllAccounts(token: token) { (result) in
            switch result {
                case .success(let accounts):
                    DispatchQueue.main.async {
                        self.accounts = accounts.map(AccountViewModel.init)
                        print(accounts)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
}



struct AccountViewModel {
    
    let account: Account
    
    let id = UUID()
    
    var name: String {
        return account.name
    }
    
    var balance: Double {
        return account.balance
    }
}


struct Account: Decodable {
    let name: String
    let balance: Double
}


struct PaginationDataView:View{
    @StateObject var list = ServerManagerVM(_httpUtility: HttpUtility())
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    let array = ["Peter", "Paul", "Mary", "Anna-Lena", "George", "John", "Greg", "Thomas", "Robert", "Bernie", "Mike", "Benno", "Hugo", "Miles", "Michael", "Mikel", "Tim", "Tom", "Lottie", "Lorrie", "Barbara"]
        @State private var searchText = ""
        @State private var showCancelButton: Bool = false
        
        var body: some View {
            
            NavigationView {
                VStack {
                    // Search view
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("search", text: $searchText, onEditingChanged: { isEditing in
                                self.showCancelButton = true
                            }, onCommit: {
                                print("onCommit")
                            }).foregroundColor(.primary)
                            
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                            }
                        }
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                        
                        if showCancelButton  {
                            Button("Cancel") {
                                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                                    self.searchText = ""
                                    self.showCancelButton = false
                            }
                            .foregroundColor(Color(.systemBlue))
                        }
                    }
                    .padding(.horizontal)
                    .navigationBarHidden(showCancelButton) 
                    List {
                        // Filtered list of names
                        ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                            searchText in Text(searchText)
                        }
                    }
                    .navigationBarTitle(Text("Search"))
                    .resignKeyboardOnDragGesture()
                }
            }
        }
}

// Update for iOS 15
// MARK: - UIApplication extension for resgning keyboard on pressing the cancel buttion of the search bar
extension UIApplication {
    /// Resigns the keyboard.
    ///
    /// Used for resigning the keyboard when pressing the cancel button in a searchbar based on [this](https://stackoverflow.com/a/58473985/3687284) solution.
    /// - Parameter force: set true to resign the keyboard.
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}



class ServerManagerVM: ObservableObject{
    @Published var list = [SearchBookCollectionData]()
    @Published  var currentPage = 1
    @Published var totalPage = Int()

    private let httpUtility: HttpUtility

        init(_httpUtility: HttpUtility) {
            httpUtility = _httpUtility
        }

        func getData()
        {
            let apiUrl = "https://alibrary.in/api/book-search?is_prime=1&upload_type_id=1&page="
            let params = "\(self.currentPage)"
            var request = URLRequest(url: URL(string: apiUrl)!)
                                     
//            request.httpMethod = "GET"
            request.httpBody = params.data(using: .utf8)
            httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: SearchBookCollectionModel.self) { (results) in
                DispatchQueue.main.async {
//                    self.list = results.bookDetails.data
                    self.totalPage = results.bookDetails.last_page
                    print(self.totalPage)
                    self.list.append(contentsOf: results.bookDetails.data)
              
              
                                      
                                    }

                
                
            }
        }
       
}
