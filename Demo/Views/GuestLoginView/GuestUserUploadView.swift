//
//  GuestUserUploadView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 07/04/23.
//

import SwiftUI

struct GuestUserUploadView: View {
    @StateObject var list = GuestUserUploadViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavHeaderClosure(title: "Public Upload PDFs"){
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(list.datas, id: \.id){ item in
                            
                            
                            
                            VStack(alignment: .leading){
                                AsyncImage(url: URL(string: item.book_media.url)){ img in
                                    img.resizable().frame(height: 235)
                                        .cornerRadius(6)
                                    
                                }placeholder: {
                                    Image("logo_gray").resizable().frame(height: 235).cornerRadius(6)
                                }
                                Text(item.name).foregroundColor(Color("default_")).lineLimit(1)
                                Text("By: \(item.author_name)").foregroundColor(Color("maroon"))
                                Text("Published: \(item.published)").foregroundColor(Color("default_"))
                                Spacer()
                            }.padding(10)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                            
                        }
                        
                    }
                    
                }.refreshable(action: {
                    list.getGuestUserUploadBookData() // Call a function in your view model to refresh the data
                })
            }.onAppear{
                list.getGuestUserUploadBookData()
            }
        }
    }
}

struct GuestUserUploadView_Previews: PreviewProvider {
    static var previews: some View {
        GuestUserUploadView()
    }
}

//MARK:  View Model



class GuestUserUploadViewModel: ObservableObject{
    
    @Published var datas = [GuestUserUploadDatum]()
//    @Published var total = Int()
    @Published var currentPage = 0
    @Published var totalPage = Int()
    @Published var id = Int()
//    var filterData = false
//    var bookType = "all"
    
    func getGuestUserUploadBookData() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationGuestUserUploadService().getUserUploadBookData(token: token, currentPage: currentPage) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.bookDetails.data
                    self.totalPage = results.bookDetails.total
                    
                    
                }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}




class AuthenticationGuestUserUploadService {
    func getUserUploadBookData(token: String,currentPage:Int, completion: @escaping (Result<GuestUserUploadModel, NetworkError>) -> Void) {
        
//
        guard let url = URL(string: "https://alibrary.in/api/guest/user-uploads?page=\(currentPage)") else {
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
            
            guard let response = try? JSONDecoder().decode(GuestUserUploadModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}


// MARK: - GuestUserUploadModel
public struct GuestUserUploadModel:Decodable {
    public let bookDetails: GuestUserUploadBookDetails
//    public let filter_type: String
//    public let partner_detail: GuestUserUploadPartnerDetail
//    public let status: Int

}

// MARK: - GuestUserUploadBookDetails
public struct GuestUserUploadBookDetails:Decodable {
//    public let current_page: Int
    public let data: [GuestUserUploadDatum]
//    public let path: String
    public let total: Int

}

// MARK: - GuestUserUploadDatum
public struct GuestUserUploadDatum:Decodable {
    public let id: Int
    public let name: String
    public let title: String
    public let author_name: String
//    public let isbn_no: String
//    public let validity_date: String
//    public let category_name: String
//    public let subcategory_name: String
    public let published: String
    public let book_media: GuestUserUploadBookMedia
    public let partner_name: GuestUserUploadPartnerName
    public let book_category_link: GuestUserUploadBookCategoryLink
    public let book_partner_link: GuestUserUploadBookPartnerLink

}

// MARK: - GuestUserUploadBookCategoryLink
public struct GuestUserUploadBookCategoryLink:Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let category: GuestUserUploadCategory
    public let sub_category: GuestUserUploadSubCategory

}

// MARK: - GuestUserUploadCategory
public struct GuestUserUploadCategory :Decodable{
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String

}

// MARK: - GuestUserUploadSubCategory
public struct GuestUserUploadSubCategory:Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String

}

// MARK: - GuestUserUploadBookMedia
public struct GuestUserUploadBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String

   
}

// MARK: - GuestUserUploadBookPartnerLink
public struct GuestUserUploadBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int
//    public let book_id: Int
    public let purchase_type: Int
    public let is_active: Int

}

// MARK: - GuestUserUploadPartnerName
public struct GuestUserUploadPartnerName :Decodable{
    public let id: Int
    public let partner_unique_id: String
    public let first_name: String?
    public let last_name: String?
    public let full_name: String?
    public let gender: String?
    public let dob: String?
    public let is_active: Int
    public let is_deleted: Int
    public let created_by: Int

}

// MARK: - GuestUserUploadPartnerDetail
public struct GuestUserUploadPartnerDetail:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let user_id: Int
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
//    public let is_active: Int
    public let is_deleted: Int
    public let partner_role: GuestUserUploadPartnerRole

}

// MARK: - GuestUserUploadPartnerRole
public struct GuestUserUploadPartnerRole :Decodable{
    public let id: Int
    public let name: String
    public let guard_name: String
    
}
