//
//  StudentBookBundleView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 17/06/23.
//

import SwiftUI

struct StudentBookBundleView: View {
    @StateObject var list = StudentBookBundleViewModel()
    var body: some View{
        
        NavHeaderClosure(title: "Book Bundle List"){
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                        VStack{
                            ForEach(list.datas, id: \.id){ item in
                                NavigationLink(destination: StudentBookBundleDetailViews(bundle_id: item.id)
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)){
                                
                                        ZStack{
                                            ForEach(0..<min(item.stack_book_links.count, 3) , id: \.self){ index in
                                                AsyncImage(url: URL(string: item.stack_book_links[index].book_media.url)){
                                                    img in
                                                    img.resizable()
                                                        .frame(width: 115, height: 145)
                                                        .offset(x: index == 1 ?  20 : index == 2 ? 30 : 0, y: index == 1 ? 12 :  index == 2 ? 22 : 0)
                                                        .shadow(radius: 5)
                                                        .padding(.trailing , index == 1 ? 21 : 22 )
                                                }
                                            placeholder: {
                                                Image("logo_gray")
                                                    .resizable()
                                                    .frame(width: 115, height: 145)
                                                    .offset(x: index == 1 ?  20 : index == 2 ? 30 : 0, y: index == 1 ? 12 :  index == 2 ? 22 : 0)
                                                    .shadow(radius: 5)
                                                    .padding()
                                            }
                                            }
                                        }.frame(maxHeight: 244)
                                            .padding()
                            }
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 2)
                                Text(item.name)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 22, weight: .heavy))
                            }
                            Spacer()
                            
                        }.frame(height: 264)
                            .background(Color.blue.opacity(0.4))
                            .cornerRadius(8)
                            .padding()
                    }
                }
                
            }.onAppear{
                list.getBookBundleData()
            }
        }
    }
}

struct StudentBookBundleView_Previews: PreviewProvider {
    static var previews: some View {
        StudentBookBundleView()
    }
}
 


class  StudentBookBundleViewModel: ObservableObject {
    @Published var datas  = [StudentBookTotalBundle]()
    @Published var bookBundle  = [StudentBookBundleStackBookLink]()
    
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

        service.getLoginData(from: url, model: StudentBookBundleModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.totalBundles
                    for bundle in self.datas {
                        self.bookBundle = bundle.stack_book_links
                    }
                    
                    print(self.bookBundle)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}



 
//MARK: - StudentBookBundleModel
public struct StudentBookBundleModel:Decodable {
    public let totalBundles: [StudentBookTotalBundle]
//    public let partner: StudentBookBundlePartner
 
}

//MARK: - StudentBookBundlePartner
public struct StudentBookBundlePartner: Decodable {
    public let id: Int
//    public let partner_unique_id: String
//    public let partner_library_id: String
//    public let user_id: Int
//    public let admission_no: String
//    public let roll_no: String
//    public let role_id: Int
//    public let school_id: Int
//    public let school_class_link_id: Int
//    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let partner_role: StudentBookBundlePartnerRole
 
}

// MARK: - StudentBookBundlePartnerRole
public struct StudentBookBundlePartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
 
}

// MARK: - StudentBookBundleTotalBundle
public struct StudentBookTotalBundle: Decodable {
    public let id: Int
    public let name: String
//    public let description: String
//    public let prchd_stack_id: Int
//    public let prchd_stack_name: String
//    public let prchd_partner_id: Int
//    public let prchd_partner_name: String
    public let stack_book_links: [StudentBookBundleStackBookLink]
//    public let class_detail: StudentBookBundleClassDetail
//    public let section_detail: String?
//    public let partner_detail: StudentBookBundlePartnerDetail
//    public let partner_stacklink: StudentBookBundlePartnerStacklink
 
}

// MARK: - StudentBookBundleClassDetail
public struct StudentBookBundleClassDetail: Decodable {
    public let id: Int
    public let `class`: String
    public let description: String
 
}

// MARK: - StudentBookBundlePartnerDetail
public struct StudentBookBundlePartnerDetail:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let partner_library_id: String
    public let user_id: Int
    public let admission_no: String
    public let roll_no: String
    public let role_id: Int
    public let school_id: Int
    public let school_class_link_id: Int
    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let referal_code: String

    
}

// MARK: - StudentBookBundlePartnerStacklink
public struct StudentBookBundlePartnerStacklink: Decodable {
    public let id: Int
    public let partner_id: Int
    public let stack_id: Int
 
}

// MARK: - StudentBookBundleStackBookLink
public struct StudentBookBundleStackBookLink: Decodable {
 
    public let id: Int
//    public let stack_id: Int
//    public let stack_book: StudentBookBundleStackBook
    public let book_media: StudentBookBundleStackBookLinkBookMedia
 
}

// MARK: - StudentBookBundleStackBookLinkBookMedia
public struct StudentBookBundleStackBookLinkBookMedia: Decodable, Equatable {
    public let id: Int
//    public let book_media_type_id: Int
//    public let media_type_id: Int
    public let url: String

     
}

// MARK: - StudentBookBundleStackBook
public struct StudentBookBundleStackBook: Decodable {
    public let id: Int
//    public let upload_type_id: Int
    public let name: String
//    public let pdf_url: String
//    public let html_url: String
//    public let tot_pages: Int
    public let title: String
    public let author_name: String
//    public let isbn_no: String
//    public let publish_date: String
//    public let validity_date: String
//    public let pdfcount: Int
//    public let protectedpdf: String
//    public let thumbnail: String
    public let book_partner_link: StudentBookBundleBookPartnerLink
//    public let book_media: StudentBookBundleStackBookBookMedia

     
}

// MARK: - StudentBookBundleStackBookBookMedia
public struct StudentBookBundleStackBookBookMedia: Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let url: String
 
}

// MARK: - BookPartnerLink
public struct StudentBookBundleBookPartnerLink : Decodable{
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let purchase_type: Int
 
}
