//
//  GuestProfileView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 26/12/22.
//

import SwiftUI

struct GuestProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var list = UserProfileViewModel()

    var body: some View{
        
        
        ZStack {
            if colorScheme == .dark{
                Image("u").resizable()
            }
            else{
                Image("u").resizable()
            }
            
            VStack{
                VStack{
                ZStack{
                    
                    AsyncImage(url: URL(string: list.mainImage)){ image in
                        image.resizable().frame(height: UIScreen.main.bounds.height*0.3)
                        
                    }placeholder: {
                        
                        Image("logo_gray").resizable().frame(height: UIScreen.main.bounds.height*0.3)
                    }
                    
                    
                     }
                }

                VStack(alignment: .leading, spacing: 20){
                    Spacer().frame(height: 50)
                    HStack(alignment: .center){
                        Spacer()
                        Text(list.email) .foregroundColor(.orange).font(.system(size: 22, weight: .semibold)).padding(.top)
                        Spacer()
                }
//                    HStack(alignment: .center){
//                        Spacer()
//                        Text(list.full_name) .foregroundColor(.black).font(.system(size: 22, weight: .semibold)).padding(.top)
//                        Spacer()
//                }
                    
                  
//
                    
                    VStack(alignment: .leading, spacing: 11){
                        HStack{
                            Text("**Username**").foregroundColor(.gray).font(.system(size: 22)).frame(width: 125, alignment: .leading)
                            Text(list.username).foregroundColor(colorScheme == .dark ? Color.white :   Color.black).font(.system(size: 18)).frame( alignment: .leading)
                        }
                        HStack{
                            Text("**Mobile**").foregroundColor(.gray).font(.system(size: 22)).frame(width: 125, alignment: .leading)
                            Text(list.mobile).foregroundColor(colorScheme == .dark ? Color.white :   Color.black).font(.system(size: 18)).frame( alignment: .leading)
                        }
                        HStack{
                            Text("**Address**").foregroundColor(.gray).font(.system(size: 22)).frame(width: 125, alignment: .leading)
                            Text(list.address).foregroundColor(colorScheme == .dark ? Color.white :   Color.black).font(.system(size: 18)).frame( alignment: .leading)
                        }
                    }.padding(.bottom).padding(.horizontal,8)
                 
                }.background(colorScheme == .dark ? Color.black :   Color.white).cornerRadius(6).padding(10).shadow(color: .gray.opacity(0.5), radius: 2, y: 2)
                Spacer()
            }
            AsyncImage(url: URL(string: list.logo)){ image in
                image.resizable().frame(width: 130, height: 130).cornerRadius(111).overlay(RoundedRectangle(cornerRadius: 111)
                    .stroke(Color.orange, lineWidth: 2)).padding(.top, -200)
                
            }placeholder: {
                Image("logo_gray").resizable().frame(width: 130, height: 130).cornerRadius(111).overlay(RoundedRectangle(cornerRadius: 111)
                    .stroke(Color.orange, lineWidth: 2)).padding(.top, -200)
            }.onAppear{
                list.getProfileData()
             }
          
            Spacer()
            
        }
        
                   

            }
}

struct GuestProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GuestProfileView()
    }
}



import Foundation

// MARK: - Welcome
public struct UserProfileModel: Decodable {
    public let partnerDetail: PartnerDetailModel

}

public struct PartnerDetailModel: Decodable {
    public let url: String?
    public let banner_url: String?
    public let school_logo: String?
    public let full_name: String?
    public let full_address: String?
    public let role: String?
    public let email: String?
    public let mobile: String?
    public let address_id: Int?
    public let `class`: String?
    public let section: String?
    public let username: String?

}



class UserProfileViewModel: ObservableObject{
  
    @Published var username = String()
    @Published var full_name = String()
    @Published var email = String()
    @Published var `class` = String()
    @Published var section = String()
    @Published var mobile = String()
    @Published var address = String()
    @Published var mainImage = String()
    @Published var logo = String()
    @Published var school_logo = String()
  
    
    func getProfileData() {

        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }

        AuthenticationProfileService().getProfileData(token: token){ (result) in
            switch result {
                case .success(let accounts):
                    DispatchQueue.main.async {
                        self.mobile = accounts.partnerDetail.mobile ?? ""
                        self.class = accounts.partnerDetail.class ?? ""
                        self.section = accounts.partnerDetail.section ?? ""
                        self.username = accounts.partnerDetail.username ?? ""
                        self.address = accounts.partnerDetail.full_address ?? ""
                        self.mainImage = accounts.partnerDetail.banner_url ?? ""
                        self.logo = accounts.partnerDetail.url!
                        self.email = accounts.partnerDetail.email ?? ""
                        self.full_name = accounts.partnerDetail.full_name  ?? ""
                        self.school_logo = accounts.partnerDetail.school_logo  ?? ""
                        print(accounts)

                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }

    }
    
    
}



class AuthenticationProfileService {

   
    
    func getProfileData(token: String, completion: @escaping (Result<UserProfileModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: APILoginUtility.userProfileGuest!) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
//                print("something wrong...")
                return
            }
            
        
            
            
            
            guard let accounts = try? JSONDecoder().decode(UserProfileModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(accounts))
      
            print(accounts)
            
            
        }.resume()

            
        }
    
    
    
    

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

