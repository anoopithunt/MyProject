//
//  StudentBookBundleDetailViews.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 23/06/23.
//

import SwiftUI

struct StudentBookBundleDetailViews: View {
    @State var bundle_id: Int
    @State var shown = false
    @State var readingShown = false
    @State var url = String()
    @State var isbn_no = String()
    @State var title = String()
    @State var authorName = String()
    @State var long_desc = String()
    @StateObject var list = StudentBookBundleDetailViewModel()
    var body: some View {
        ZStack{
            NavHeaderClosure(title:"Book Bundle List"){
                ZStack{
                    Image("u")
                        .resizable()
                        .ignoresSafeArea()
                    
                    ScrollView{
                        ForEach(list.datas, id: \.id){ item in
                            LazyVGrid(columns: [GridItem(.fixed(133)), GridItem(.flexible())],alignment: .center,spacing: 4){
                                Button(action: {
                                    self.url = item.book_media.url
                                    self.isbn_no = item.isbn_no
                                    self.title = item.title
                                    self.long_desc = item.long_desc ?? ""
                                    shown = true
                                }, label: {
                                    AsyncImage(url: URL(string: item.book_media.url)){
                                        img in
                                        img.resizable()
                                            .frame(width: 115, height: 145)
                                            .padding(.vertical,6)
                                            .cornerRadius(16)
                                    }
                                placeholder: {
                                    Image("logo_gray")
                                        .resizable()
                                        .frame(width: 115, height: 145)
                                        .padding(.vertical,6)
                                        .cornerRadius(16)
                                }
                                    
                                })
                                
                                VStack(alignment: .leading, spacing: 8){
                                    Text(item.name)
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .bold))
                                        .lineLimit(2)
                                    Text("Pages\(item.tot_pages) \t   Size \(item.size)")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 17))
                                    HStack{
                                        Spacer()
                                        Button(action: {
                                            self.readingShown = true
                                        }, label: {
                                            Text("Read Book")
                                                .foregroundColor(.black)
                                                .font(.system(size: 22,weight: .bold))
                                                .padding(12)
//                                                .strokeRoundedRectangle(8, .cyan, lineWidth: 2)
                                                .padding(6)
                                        })
                                        
                                    }
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 4).padding(6)
                            
                        }
//                        Spacer()
                    }
                }
            }.onAppear{
                list.getBookBundleDetailData(id: bundle_id)
            }
            if shown{
                ShowBooksDetailsPopUpView(bookUrl: url, long_desc: long_desc, title: title, isbn_no: isbn_no, isShown: $shown)
            }
            if readingShown{
                SecurityCheckView(isShowing: $readingShown)
            }
        }
    }
}

struct StudentBookBundleDetailViews_Previews: PreviewProvider {
    static var previews: some View {
        StudentBookBundleDetailViews(bundle_id: 554)
    }
}




class  StudentBookBundleDetailViewModel: ObservableObject {
    @Published var datas  = [BookBundleDetailBook]()
    
    func getBookBundleDetailData(id: Int) {

        let apiurl = "\(APILoginUtility.studentBookbundleDetailApi)\(id)"
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

        service.getLoginData(from: url, model: BookBundleDetailModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.books
                    
                    print(self.datas)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}


 

// MARK: - BookBundleDetailModel
public struct BookBundleDetailModel: Decodable {
//    public let partner: BookBundleDetailPartner
    public let stackDetail: BookBundleStackDetail
    public let books: [BookBundleDetailBook]
    public let totalAvgMRP: Int
    public let totalAvgPrice: Int
    public let pcntg: Int
    public let disclaimer: Disclaimer
     
 
}



// MARK: - BookBundleDetailBook
public struct BookBundleDetailBook: Decodable {
    public let id: Int
    public let name: String
    public let title: String
    public let author_name: String
    public let isbn_no: String
    public let size: String
    public let long_desc: String?
    public let tot_pages: Int
    public let publish_date: String
    public let validity_date: String
    public let book_partner_link: BookBundleDetailPartnerLink
    public let book_media: BookBundleDetailBookMedia
 
}

// MARK: - BookBundleDetailBookMedia
public struct BookBundleDetailBookMedia: Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let url: String

     
}

// MARK: - BookBundleDetailPartnerLink
public struct BookBundleDetailPartnerLink: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
 
}

// MARK: - Disclaimer
public struct Disclaimer: Decodable {
    public let id: Int
    public let device_type_id: Int
    public let title: String
    public let name: String
    public let description: String
    public let created_by: Int
 
}



// MARK: - BookBundleDetailPartner
public struct BookBundleDetailPartner: Decodable {
    public let id: Int
    public let admission_no: String
    public let roll_no: String
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let partner_role: BookBundleDetailPartnerRole
    public let school_class_link: BookBundleDetailSchoolClassLink

     
}

// MARK: - BookBundleDetailPartnerRole
public struct BookBundleDetailPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String

     
}

// MARK: - BookBundleDetailSchoolClassLink
public struct BookBundleDetailSchoolClassLink: Decodable {
    public let id: Int
    public let school_id: Int
    public let class_id: Int
 
}

// MARK: - BookBundleStackDetail
public struct BookBundleStackDetail: Decodable {
    public let id: Int
    public let name: String
    public let description: String
    public let stack_book_links: [BookBundleDetailStackBookLink]
//    public let copyStack: [Any?]
 
}

// MARK: - BookBundleDetailStackBookLink
public struct BookBundleDetailStackBookLink: Decodable {
    public let id: Int
    public let stack_id: Int
    public let book_id: Int
    public let book_media: BookBundleBookMedia
    public let stack_book: BookBundleDetailStackBook

     
}

// MARK: - BookBundleBookMedia
public struct BookBundleBookMedia: Decodable {
    public let id: Int
    public let book_id: Int
    public let url: String
 
}

// MARK: - BookBundleDetailStackBook
public struct BookBundleDetailStackBook:Decodable {
    public let id: Int
    public let name: String
    public let tot_pages: Int
    public let author_name: String?
    public let isbn_no: String?
    public let size: String
    public let tot_likes: String?
    public let validity_date: String?
//    public let book_partner_link: BookBundleDetailPartnerLink

     
}
