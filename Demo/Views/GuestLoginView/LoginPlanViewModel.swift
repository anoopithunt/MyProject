//
//  LoginPlanViewModel.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 24/12/22.
//

import SwiftUI
//import Firebase
//import FirebaseAuth

enum GuestLoginPlanModel: Decodable, Hashable {
    case integer(Int)
    case string(String)

    // -- here
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(GuestLoginPlanModel.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Plan"))
    }
}


struct LoginPlanModel: Decodable {
    var plans: [[GuestLoginPlanModel]]
    var rcPricings: [LoginRCPricing]
    var userRole: String
    var active_donation_rc: Int
    var upload_remain: Int
    var upload_total: Int
}


public struct LoginRCPricing: Decodable {
    public var id: Int
    public var name: String
    public let price: Int
    public let discount: Int
    public let rc_from: Int
    public let rc_to: Int
    enum CodingKeys: String, CodingKey {
        case id, name, price, rc_to,rc_from,discount
    }
    
    public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.price = try container.decode(Int.self, forKey: .price)
            self.rc_from = try container.decode(Int.self, forKey: .rc_from)
            self.rc_to = try container.decode(Int.self, forKey: .rc_to)
            self.discount = try container.decode(Int.self, forKey: .discount)
        }
}


class LoginPlanViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        AuthService().login(username: username, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "access_token")
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
           defaults.removeObject(forKey: "access_token")
           DispatchQueue.main.async {
               self.isAuthenticated = false
           }
           
       }
    
}




class AuthenticationPlanService {
   
    
    func getPlansAuth(token: String, completion: @escaping (Result<LoginPlanModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: APILoginUtility.loginUserPlan!) else {
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
            
        
            
            
            
            guard let accounts = try? JSONDecoder().decode(LoginPlanModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(accounts))
      
            
            
        }.resume()
            
            
        }
    
    
    
    
//
//    func login(username: String, password: String,completion: @escaping (Result<String, AuthenticationError>) -> Void) {
//
//        guard let url = URL(string: APILoginUtility.loginAuthurl) else {
//            completion(.failure(.custom(errorMessage: "URL is not correct")))
//            return
//        }
//
//        let body = LoginRequestBodyAuth(email: username, password: password, logout_consent: "1")
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
//                print(data)
//                return
//            }
//
//            guard let token = loginResponse.access_token else {
//                completion(.failure(.invalidCredentials))
//
//                return
//            }
//
//            completion(.success(token))
//
//        }.resume()
//
//    }


}


 class AuthenticationPlanListService: ObservableObject {
 
    @Published var active_donation_rc = Int()
    @Published var upload_remain = Int()
    @Published var upload_total = Int()
    @Published var rcDataPrice = [LoginRCPricing]()
    @Published var datas: [[GuestLoginPlanModel]] = []
    @Published var guestPlanHeadings: [String] = []
    @State var fullName = String()
 
  func getPlanData() {
      
      let defaults = UserDefaults.standard
      guard let token = defaults.string(forKey: "access_token") else {
          return
      }

      AuthenticationPlanService().getPlansAuth(token: token){ (result) in
          switch result {
              case .success(let accounts):
                  DispatchQueue.main.async {
                      self.active_donation_rc =  accounts.active_donation_rc
                      self.upload_remain = accounts.upload_remain
                      self.upload_total = accounts.upload_total
                      self.rcDataPrice = accounts.rcPricings
                     
                      self.datas = Array(accounts.plans.dropFirst())
                      if let headers = accounts.plans.first { // <-- here
                                          for h in headers {
                                              switch h {
                                                 case .integer(_): break
                                                 case .string(let str):
                                                  if self.guestPlanHeadings.count < 3{
                                                      self.guestPlanHeadings.append(str)
                                                  }

                                              }
                                          }
                                      }
                    
                  
                  }
              case .failure(let error):
                  print(error.localizedDescription)
          }
      }
      
  }
    
}




struct PlansView_Previews: PreviewProvider {
    static var previews: some View {

        LoginViewExample1()
    }
}




struct LoginViewExample1: View {
    @Environment(\.dismiss) var dismiss
    @State var email = ""
    @State var password = ""
    @State var isAuthenticated: Bool = false
    @StateObject private var loginVM = GetAuthenticationViewModel()
    @StateObject private var accountListVM = AuthenticationPlanListService()
    @StateObject private var list = PurchasedBooksViewModel()
    var body: some View {
        NavigationView{


            VStack() {
                Text("Welcome!")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding([.top, .bottom], 50)
                    .shadow(radius: 6.0, x: 10, y: 10)

                Image("image")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 9.0, x: 20, y: 10)
                    .padding(.bottom, 40)

                VStack(alignment: .leading, spacing: 15) {
                    TextField("Username", text: $loginVM.username)
//                    TextField("Username", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 5, y: 10)

                    TextField("Password", text: $loginVM.password)
//                    TextField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 5, y: 10)
                }
                .padding([.leading, .trailing], 50)
                
                
                
                Button(action: {
//                    loginVM.login()
                    
                } ) {
                    Text("Forgot password?")
                        .padding([.leading], 150)
                        .foregroundColor(.white)
                }
                HStack{
                    Button(action: {
                       
                        loginVM.login()
//                        register()
                       
                    }) {
                        
                        
                        Text("**Sign in**")
                            .font(.system(size: 34, weight: .heavy))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 60)
                            .background(Color(.green))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                        
                    }.padding(.top, 50)
                 
                    NavigationLink(destination: ReadCreditView(), isActive: $loginVM.isAuthenticated){
                        EmptyView()
                    }.navigationBarBackButtonHidden(true)

                    
                    Button(action: {
                       
                        loginVM.logout()

                        
                    }) {
                        
                        
                        Text("**Sign Out**")
                            .font(.system(size: 34, weight: .heavy))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 60)
                                .background(Color(.red))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                      
                    }.padding(.top, 50)
                }
                if loginVM.isAuthenticated{
                    
                    
                    
                    NavigationLink(destination: {
                        if loginVM.isAuthenticated{
                            PurchagedBooksView().navigationTitle("Here Navigation..")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        }
                        else{
//                            AboutUsAlertView(shown: true)
                            EmptyView()
                        }
                    }, label: {
                        Text("Hello User You Are Logged In \(loginVM.username)").foregroundColor(.red).onAppear{
                            accountListVM.getPlanData()
//                            list.getPurchasedBooksData()
                         
                        }
                    })
                    
                    
                    
                    
                    Text("\(list.datas.count)").foregroundColor(.red).font(.system(size: 35, weight: .heavy))
                }
                else{
                    
                    Text("Hello User You Are Logged out....").foregroundColor(.yellow)
                }
                Spacer()
                NavigationLink(destination: {
                    if loginVM.isAuthenticated{
//                        UserAccountSettingView()
                        AccountSettingView()
                    }
                    else{
                        
                    }
                }, label: {
                    Text("**Account Setting View**").font(.system(size: 28, weight: .bold))
                        .foregroundColor(.purple)
                })
                
                Spacer()
                
                HStack {
                    
                    NavigationLink(destination: {
                        if loginVM.isAuthenticated{
                            DashboardView()

                        }
                        else{
                            
                        }
                    }, label: {
                        Text("Don't have an account? ")
                            .foregroundColor(.white)
                    })
         
                    NavigationLink(destination: {
                        if loginVM.isAuthenticated{
                            LoginPlansView()
                        }
                        else{
                            AboutUsAlertView(shown: true)
                        }
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(.yellow)
                    })
                    
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.pink, Color.yellow, Color.green, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }
    }
//    func register(){
//        Auth.auth().createUser(withEmail: email, password: password){ result, error in
//            if error != nil{
////                print(error?.localizedDescription as Any)
//            }
//            
//        }
//    }
    }

