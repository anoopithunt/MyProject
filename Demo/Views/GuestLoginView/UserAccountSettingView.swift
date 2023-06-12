//
//  UserAccountSettingView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 10/01/23.
//

import SwiftUI


import Foundation

// MARK: - Welcome
public struct UserAccountModel:Decodable{
    public let partner_detail: UserAccountPartnerDetail

}

public struct UserAccountPartnerDetail:Decodable {
    public let id: Int
    public let first_name: String?
    public let last_name: String?
    public let full_name: String?
    public let dob: String?
    public let partner_media: [UserAccountPartnerMedia]
    public let address_link: AccountSettingAddressLinkModel
}

// MARK: - PartnerMedia
public struct UserAccountPartnerMedia:Decodable {
    public let id: Int
    public let partnerid: Int?
    public let url: String?
    public let partnerMediatype: String

}


public struct AccountSettingAddressLinkModel:Decodable{
    public let id: Int
    public let address: AccountSettingAddressModel
}

public struct AccountSettingAddressModel:Decodable{
    public let id: Int
    public let email_id: String?
    public let postal_code: Int?
    public let mobile_1: String?
    public let full_address: String?
    public let state_details: StateDetailModel
    public let city_details: CityDetailModel
    public let country_details:CountryDetailModel
    
}
public struct StateDetailModel: Decodable{
    public let id: Int
    public let name: String?
}
public struct CityDetailModel: Decodable{
    public let id: Int
    public let city: String?
}
public struct CountryDetailModel: Decodable{
    public let id: Int
    public let name: String?
    public let code: String?

}



struct UserAccountSettingView: View {
   
    @StateObject var list = UserAccountSettingViewModel()
    var body: some View {
        VStack{
            
            
            Text(list.full_name).foregroundColor(.black)
            Text(list.first_name).foregroundColor(.black)
        }.onAppear{
            list.getAccountData()
        }
    }
}

struct UserAccountSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountSettingView()
    }
}





class UserAccountSettingViewModel: ObservableObject{
  
    @Published var full_name = String()
    @Published var first_name = String()
    @Published var last_name = String()
    @Published var email_id = String()
    @Published var dob = String()
    @Published var postal_code = String()
    @Published var mobile_no = String()
    @Published var full_address = String()
    @Published var city = String()
    @Published var state = String()
    func getAccountData() {

        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }

        AuthenticationAccountSettingService().getAccountData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.full_name = results.partner_detail.full_name ?? ""
                        self.first_name = results.partner_detail.first_name ?? ""
                        self.last_name = results.partner_detail.last_name ?? ""
                        self.email_id = results.partner_detail.address_link.address.email_id ?? ""
                        self.dob = results.partner_detail.dob ?? ""
                        self.postal_code = "\( results.partner_detail.address_link.address.postal_code!)"
                        self.mobile_no = results.partner_detail.address_link.address.mobile_1 ?? ""
                        self.full_address = results.partner_detail.address_link.address.full_address ?? ""
                        self.city = results.partner_detail.address_link.address.city_details.city ?? ""
                        self.state = results.partner_detail.address_link.address.state_details.name ?? ""
                        print(results)

                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }

    }
    
}




class AuthenticationAccountSettingService {

   
    
    func getAccountData(token: String, completion: @escaping (Result<UserAccountModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: APILoginUtility.userAccountSettingAPi!) else {
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
            
            guard let response = try? JSONDecoder().decode(UserAccountModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
            
            
        }.resume()
            
            
        }
    
}





struct FirstView_Previews: PreviewProvider {
    static var previews: some View {

        DateView()
    }
}
