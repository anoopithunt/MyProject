//
//  GuestDeleteListView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 01/03/23.
//

import SwiftUI

struct GuestDeleteListView: View {
//    @StateObject var list = GuestDeleteViewModel()
    @StateObject var list = GuestUnPublishedViewModel()
    
    @Environment(\.dismiss) var dismiss
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
       
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            
            VStack{
                //                HStack(spacing: 25){
                //                    Button(action: {
                //                        dismiss()
                //                    },
                //                           label: {
                //
                //                        Image(systemName: "arrow.backward")
                //                            .font(.system(size:22, weight:.heavy))
                //                            .foregroundColor(.white)
                //                    })
                //                    Text("Deleted Books")
                //                        .font(.system(size: 22, weight: .medium))
                //                        .foregroundColor(.white)
                //                    Spacer()
                //
                //
                //                }.padding(.horizontal)
                //                    .frame(width: UIScreen.main.bounds.width, height: 65)
                //                    .background(Color("orange"))
                
                
                
                NavHeaderClosure(title: "Deleted Books"){
                   
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(list.datas, id: \.id){item in
                            
                            VStack(alignment: .leading){
                                AsyncImage(url: URL(string: item.url)){ img in
                                    img
                                        .resizable()
                                        .frame(height: 235)
                                    
                                }placeholder: {
                                    Image("logo_gray").resizable()
                                        .frame(height: 235)
                                }
                                //                                Rectangle().frame(height: 0.4).foregroundColor(Color.gray)
                                Divider().frame(height: 0.2).foregroundColor(Color.red)
                                
                                Text(item.title)
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color("default_"))
                                    .padding(.leading,8)
                                Text("status:\(item.approve_status.status)").font(.system(size: 10, weight: .light))
                                    .foregroundColor(.red)
                                    .padding(.leading,8)
                                
                            }.padding(.bottom,4).background(Color.white).cornerRadius(8).shadow(radius: 1)
                        }
                    }
                }
            }
            }.onAppear{
//                list.getDeleteListData()
                list.getUnPublishedListData(publish: 4)
            }
        }
    }
}

struct GuestDeleteListView_Previews: PreviewProvider {
    static var previews: some View {
        GuestDeleteListView()
    }
}

//// MARK: - Welcome
//public struct DeleteListModel:Decodable {
//    public let bookDetails: DeleteListBookDetails
////    public let is_publish: String
////    public let data: Int
//
//}
////
//// MARK: - BookDetails
//public struct DeleteListBookDetails:Decodable {
//    public let current_page: Int
//    public let data: [DeleteListDatum]
//    public let to: Int
//    public let total: Int
//
//}
////
//// MARK: - Datum
//public struct DeleteListDatum:Decodable {
//    public let id: Int
//    public let name: String
//    public let tot_pages: Int
//    public let title: String
//    public let long_desc: String
//    public let meta_keyword: String
//    public let author_name: String
//    public let isbn_no: String
//    public let size: String
//    public let publish_date: String
//    public let book_key: String
//    public let validity_date: String
//    public let category_name: String
//    public let subcategory_name: String
//    public let publisherName: String
//    public let approvedBy: String
//    public let published: String
//    public let createdAt: String
//    public let url: String
//    public let book_media: DeleteListBookMedia
//    public let approve_status: DeleteListApproveStatus
//
//
//}
////
//// MARK: - ApproveStatus
//public struct DeleteListApproveStatus:Decodable {
//    public let id: Int
//    public let partner_id: Int
//    public let book_id: Int
//    public let status: String
//    public let reason: String
//    public let approved_by: DeleteListApprovedBy
//
//}
////
//// MARK: - ApprovedBy
//public struct DeleteListApprovedBy:Decodable {
//    public let id: Int
//    public let partner_unique_id: String
//    public let partner_library_id: String
//    public let first_name: String
//    public let last_name: String
//    public let full_name: String
//    public let gender: String
//    public let referal_code: String
//
//}
////
//// MARK: - ApprovedPartner
//public struct DeleteListApprovedPartner:Decodable {
//    public let id: Int
//    public let book_id: Int
//    public let approved_partner_id: Int
//    public let created_by: Int
//    public let created_at: String
//    public let updated_at: String
//    public let approved_by: DeleteListApprovedBy
//
//}
////
////// MARK: - BookCategoryLink
//public struct DeleteListBookCategoryLink:Decodable {
//    public let id: Int
//    public let book_id: Int
//    public let category_id: Int
//    public let sub_category_id: Int
//    public let created_by: Int
//    public let category: DeleteListCategory
//    public let sub_category: DeleteListSubCategory
//
//}
////
////// MARK: - Category
//public struct DeleteListCategory:Decodable {
//    public let id: Int
//    public let parent_cat_id: Int
//    public let category_name: String
//    public let description: String
//    public let desc_by: String
//    public let url: String
//    public let banner: String
//
//}
////
////// MARK: - SubCategory
//public struct DeleteListSubCategory:Decodable {
//    public let id: Int
//    public let parent_cat_id: Int
//    public let category_name: String
//    public let description: String
//
//}
////
////// MARK: - BookMedia
//public struct DeleteListBookMedia:Decodable {
//    public let id: Int
//    public let url: String
//
//}
////
////// MARK: - BookPartnerLink
//public struct DeleteListBookPartnerLink:Decodable {
//    public let id: Int
//    public let partner_id: Int
//    public let book_id: Int
//    public let purchase_type: Int
//    public let is_active: Int
//    public let created_by: Int
//
//
//}
////
////// MARK: - PartnerName
//public struct DeleteListPartnerName:Decodable {
//    public let id: Int
//    public let partner_unique_id: String
//    public let user_id: Int
//    public let role_id: Int
//    public let first_name: String
//    public let last_name: String
//    public let full_name: String
//    public let gender: String
//    public let dob: String
//    public let qr_code_url: String
//    public let referal_code: String
//
//}
////
////
////
////
//// MARK: - Authentication
////
//class GuestDeleteListService{
//
//    func getDeleteListData(token: String, completion: @escaping (Result<DeleteListModel, NetworkError>) -> Void) {
//
//        guard let url = URL(string: APILoginUtility.guestUploadListDeleteApi!) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                completion(.failure(.noData))
//                return
//            }
//
//            guard let response = try? JSONDecoder().decode(DeleteListModel.self, from: data) else {
//                completion(.failure(.decodingError))
//                return
//            }
//
//            completion(.success(response))
//
//        }.resume()
//
//
//    }
//}
////
////
////
////
////View model
////
//class GuestDeleteViewModel: ObservableObject{
//
//
//    @Published var datas = [DeleteListDatum]()
//
//    func getDeleteListData() {
//
//        let defaults = UserDefaults.standard
//        guard let token = defaults.string(forKey: "access_token") else {
//            return
//        }
//
//        GuestDeleteListService().getDeleteListData(token: token){ (result) in
//            switch result {
//            case .success(let results):
//                DispatchQueue.main.async {
//                    self.datas = results.bookDetails.data
//                    print(results)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
