//
//  PublisherMonthlyBooksReadView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 09/10/23.
//

import SwiftUI

struct PublisherMonthlyBooksReadView: View {
    @StateObject var list = PublisherMonthlyBooksReadViewModel()
    @State var fdate = Date()
    @State private var tdate = Date()
    @State  var currentPage:Int = 1
    @Environment(\.dismiss) private var dismiss
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter
    }()
    
    let displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
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
                    Text("Monthly Total Books Read")
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
                            list.getMonthlyBooksReadData(currentPage: 1)
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
                            list.getMonthlyBooksReadData(currentPage: 1)
                            print("\(DateFormatter.displayDate.string(from: fdate))" )
                        }
                    
                }.padding(2)
                
                Divider()
                    .frame(height:1)
                    .background(Color.gray)
                    .padding(.horizontal,4)
                Spacer()
                
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())],spacing: 2){
                        
                        ForEach(list.datas,id: \.id){ item in
                            VStack(spacing: 4){
                                AsyncImage(url: URL(string: item.book_url)){
                                    img in
                                    img.resizable().frame(width:175,height: 195)
                                }placeholder: {
                                    Image("logo_gray")
                                        .resizable()
                                        .frame(width:175, height: 175)
                                }
                                Divider().foregroundColor(Color.red)
                                VStack(alignment:.leading){
                                    Text(item.book_detail.name ?? "").lineLimit(1)
                                    HStack{
                                        Text("Published: ")
                                            .font(.system(size: 13))
                                            .foregroundColor(.brown)
                                            .lineLimit(1)
                                       
                                        if let publishDate = dateFormatter.date(from: item.book_detail.publish_date) {
                                            Text(displayFormatter.string(from: publishDate))
                                                .font(.system(size: 13))
                                                .lineLimit(1)
                                            Spacer()
                                        }
                                    }
                                    
                                }
                            }.padding(6).background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius:2).padding(6)
                        }
                        
                        if list.currentPage < list.totalPage {
                            CircularProgressBar()
                                .frame(width:35, height: 35)
                                .onAppear {
                                    list.currentPage += 1
                                    list.getMonthlyBooksReadData(currentPage: list.currentPage)
                                    
                                }
                        }
                    }
                }
            }
        }
        .onAppear{
            list.getMonthlyBooksReadData(currentPage: 1)
            
        }
        
    }
    
}
  
struct PublisherMonthlyBooksReadView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherMonthlyBooksReadView()
    }
}
 
// MARK: - PublisherMonthlyBooksReadModel
public struct PublisherMonthlyBooksReadModel:Decodable {
    public let role_name: String
    public let bookreads: PublisherMonthlyBooksRead
    public let fromDate: String
    public let toDate: String
    public let data: Int

 
}

// MARK: - PublisherMonthlyBooksRead
public struct PublisherMonthlyBooksRead:Decodable {
    public let current_page: Int
    public let data: [PublisherMonthlyBooksReadDatum]
    public let last_page: Int
//    public let total: Int

   
}

// MARK: - PublisherMonthlyBooksReadDatum
public struct PublisherMonthlyBooksReadDatum: Decodable {
    public let id: Int
    public let book_id: Int
    public let from_time: String?
    public let book_url: String
    public let book_detail: PublisherMonthlyBooksReadDetail

   
}

// MARK: - PublisherMonthlyBooksReadDetail
public struct PublisherMonthlyBooksReadDetail:Decodable {
    public let id: Int
//    public let upload_type_id: Int
    public let name: String?
    public let pdf_url: String
    public let html_url: String
    public let tot_pages: Int
    public let title: String
    public let size: String
    public let publish_date: String
    public let validity_date: String
    public let book_media: PublisherMonthlyReadBookMedia
    public let book_partner_link: PublisherMonthlyBooksReadPartnerLink
 
}

// MARK: - PublisherMonthlyReadBookMedia
public struct PublisherMonthlyReadBookMedia:Decodable {
    public let id: Int
    public let book_id: Int
    public let url: String

    
}

// MARK: - PublisherMonthlyBooksReadPartnerLink
public struct PublisherMonthlyBooksReadPartnerLink:Decodable {
    public let id: Int
    public let is_active: Int
 
}


//MARK: PublisherMonthlyMagazineUploadViewModel
class  PublisherMonthlyBooksReadViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var fromDate: String = ""
    @Published var toDate: String =  ""
    @Published var totalPage: Int = 0
    @Published var datas = [PublisherMonthlyBooksReadDatum]()
    
    func getMonthlyBooksReadData(currentPage: Int) {
        
          let apiurl = APILoginUtility.publisherMonthlyBooksReadApi
        
        
        guard let url = URL(string:  apiurl + "?from_date=\(self.fromDate)&to_date=\(self.toDate)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: PublisherMonthlyBooksReadModel.self, token: token){ (result) in
            switch result {
                
            case .success(let results):
                DispatchQueue.main.async {
                    //                    self.datas = results.books.data
                    self.totalPage = results.bookreads.last_page
                    
                    if !results.bookreads.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.bookreads.data
                            print(self.datas.first?.book_detail as Any)
                        }
                        else{
                            self.datas.append(contentsOf: results.bookreads.data)
                            
                            print(self.datas.first)
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
