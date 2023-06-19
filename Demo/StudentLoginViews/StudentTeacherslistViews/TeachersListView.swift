//
//  TeachersListView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 19/06/23.
//

import SwiftUI

struct TeachersListView: View {
    @StateObject var list = StudentTeachersListViewModel()
    var body: some View {
        NavHeaderClosure(title: "Teacher List"){
            ZStack{
                Image("u").resizable().scaledToFill()
                
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    ForEach(Array(list.datas.enumerated()), id: \.1.id){(index, item) in
                        HStack{
                            AsyncImage(url: URL(string: item.profile_url)){
                                img in img.resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(65)
                                    .padding(6)
                                    .overlay(RoundedRectangle(cornerRadius: 75)
                                        .stroke(Color.white, lineWidth: 4))
                            } placeholder: {
                                Image("soft")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(65)
                                    .padding(6)
                                    .overlay(RoundedRectangle(cornerRadius: 75)
                                        .stroke(Color.white, lineWidth: 4))
                            }
                            VStack(alignment: .leading){
                                Text(item.full_name).foregroundColor(.white).font(.system(size: 22, weight: .bold))
                                Text(item.role_id.description).foregroundColor(.white).font(.system(size: 18, weight: .medium))
                            }
                                Spacer()
                            }.padding(.vertical, 8)
                                .padding(.leading,12)
                            .frame(width: UIScreen.main.width * 0.98)
                            .background(Color(hex: colorlist[index % colorlist.count]))
                            .cornerRadius(49)
                        }
                    }
                }
            }
        }
      .onAppear{
            list.getTeachersListData()
        }
    }
}

struct TeachersListView_Previews: PreviewProvider {
    static var previews: some View {
        TeachersListView()
    }
}



import Foundation

// MARK: - TeachersListModel
public struct TeachersListModel:Decodable {
    public let partners: [TeachersListPartner]
    public let colorlists:  [String: String]//BookBundleColorlists
 
 
}

 

// MARK: - TeachersListPartner
public struct TeachersListPartner:Decodable {
    public let id: Int
    public let role_id: Int
    public let school_id: Int
    public let full_name: String
    public let full_address: String
    public let email: String
    public let subjectDetails: [TeachersListSubjectDetail]
    public let profile_url: String

    
}

// MARK: - TeachersListSubjectDetail
public struct TeachersListSubjectDetail: Decodable {
    public let id: Int
    public let subject_id: Int
    public let subject_name: String

     
}


//MARK: ViewModel

class  StudentTeachersListViewModel: ObservableObject {
    @Published var datas  = [TeachersListPartner]()
    @Published var colorlists: [String: String] = [:]
    
    func getTeachersListData() {

        let apiurl = "\(APILoginUtility.studentTeachersListApi)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: TeachersListModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.partners
                    self.colorlists = results.colorlists
                    print(results)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 

