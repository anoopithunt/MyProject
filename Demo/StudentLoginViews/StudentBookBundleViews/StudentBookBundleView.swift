//
//  StudentBookBundleView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 17/06/23.
//

import SwiftUI

struct StudentBookBundleView: View {
    
    @StateObject var list = StudentBookBundleViewModel()
    var body: some View {
        NavHeaderClosure(title: "Book Bundle List"){
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
                                Text(item.full_name).foregroundColor(.white).font(.system(size: 22, weight: .bold))
                                Spacer()
                            }
                            .padding()
                            .frame(width: UIScreen.main.width * 0.9)
                            .background(Color(hex: colorlist[index % colorlist.count]))
                            .cornerRadius(49)
                        }
                    }
                }
            }
        }
      .onAppear{
            list.getBookBundleData()
        }
    }
}

struct StudentBookBundleView_Previews: PreviewProvider {
    static var previews: some View {
        StudentBookBundleView()
    }
}
 
 

import Foundation

// MARK: - BookBundleModel
public struct BookBundleModel:Decodable {
    public let partners: [BookBundlePartner]
    public let colorlists:  [String: String]//BookBundleColorlists
 
 
}

 

// MARK: - BookBundlePartner
public struct BookBundlePartner:Decodable {
    public let id: Int
    public let role_id: Int
    public let school_id: Int
    public let full_name: String
    public let full_address: String
    public let email: String
    public let subjectDetails: [BookBundleSubjectDetail]
    public let profile_url: String

    
}

// MARK: - BookBundleSubjectDetail
public struct BookBundleSubjectDetail: Decodable {
    public let id: Int
    public let subject_id: Int
    public let subject_name: String

     
}


//MARK: ViewModel

class  StudentBookBundleViewModel: ObservableObject {
    @Published var datas  = [BookBundlePartner]()
    @Published var colorlists: [String: String] = [:]
    
    func getBookBundleData() {

        let apiurl = "\(APILoginUtility.studentBookbundleApi)"
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

        service.getLoginData(from: url, model: BookBundleModel.self, token: token){ (result) in
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
 
