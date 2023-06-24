//
//  PublisherMonthlyMagazineUploadView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 08/10/23.
//

import SwiftUI


struct PublisherMonthlyMagazineUploadView: View {
    @StateObject var list = PublisherMonthlyMagazineUploadViewModel()
    @State var fdate = Date()
    @State private var tdate = Date()
    @State  var currentPage:Int = 1
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
                        .onChange(of: fdate) { _ in
                            list.fromDate = "\(DateFormatter.displayDate.string(from: fdate))"
                            list.currentPage = 1
                            list.datas.removeAll()
                            list.getMonthlyMagazineUploadData(currentPage: 1)
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
                            list.getMonthlyMagazineUploadData(currentPage: 1)
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
                                AsyncImage(url: URL(string: item.url)){
                                    img in
                                    img.resizable().frame(width:175, height:195)
                                }placeholder: {
                                    Image("logo_gray")
                                        .resizable()
                                        .frame(width:175, height:175)
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
                                        Text("\(item.published )")
                                    }
                                }
                            }.padding(6).background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius:2).padding(6)
                        }
                        
                        
                        if list.currentPage < list.totalPage {
                            CircularProgressBar()
                                .frame(width: 35, height: 35)
                                .onAppear {
                                    
                                    list.currentPage += 1
                         list.getMonthlyMagazineUploadData(currentPage: list.currentPage)
                                    
                                }
                            
                        }
                        
                    }
                    
                }
                
            }
        }.onAppear{
            
            list.getMonthlyMagazineUploadData(currentPage: 1)
            
        }
    }
}

struct PublisherMonthlyMagazineUploadView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherMonthlyMagazineUploadView()
    }
}

   


import Foundation

// MARK: - PublisherMonthlyMagazineModel
public struct PublisherMonthlyMagazineUploadModel:Decodable {
//    public let role_name: String
    public let books: PublisherMonthlyMagazineUploadBooks
    public let fromDate: String
    public let toDate: String
    public let type: String
    public let data: Int

    
}

// MARK: - PublisherMonthlyMagazineBooks
public struct PublisherMonthlyMagazineUploadBooks: Decodable {
    public let current_page: Int
    public let data: [PublisherMonthlyMagazineUploadDatum]
//    public let from: Int
    public let last_page: Int

     
}

// MARK: - PublisherMonthlyMagazineDatum
public struct PublisherMonthlyMagazineUploadDatum:Decodable {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let tot_pages: Int
    public let title: String
    public let author_name: String
    public let isbn_no: String
    public let is_deleted: Int
    public let validity_date: String
    public let categroy_id: Int
    public let category_name: String
    public let sub_category_id: Int
    public let subcategory_name: String
    public let publisherName: String
    public let approvedBy: String
    public let published: String
    public let createdAt: String
    public let url: String
    public let book_partner_link: PublisherMonthlyMagazineUploadBookPartnerLink
    public let book_category_link: PublisherMonthlyMagazineUploadBookCategoryLink
    public let partner_name: PublisherMonthlyMagazineUploadPartnerName
    public let approve_status: PublisherMonthlyMagazineUploadApproveStatus
    public let book_media: PublisherMonthlyMagazineUploadBookMedia
 
    
}

// MARK: - PublisherMonthlyMagazineApproveStatus
public struct PublisherMonthlyMagazineUploadApproveStatus: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let status: String
    public let reason: String
    public let created_by: Int
    public let approved_by: PublisherMonthlyMagazineUploadApprovedBy
 
}

// MARK: - PublisherMonthlyMagazineApprovedBy
public struct PublisherMonthlyMagazineUploadApprovedBy: Decodable {
    public let id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let gender: String
    public let referal_code: String
 
}

// MARK: - PublisherMonthlyMagazineBookCategoryLink
public struct PublisherMonthlyMagazineUploadBookCategoryLink: Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let category: PublisherMonthlyMagazineUploadCategory
    public let sub_category: PublisherMonthlyMagazineUploadSubCategory

   
}

// MARK: - PublisherMonthlyMagazineUploadCategory
public struct PublisherMonthlyMagazineUploadCategory: Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String
 
}

// MARK: - PublisherMonthlyMagazineUploadSubCategory
public struct PublisherMonthlyMagazineUploadSubCategory: Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
 
}

// MARK: - PublisherMonthlyMagazineBookMedia
public struct PublisherMonthlyMagazineUploadBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let url: String

     
}

// MARK: - PublisherMonthlyMagazineBookPartnerLink
public struct PublisherMonthlyMagazineUploadBookPartnerLink: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let purchase_type: Int

    
}

// MARK: - PublisherMonthlyMagazinePartnerName
public struct PublisherMonthlyMagazineUploadPartnerName: Decodable {
    public let id: Int
    public let full_name: String
    public let dob: String
    public let referal_code: String

     
}



//MARK: PublisherMonthlyMagazineUploadViewModel
class  PublisherMonthlyMagazineUploadViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var fromDate: String = ""
    @Published var toDate: String =  ""
    @Published var totalPage: Int = 0
    @Published var datas = [PublisherMonthlyMagazineUploadDatum]()
    
    func getMonthlyMagazineUploadData(currentPage: Int) {
        
          let apiurl = APILoginUtility.publisherMonthlyMagazineUploadApi
        
        
        guard let url = URL(string: apiurl + "?from_date=\(self.fromDate)&to_date=\(self.toDate)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: PublisherMonthlyMagazineUploadModel.self, token: token){ (result) in
            switch result {
                
            case .success(let results):
                DispatchQueue.main.async {
                    //                    self.datas = results.books.data
                    self.totalPage = results.books.last_page
                    
                    if !results.books.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.books.data
                            print(self.datas.first?.validity_date ?? "HDFC")
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
