//
//  StudentUserUploadView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 14/06/23.
//

import SwiftUI

struct StudentUserUploadView: View {
    @StateObject var list = StudentUserUploadViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavHeaderClosure(title: "Public Upload PDFs"){
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        
                        ForEach(list.datas, id: \.id){ item in
                            
                            
                            
                            VStack(alignment: .leading){
                                AsyncImage(url: URL(string: item.book_detail.book_media.url)){ img in
                                    img.resizable().frame(height: 235)
                                        .cornerRadius(6)
                                    
                                }placeholder: {
                                    Image("logo_gray").resizable().frame(height: 235).cornerRadius(6)
                                }
                                Text(item.book_detail.name).foregroundColor(Color("default_")).lineLimit(1)
                                Text("By: \(item.book_detail.author_name)").foregroundColor(Color("maroon"))
                                Text("Published: \(item.book_detail.published)").foregroundColor(Color("default_"))
                                Spacer()
                            }.padding(10)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                            
                        }
                        
                    }
                    
                }.refreshable(action: {
//                    list.getUserUploadData()
                    // Call a function in your view model to refresh the data
                })
            }.onAppear{
                  list.getUserUploadData()
            }
        }
    }
}

struct StudentUserUploadView_Previews: PreviewProvider {
    static var previews: some View {
        StudentUserUploadView()
    }
}


//MARK: SchoolLibraryViewModel



class  StudentUserUploadViewModel: ObservableObject {
    @Published var datas  = [StudentUserUploadDatum]()

    func getUserUploadData() {

        let apiurl = "\(APILoginUtility.studentUploadApi)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: StudentUserUploadModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.book_details.data
                    print(results)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 
// MARK: - StudentUserUploadModel
public struct StudentUserUploadModel: Decodable {
    public let book_details: StudentUserUploadBookDetails
//    public let partner_id: Int
//    public let user_type: String
//    public let status: Int

    
}
 
// MARK: - StudentUserUploadBookDetails
public struct StudentUserUploadBookDetails: Decodable {
//    public let current_page: Int
    public let data: [StudentUserUploadDatum]
//    public let last_page: Int
//    public let to: Int
//    public let total: Int

    
}

// MARK: - StudentUserUploadDatum
public struct StudentUserUploadDatum: Decodable {
    public let id: Int
//    public let partner_id: Int
//    public let book_id: Int
//    public let purchase_type: Int
//    public let is_active: Int
    public let book_detail: StudentUserUploadBookDetail

     
}

// MARK: - StudentUserUploadBookDetail
public struct StudentUserUploadBookDetail: Decodable {
    public let id: Int
//    public let upload_type_id: Int
    public let name: String
//    public let pdf_url: String
//    public let html_url: String
//    public let tot_pages: Int
//    public let title: String
    public let author_name: String
//    public let isbn_no: String
//    public let size: String
//    public let tot_likes: String
//    public let tot_view: Int
//    public let publish_date: String
//    public let validity_date: String
    public let published: String
//    public let book_category_link: StudentUserUploadBookCategoryLink
    public let book_media: StudentUserUploadBookMedia

   
                       
}

// MARK: - StudentUserUploadBookCategoryLink
public struct StudentUserUploadBookCategoryLink: Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let category: StudentUserUploadCategory

     
                       
}

// MARK: - StudentUserUploadCategory
public struct StudentUserUploadCategory: Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String

     
}

// MARK: - StudentUserUploadBookMedia
public struct StudentUserUploadBookMedia: Decodable {
    public let id: Int
//    public let book_media_type_id: Int
//    public let media_type_id: Int
//    public let book_id: Int
    public let url: String
}

 
 
