//
//  StudentStoriesView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 22/06/23.
//

import SwiftUI

struct StudentStoriesView: View {
    @StateObject var list = StudentStoriesViewModel()
    var body: some View {
        NavHeaderClosure(title: "Stories"){
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], spacing: 14){
                        ForEach(list.datas, id: \.id){ item in
                            
                            
                            VStack(alignment: .leading,spacing: 0){
                                ZStack{
                                    AsyncImage(url: URL(string: item.storyMedias.first?.url ?? "")){
                                        img in
                                        img.resizable().frame(height: 195)
                                    }placeholder: {
                                        Image("logo_gray").resizable()
                                            .frame(height: 195)
                                    }
                                    LinearGradient(colors: [.clear,.clear, .black.opacity(0.7)],startPoint: .top, endPoint: .bottom).frame(height: 195).padding(0)
                                    VStack(alignment: .leading, spacing: 0){
                                        
                                        Spacer()
                                        Text(item.subcategory_name)
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(0)
                                        Rectangle().fill(Color.red).frame(height:2)
                                        Text(item.name ?? "").font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white).lineLimit(2).padding(0)
                                            .foregroundColor(Color.orange)
                                    }
                                }
                                    HStack{
                                        AsyncImage(url: URL(string: item.createdBy.logo_url)){
                                            img in
                                            img.resizable().frame(width: 45,height: 45, alignment: .center)
                                        }placeholder: {
                                            Image("logo_gray")
                                                .resizable(
                                                ).frame(width: 45,height: 45, alignment: .center)
 
                                        }
                                        VStack(alignment: .leading){
                                            Text(item.createdBy.name)
                                            Text(item.published ?? "")
                                        }
                                        Spacer()
                                    
                                    }.padding(.leading, 4).background(Color.white)
                            }.cornerRadius(12).shadow(radius:2)
                        }
                    }
                }
            }.onAppear{
                list.getStoriesData()
            }
        }
        
    }
}

struct StudentStoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StudentStoriesView()
    }
}
 
class  StudentStoriesViewModel: ObservableObject {
    @Published var datas  = [StudentStoriesDatum]()
//    @Published var bookBundle  = [StudentBookBundleStackBookLink]()
    
    func getStoriesData() {

        let apiurl = "\(APILoginUtility.studentStoriesApi)"
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

        service.getLoginData(from: url, model: StudentStoriesModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.blogs.data
//                    for bundle in self.datas {
//                        self.bookBundle = bundle.stack_book_links
//                    }
                    
                    print(self.datas)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}


 

// MARK: - StudentStoriesModel
public struct StudentStoriesModel: Decodable {
    public let blogs: StudentStoriesBlogs
//    public let partner: StudentStoriesPartner
//    public let data: Int

     
}

// MARK: - StudentStoriesBlogs
public struct StudentStoriesBlogs: Decodable {
    public let current_page: Int
    public let data: [StudentStoriesDatum]
//    public let to: Int
//    public let total: Int
 
}

// MARK: - StudentStoriesDatum
public struct StudentStoriesDatum: Decodable {
    public let id: Int
//    public let book_cat_id: Int
    public let category_name: String?
//    public let book_sub_cat_id: Int?
    public let subcategory_name: String
    public let name: String?
    public let published: String?
     public let storyMedias: [StoriesMedia]
    public let createdBy: StudentStoriesCreatedBy
 
}
// MARK: - StoriesMedia

public struct StoriesMedia: Decodable {
    public let id: Int
    public let url: String
 
}
 
// MARK: - StudentStoriesCreatedBy
public struct StudentStoriesCreatedBy: Decodable {
    public let id: Int
    public let name: String
    public let logo_url: String
    public let banner_url: String
    public let partnerRole: StudentStoriesPartnerRole

    
}

// MARK: - StudentStoriesPartnerRole
public struct StudentStoriesPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String

    
}

// MARK: - StudentStoriesPartner
public struct StudentStoriesPartner: Decodable {
    public let id: Int
    public let admission_no: String
    public let roll_no: String
    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let partner_role: StudentStoriesPartnerRole

    
}
