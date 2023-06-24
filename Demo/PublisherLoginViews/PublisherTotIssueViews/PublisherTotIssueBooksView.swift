//
//  PublisherTotIssueBooksView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 24/08/23.
//

import SwiftUI

struct PublisherTotIssueBooksView: View {
    
    @StateObject var list = PublisherIssueBookViewModel()
    private var rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        
        NavHeaderClosure(title: "Total Issues"){
            ZStack {
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: rows){
                        ForEach(list.datas, id: \.id){ item in
                            VStack(alignment: .leading, spacing: 1){
                                AsyncImage(url: URL(string: item.url)){
                                    img in
                                    img.resizable()
                                        .frame( height: 235)
                                        .cornerRadius(12)
                                }placeholder: {
                                    Image("logo_gray").resizable()
                                        .frame( height: 235)
                                        .cornerRadius(12)
                                }
                                Text(item.title)
                                    .font(.system(size: 18, weight: .regular))
                                    .lineLimit(1)
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                                    
                                    Text(item.category_name)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.red).lineLimit(1).frame(alignment: .leading)
                                    
                                    Text(item.subcategory_name)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_"))
                                        .lineLimit(1).frame(alignment: .leading)
                                    //
                                    Text("For School")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.brown).lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    Text(item.is_forschool == 1 ? "YES" :  "NO")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_"))
                                    
                                    
                                    Text("Created on:")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.brown).lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    Text(item.publish_date)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_"))
                                        .lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    Text("Verify By:")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.brown).lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    Text(item.approvedBy)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_"))
                                        .lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    
                                }
                                
                                
                                HStack{
                                    
                                    Text("Status:\(item.approvedBy)")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_")).lineLimit(1)
                                    Spacer()
                                    Button(action: {
                                        
                                    }, label: {
                                        Image("delete_gray")
                                            .resizable()
                                            .frame(width: 15, height: 20)
                                    })
                                }.padding(.horizontal,4)
                                
                            }
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12).shadow(radius:8)
                            
                        }
                        
                        if list.currentPage  < list.totalPage {
                            CircularProgressView()
                                .onAppear{
                                    list.currentPage += 1
                                    list.getDashboardData(currentPage: list.currentPage)
                                    
                                }
                            
                        }
                    }
                }
            }
        }.overlay(alignment: .topTrailing){
            Button(action: {
                
            }, label: {
                Image("cloud_screen")
                    .resizable()
                    .frame(width: 35, height: 30)
                    .padding()
            })
        }.onAppear{
            list.getDashboardData(currentPage: list.currentPage)
            
        }
    }
}

struct PublisherTotIssueBooksView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherTotIssueBooksView()
    }
}

// MARK: - PublisherTotIssueBookModel
public struct PublisherTotIssueBookModel: Decodable {
    public let bookDetails: PublisherTotIssueBookDetails
//    public let bookType: String
//    public let search: String
//    public let data: Int

    
}

// MARK: - PublisherTotIssueBookDetails
public struct PublisherTotIssueBookDetails: Decodable {
    public let current_page: Int
    public let data: [PublisherTotIssueBookDatum]
    public let last_page: Int
//    public let lastPageurl: String
//    public let nextPageurl: String
//    public let path: String
//    public let perPage: Int
    public let to: Int?
    public let total: Int

    
}

// MARK: - PublisherTotIssueBookDatum
public struct PublisherTotIssueBookDatum : Decodable{
    public let id: Int
//    public let upload_type_id: Int
//    public let name: String
//    public let pdf_url: String
//    public let tot_pages: Int
    public let title: String
//    public let long_desc: String
//    public let meta_keyword: String
//    public let author_name: String
//    public let isbn_no: String?
//    public let size: String?
//    public let tot_like: Int?
//    public let tot_view: Int?
    public let publish_date: String
//    public let validity_date: String
    
    public let is_forschool: Int
//    public let created_at: String
//    public let partner_id: Int
//    public let categroy_id: Int
    public let category_name: String
    public let sub_category_id: Int
    public let subcategory_name: String
//    public let publisherName: String
    public let approvedBy: String
//    public let published: String
    public let url: String
//    public let book_partner_link: PublisherTotIssueBookPartnerLink
//    public let book_category_link: PublisherTotIssueBookCategoryLink?
//    public let partner_name: PublisherTotIssueBookPartnerName
//    public let approve_status: PublisherTotIssueBookApproveStatus?
//    public let book_media: PublisherTotIssueBookMedia

     
}

// MARK: - PublisherTotIssueBookApproveStatus
public struct PublisherTotIssueBookApproveStatus: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let status: String
    public let reason: String
    public let created_by: Int
    public let approved_by: PublisherTotIssueBookApprovedBy
 
}

// MARK: - PublisherTotIssueBookApprovedBy
public struct PublisherTotIssueBookApprovedBy: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let partner_library_id: String
    public let user_id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let gender: String
    public let referal_code: String

    
}

// MARK: - PublisherTotIssueBookCategoryLink
public struct PublisherTotIssueBookCategoryLink: Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let created_by: Int
    public let category: PublisherTotIssueBookCategory
    public let sub_category: PublisherTotIssueBookSubCategory
 
}

// MARK: - PublisherTotIssueBookCategory
public struct PublisherTotIssueBookCategory: Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String
 
}

// MARK: - PublisherTotIssueBookSubCategory
public struct PublisherTotIssueBookSubCategory: Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String?
 
}

// MARK: - PublisherTotIssueBookMedia
public struct PublisherTotIssueBookMedia: Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let url: String

    
}

// MARK: - PublisherTotIssueBookPartnerLink
public struct PublisherTotIssueBookPartnerLink: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
 
}

// MARK: - PublisherTotIssueBookPartnerName
public struct PublisherTotIssueBookPartnerName: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    
}


//MARK: ViewModel
class  PublisherIssueBookViewModel: ObservableObject {
    @Published var datas = [PublisherTotIssueBookDatum]()
    @Published var currentPage: Int = 1
    @Published var totalPage:Int = 1
    @Published var bookType = "all"
    func getDashboardData(currentPage: Int) {
        
                let apiurl = APILoginUtility.publisherIssueBooksApi
        guard let url = URL(string: "\(apiurl)?book_type=\(self.bookType)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: PublisherTotIssueBookModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.bookDetails.last_page
                    print(results)
                    if !results.bookDetails.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.bookDetails.data
                        }
                        else{
                            self.datas.append(contentsOf: results.bookDetails.data)
                            
                        }
                        
                    }
                    else {
                        print("empty")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
        
    }

}
