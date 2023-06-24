//
//  PublisherTotalBooksUploadView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 08/09/23.
//

import SwiftUI

struct PublisherTotalBooksUploadView: View {
    @State var fdate = Date()
    @State var fdate1:Date?

    @State private var tdate = Date()
    @State  var currentPage:Int = 1
    @StateObject var list = PublisherTotalUploadBookViewModel()
    @Environment(\.dismiss) private var dismiss 
    var body: some View {
        
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            VStack{
                HStack(spacing: 12){
                    Button(action: {
                        dismiss()
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .resizable().foregroundColor(.black)
                            .frame(width: 20, height: 28)
                    })
                    Text("Monthly Total Books Upload")
                        .font(.system(size: 24, weight: .medium))
                    
                    Spacer()
                }.padding(.horizontal)
                
                
                HStack{
                    DatePicker("From Date", selection: $fdate,displayedComponents: [.date])
                    //                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .foregroundColor(.black)
                        .onChange(of: fdate) {newDate in
                            list.fromDate = "\(DateFormatter.displayDate.string(from: fdate))"
                            list.currentPage = 1
                            list.datas.removeAll()
                            list.getTotalBookUploadData(currentPage: 1)
                            print("\(DateFormatter.displayDate.string(from: fdate))" )
                        }
                    
                    Spacer()
                    
                    DatePicker("To Date", selection: $tdate,displayedComponents: [.date]).datePickerStyle(.compact)
//                        .labelsHidden()
                        .foregroundColor(.black)
                        .onChange(of: tdate) {newDate in
                            list.toDate = "\(DateFormatter.displayDate.string(from: tdate))"
                            list.currentPage = 1
                            list.datas.removeAll()
                            list.getTotalBookUploadData(currentPage: 1)
                            print("\(DateFormatter.displayDate.string(from: fdate))" )
                        }
                    
                    
                }.padding(2)
                
                
                Divider()
                    .frame(height:1)
                    .background(Color.gray)
                    .padding(.horizontal,4)
                Spacer()
                
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                        
                        ForEach(list.datas,id: \.id){ item in
                            VStack(spacing: 4){
                                AsyncImage(url: URL(string: item.url ?? "")){
                                    img in
                                    img.resizable().frame(width: 175,height:195)
                                }placeholder: {
                                    Image("logo_gray")
                                        .resizable()
                                        .frame(width: 175,height:175)
                                }
                                Divider().foregroundColor(Color.red)
                                VStack(alignment:.leading){
                                    Text(item.name).lineLimit(1)
                                    HStack{
                                        Text("\(item.category_name)")
                                        Spacer()
                                        Text("\(item.subcategory_name)")
                                        
                                    }
                                    HStack{
                                        Text("Published: ")
                                            .foregroundColor(.brown)
                                            .lineLimit(1)
                                        Spacer()
                                        Text("\(item.published ?? "")")
                                    }
                                }
                            }.padding(6).background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius:2).padding(6)
                        }
                        //                        if self.currentPage <= list.totalPage {
                        //                            CircularProgressBar().frame(35).onAppear{
                        //
                        //                            }
                        //                        }
                        
                        if list.currentPage < list.totalPage {
                            CircularProgressBar()
                                .frame(width:35, height: 35)
                                .onAppear {
                                    list.currentPage += 1
                                    list.getTotalBookUploadData(currentPage: list.currentPage)
                                }
                        }
                    }
                }
            }
        }.onAppear{
            list.getTotalBookUploadData(currentPage: 1)
            
        }
    }
}

extension DateFormatter {
    static let displayDate: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "dd-MM-yyyy"
         return formatter
    }()
}

struct PublisherTotalBooksUploadView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherTotalBooksUploadView()
    }
}






 
// MARK: - PublisherTotalBooksUpload
public struct PublisherTotalBooksUploadModel: Decodable {
    public let role_name: String
    public let books: PublisherTotalUploadBooks
    public let fromDate: String
    public let toDate: String
    public let type: String
//    public let data: Int

     
}

// MARK: - Books
public struct PublisherTotalUploadBooks : Decodable{
    public let current_page: Int
    public let data: [PublisherTotalBooksUploadDatum]
//    public let first_page_url: String
//    public let from: Int
    public let last_page: Int
//    public let last_page_url: String
//    public let next_page_url: String
//    public let path: String
//    public let per_page: Int
    public let total: Int
 
}

// MARK: - PublisherTotalBooksUploadDatum
public struct PublisherTotalBooksUploadDatum : Decodable{
    public let id: Int
    public let upload_type_id: Int
    public let name: String
//    public let pdf_url: String
//    public let html_url: String
//    public let tot_pages: Int
//    public let title: String
//    public let author_name: String
//    public let isbn_no: String?
//    public let publish_date: String
//    public let is_publish: Int
//    public let is_free: Int
//    public let is_active: Int
//    public let is_forschool: Int
//    public let is_industry: Int
//    public let age_from: String?
//    public let validity_date: String
//    public let has_media: String?
//    public let partner_id: Int
//    public let categroy_id: Int
    public let category_name: String
//    public let sub_category_id: Int
    public let subcategory_name: String
//    public let publisherName: String
//    public let approvedBy: String
    public let published: String?
//    public let createdAt: String
    public let url: String?
//    public let book_media: PublisherTotalUploadBookMedia
//    public let book_category_link: PublisherTotalUploadBookCategoryLink
//    public let book_partner_link: PublisherTotalUploadBookPartnerLink
//    public let partner_name: PublisherTotalBooksUploadPartnerName
//    public let approve_status: PublisherTotalBooksUploadApproveStatus
//
}

// MARK: - PublisherTotalBooksUploadApproveStatus
public struct PublisherTotalBooksUploadApproveStatus: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let status: String
    public let reason: String
    public let approved_by: PublisherTotalBooksUploadApprovedBy
 
}

// MARK: - PublisherTotalBooksUploadApprovedBy
public struct PublisherTotalBooksUploadApprovedBy: Decodable {
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

// MARK: - BookCategoryLink
public struct PublisherTotalUploadBookCategoryLink: Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let category: PublisherTotalBooksUploadCategory
    public let sub_category: PublisherTotalBooksUploadSubCategory

    
}

// MARK: - PublisherTotalBooksUploadCategory
public struct PublisherTotalBooksUploadCategory : Decodable{
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String

     
}

// MARK: - PublisherTotalBooksUploadSubCategory
public struct PublisherTotalBooksUploadSubCategory : Decodable{
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String

    
}

// MARK: - PublisherTotalBooksUploadBookMedia
public struct PublisherTotalUploadBookMedia : Decodable{
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String

    
}

// MARK: - PublisherTotalUploadBookPartnerLink
public struct PublisherTotalUploadBookPartnerLink : Decodable{
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let purchase_type: Int
    public let is_active: Int

   
}

// MARK: - PublisherTotalBooksUploadPartnerName
public struct PublisherTotalBooksUploadPartnerName: Decodable {
    public let id: Int
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
 
}


//MARK: PublisherTotalUploadBookViewModel
class  PublisherTotalUploadBookViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var fromDate: String = ""
    @Published var toDate: String =  ""
    @Published var totalPage: Int = 0
    @Published var datas = [PublisherTotalBooksUploadDatum]()
    
    func getTotalBookUploadData(currentPage: Int) {
        
              //  let apiurl = APILoginUtility.publisherMyEarningApi
        guard let url = URL(string: "https://www.alibrary.in/api/publisher/tot-book-upload?from_date=\(self.fromDate)&to_date=\(self.toDate)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: PublisherTotalBooksUploadModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
//                    self.datas = results.books.data
                    self.totalPage = results.books.last_page
                    
                    if !results.books.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.books.data
                        }
                        else{
                            self.datas.append(contentsOf: results.books.data)
                           print(self.currentPage)

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




struct DatePickerNullable: View {
    
    let label:String
    @Binding var date:Date?
    @State private var hidenDate:Date = Date()
    
    init(_ label:String, selection:Binding<Date?>){
        self.label = label
        self._date = selection
    }
    
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack{
                DatePicker(label, selection: $hidenDate, displayedComponents: .date)
                if date == nil{
                    Text(label)
                        .italic()
                        .foregroundColor(.gray)
                        .frame(width: proxy.size.width - CGFloat(label.count * 8), alignment: .trailing)
                        .background(Color.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .allowsHitTesting(false)
                }
            }.onChange(of: hidenDate, perform: { _ in
                self.date = hidenDate
            })
        }
    }
}
