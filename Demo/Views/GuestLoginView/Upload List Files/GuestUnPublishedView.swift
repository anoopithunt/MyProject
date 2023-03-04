//
//  GuestUnPublishedView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 02/03/23.
//

import SwiftUI

struct GuestUnPublishedView: View {
    @StateObject var list = GuestUnPublishedViewModel()
    let options = ["All","Unapproved", "Disapproved", "Rejected"]
    @Environment(\.dismiss) var dismiss
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    @State  var searchText: String = ""
    
    @State var value = ""
    var placeholder = "All"
    
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            
            VStack(spacing: 2){
                HStack(spacing: 25){
                    Button(action: {
                        dismiss()
                    },
                           label: {
                        
                        Image(systemName: "arrow.backward")
                            .font(.system(size:22, weight:.heavy))
                            .foregroundColor(.white)
                    })
                    Text("Unpublished Books").lineLimit(1)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    Menu {
                        ForEach(options, id: \.self){ client in
                            Button(client) {
                                self.value = client
                                if self.value == "All"{
                                    list.getUnPublishedListData(publish: 4)
                                }
                                else if self.value == "Unapproved" {
                                    list.getUnPublishedListData(publish: 1)
                                    
                                }
                                else if self.value == "Disapproved" {
                                    list.getUnPublishedListData(publish: 2)
                                }
                                else if self.value == "Rejected" {
                                    list.getUnPublishedListData(publish: 3)
                                }
                                
                            }
                        }
                    } label: {
                            HStack(spacing: 5){
                                Text(value.isEmpty ? placeholder : value).onAppear{
                                    
                                }
                                    .foregroundColor(value.isEmpty ? .white : .white)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color.white)
                                    .font(Font.system(size: 20, weight: .semibold))
                            }
                        
                    }
                     
                }.padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 65)
                    .background(Color("orange"))
                TextField("Search books..", text: $searchText)
                    .padding(8)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 0.6)
                    )
                ScrollView{
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach((list.datas) , id: \.id){item in
                                VStack(alignment: .leading){
                                AsyncImage(url: URL(string: item.url)){ img in
                                    img
                                        .resizable()
                                        .frame(height: 235)
                                    
                                }placeholder: {
                                    Image("logo_gray").resizable()
                                        .frame(height: 235)
                                }
                                    Divider()
                                    Text(item.title).font(.system(size: 12, weight: .light)).foregroundColor(Color("default_")).padding(.leading,4)
                                
                                HStack{
                                    Text("status:\(item.approve_status.status)").font(.system(size: 12, weight: .light)).foregroundColor(.red).padding(.horizontal,6)
                                    Spacer()
                                    Image("delete_gray").resizable().frame(width: 15, height: 18)
                                }.padding(.horizontal,2).padding(.bottom,4)
                                
                                
                                
                                }.padding(2).background(Color.white).cornerRadius(8).shadow(radius: 2)
                                
                        }
                    }
               
                }
            }.onAppear{
                list.getUnPublishedListData(publish: 4)
            }
        }
    }
}

struct GuestUnPublishedView_Previews: PreviewProvider {
    static var previews: some View {
        GuestUnPublishedView()
    }
}


// MARK: - Authentication

class GuestUnPublishedListService{
    
    func getUnPublishedListData(token: String,publish: Int, completion: @escaping (Result<UnPublishedListModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(APILoginUtility.guestUnPublishedApi)\(publish)") else {
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
            
            guard let response = try? JSONDecoder().decode(UnPublishedListModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
}




//MARK: View model

class GuestUnPublishedViewModel: ObservableObject{
    
   @State var publish = 1
    @Published var datas:[UnPublishedListDatum] = [] //()
   
    func getUnPublishedListData(publish: Int) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestUnPublishedListService().getUnPublishedListData(token: token, publish: publish){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                            self.datas = results.bookDetails.data
                    print(self.datas)

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



//MARK: Model


// MARK: - UnPublishedListModel
public struct UnPublishedListModel:Decodable {
    public let bookDetails: UnPublishedListBookDetails
//    public let is_publish: String
//    public let data: Int

}

// MARK: - BookDetails
public struct UnPublishedListBookDetails:Decodable {
//    public let current_page: Int
    public let data: [UnPublishedListDatum]
//    public let to: Int
    public let total: Int

}

// MARK: - Datum
public struct UnPublishedListDatum:Decodable {
    public let id: Int
    public let title: String
    public let url: String
    public let approve_status: UnPublishedListApproveStatus

   
}

// MARK: - ApproveStatus
public struct UnPublishedListApproveStatus:Decodable {
    public let id: Int
//    public let partner_id: Int
//    public let book_id: Int
    public let status: String
    public let reason: String
//    public let approved_by: DeleteListApprovedBy

}

// MARK: - ApprovedBy
public struct UnPublishedListApprovedBy:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let partner_library_id: String
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let gender: String
    public let referal_code: String

}

// MARK: - ApprovedPartner
public struct UnPublishedListApprovedPartner:Decodable {
    public let id: Int
    public let book_id: Int
    public let approved_partner_id: Int
    public let created_by: Int
    public let created_at: String
    public let updated_at: String
    public let approved_by: UnPublishedListApprovedBy

}

// MARK: - BookCategoryLink
public struct UnPublishedListBookCategoryLink:Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let created_by: Int
    public let category: UnPublishedListCategory
    public let sub_category: UnPublishedListSubCategory

}

// MARK: - Category
public struct UnPublishedListCategory:Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String

}

// MARK: - SubCategory
public struct UnPublishedListSubCategory:Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String

}

// MARK: - BookMedia
public struct UnPublishedListBookMedia:Decodable {
    public let id: Int
    public let url: String

}

// MARK: - BookPartnerLink
public struct UnPublishedListBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let purchase_type: Int
    public let is_active: Int
    public let created_by: Int

 
}

// MARK: - PartnerName
public struct UnPublishedListPartnerName:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let user_id: Int
    public let role_id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let gender: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String

}
