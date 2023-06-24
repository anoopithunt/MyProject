//
//  IndustryCenterView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 01/12/23.
//

import SwiftUI

struct IndustryCenterView: View {
    @StateObject var list = IndustryCenterViewModel()
    
    @FocusState private var isTextFieldFocused: Bool
    @State  var searchText: String = ""
    
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        NavHeaderClosure(title: "Centres"){
            ZStack{
                Image("u").resizable()
                
                VStack{
                    TextField("Search center..", text: $searchText).font(.title)
                        .padding(4).padding(.trailing,26).foregroundColor(.gray).background(Color.white)
                        .cornerRadius(8).focused($isTextFieldFocused)
                        .showClearButton($searchText)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 0.6)
                        )
                    Spacer()
                    
                    ScrollView(showsIndicators: false){
                        ForEach(list.datas ?? [], id: \.id){ item in
                            VStack(spacing: 12){
                                HStack{
                                    Text("Centre Name")
                                    Spacer()
                                    Text(item.full_name)
                                    Spacer()
                                    Image(systemName: "ellipsis").font(.system(size: 26, weight: .bold)).rotationEffect(Angle(degrees: 90))
                                }
                                .font(.system(size: 24, weight: .bold))
                                HStack{
                                    Text("Email").font(.system(size: 22, weight: .medium))
                                    Spacer()
                                    Text(item.email)
                                    Spacer()
                                }.font(.system(size: 22, weight: .medium))
                                HStack{
                                    Text("Address").font(.system(size: 22, weight: .medium))
                                    Spacer()
                                    Text(item.address ?? "")
                                    Spacer()
                                }.font(.system(size: 22, weight: .medium))
                                Divider()
                                
                                HStack{
                                    Text("Status").font(.system(size: 22, weight: .medium))
                                    Spacer()
                                    Text(item.status)
                                    Spacer()
                                    Button(action: {

                                    }, label: {
                                        Text("View")
                                            .padding(.horizontal)
                                            .padding(6)
                                            .foregroundColor(.white)
                                            .background(Color("default_"))
                                            .cornerRadius(16)
                                    })
                                }.font(.system(size: 22, weight: .medium))
                            }
                            .padding(16)
                            .background(Color.white).cornerRadius(6).padding(9).shadow(radius:1)
                        }
                    }
                }
            }
        }.onAppear{
            list.getCenterData()
        }
    }
}

struct IndustryCenterView_Previews: PreviewProvider {
    static var previews: some View {
        IndustryCenterView()
    }
}

// MARK: IndustryCenterViewModel

class  IndustryCenterViewModel: ObservableObject {
    @Published var datas:[IndustryCenterDatum]?
    
    func getCenterData() {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://alibrary.in/api/industry/ind-center") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: IndustryCenterModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.centers.data
                    print(self.datas  as Any)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}


// MARK: - IndustryCenterModel
public struct IndustryCenterModel:Decodable {
//    public let partner: IndustryCenterPartner
//    public let role: String
    public let centers: IndustryCenters
 
}

// MARK: - IndustryCenters
public struct IndustryCenters: Decodable {
    public let current_page: Int
    public let data: [IndustryCenterDatum]
    public let last_page: Int
 
}

// MARK: - IndustryCenterDatum
public struct IndustryCenterDatum: Decodable {
    public let id: Int
    public let user_id: Int
    public let role_id: Int
    public let first_name: String
    public let full_name: String
    public let dob: String
    public let email: String
    public let address: String?
    public let status: String
    public let user_data: IndustryCenterUserData
    public let address_link: IndustryCenterAddressLink?
 
}

// MARK: - IndustryCenterAddressLink
public struct IndustryCenterAddressLink: Decodable {
    public let id: Int
    public let address: IndustryCenterAddress
 
}

// MARK: - IndustryCenterAddress
public struct IndustryCenterAddress: Decodable {
    public let id: Int
    public let country_id: Int
    public let state_id: Int
    public let city_id: Int
    public let postal_code: Int
    public let full_address: String
    public let email_id: String
 
}

// MARK: - IndustryCenterUserData
public struct IndustryCenterUserData: Decodable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String
 
}

// MARK: - IndustryCenterPartner
public struct IndustryCenterPartner: Decodable {
    public let id: Int
    public let user_id: Int
    public let role_id: Int
    public let school_id: Int
    public let first_name: String
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let partner_role: IndustryCenterPartnerRole

    
}

// MARK: - IndustryCenterPartnerRole
public struct IndustryCenterPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
 
}
