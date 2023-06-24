//
//  IndustryDepartmentView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 02/12/23.
//

import SwiftUI

struct IndustryDepartmentView: View {
    
    
    @StateObject var list = IndustryDepartmentCenterViewModel()
    
    var body: some View {
        NavHeaderClosure(title: "Departments"){
            ZStack{
                Image("u").resizable()
                VStack{
                    VStack(alignment: .leading){
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("**Center Name**")
                                Text("**Email**")
                                Text("**Address**")
                                
                            }
                            .font(.system(size: 24))
                            .frame(width: 150)
                            
//                            Second Column
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(list.departments?.full_name ?? "")
                                    .font(.system(size: 22))
                                
                                Text(list.departments?.email ?? "")
                                    .font(.system(size: 22))
                                    .lineLimit(1)
                                
                                Text(list.departments?.address ?? "")
                                    .font(.system(size: 22))
                                    .lineLimit(1)
                            }
                            .frame(width: 150)
//                            Set a fixed width for the second column
                            
                            Spacer()
                        }
                         
                    }.padding(6)
                        .background(Color.white)
                    ScrollView(showsIndicators: false){
                        ForEach(list.datas ?? [], id: \.id){item in
                            VStack(alignment:.leading){
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("**Center Name**")
                                        Text("**Description**")
                                        
                                    }
                                    .font(.system(size: 24))
                                    .frame(width: 150)
                                   
//                                    Second Column
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("\(item.name)").font(.system(size: 22))
                                        Text("\(item.description)").font(.system(size: 22)).lineLimit(1)
                                    }
                                    .frame(width: 150)
//                                    Set a fixed width for the second column
                                    
                                    Spacer()
                                }
                                 
                                Divider()
                                HStack{
                                    Spacer()
                                    Text("**View**")
                                        .font(.system(size: 22))
                                        .padding(.horizontal)
                                        .padding(.vertical, 6)
                                        .background(Color("default_"))
                                        .foregroundColor(.white)
                                        .cornerRadius(14)
                                }.padding(.trailing)
                            }.padding(6)
                                .background(Color.white).cornerRadius(4)
                                .shadow(radius:1)
                        }
                    }
                }
            }.onAppear {
                list.getDepartmentData()
            }
        }.navigationViewStyle(StackNavigationViewStyle()).overlay(alignment: .topTrailing){
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .heavy)).padding()
        }
    }
}

struct IndustryDepartmentView_Previews: PreviewProvider {
    static var previews: some View {
        IndustryDepartmentView()
    }
}
 

class  IndustryDepartmentCenterViewModel: ObservableObject {
    @Published var datas:[IndustryCenterDepartment]?
    @Published var departments:IndustryDepartmentCenter?
    
    func getDepartmentData() {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://www.alibrary.in/api/industry/create-department?center_id=2524") else {
//            handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: IndustryDepartmentModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.center.center_departments
                    self.departments = results.center
                    print(self.datas  as Any)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}


import Foundation
   
// MARK: - IndustryDepartmentModel
public struct IndustryDepartmentModel:Decodable {
//    public let data: Int
    public let center: IndustryDepartmentCenter
    public let partner: IndustryDepartmentPartner
//    public let role: String
 
}

// MARK: - IndustryDepartmentCenter
public struct IndustryDepartmentCenter:Decodable {
    public let id: Int
    public let user_id: Int
    public let role_id: Int
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let email: String
    public let address: String
    public let status: String
    public let center_departments: [IndustryCenterDepartment]
    public let user_data: IndustryDepartmentUserData
    public let address_link: IndustryDepartmentAddressLink
 
}

// MARK: - IndustryDepartmentAddressLink
public struct IndustryDepartmentAddressLink:Decodable {
    public let id: Int
    public let address: IndustryDepartmentAddress
 
}

// MARK: - IndustryDepartmentAddress
public struct IndustryDepartmentAddress:Decodable {
    public let id: Int
    public let addr_type_id: Int
    public let address_line_1: String
    public let full_address: String
    public let email_id: String

     
}

// MARK: - IndustryCenterDepartment
public struct IndustryCenterDepartment:Decodable {
    public let id: Int
    public let center_id: Int
    public let name: String
    public let description: String
 
}

// MARK: - IndustryDepartmentUserData
public struct IndustryDepartmentUserData:Decodable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String
 
}

// MARK: - IndustryDepartmentPartner
public struct IndustryDepartmentPartner :Decodable{
    public let id: Int
    public let partner_unique_id: String
    public let role_id: Int
    public let school_id: Int
    public let first_name: String
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let partner_role: IndustryDepartmentPartnerRole

   
}

// MARK: - IndustryDepartmentPartnerRole
public struct IndustryDepartmentPartnerRole:Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
 
}
