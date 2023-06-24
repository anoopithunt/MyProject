//
//  PublisherCreditFundsView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 04/09/23.
//

import SwiftUI
import Charts

struct PublisherCreditFundsView: View {
    @StateObject var list = PublisherCreditFundsViewModel()
    var body: some View {
        NavHeaderClosure(title: "Credit funds") {
            ZStack {
                Image("u").resizable().ignoresSafeArea()
                ScrollView{
                    ForEach(list.datas, id: \.id)  { item in
                        HStack(alignment:.top){
                            VStack(alignment: .leading){
                                AsyncImage(url: URL(string: item.book_url)){
                                    img in
                                    img.resizable().frame(width: 95, height: 125).cornerRadius(8)
                                }placeholder: {
                                    Image("logo_gray")
                                        .resizable()
                                        .frame(width: 95, height: 125)
                                        .cornerRadius(8)
                                    
                                }
                                
                                HStack(spacing: 15){
                                    Image(systemName: "eye.fill")
                                        .resizable()
                                        .foregroundColor(Color("default_"))
                                        .frame(width: 32, height: 22)
                                    
                                    
                                    switch item.book_views {
                                    case .integer(let views):
                                        Text("\(views)")
                                            .foregroundColor(Color("default_"))
                                            .font(.system(size: 18,weight: .bold))
                                    case .string(let views):
                                        Text("\(views)")
                                            .foregroundColor(Color("default_"))
                                            .font(.system(size: 18,weight: .bold))
                                        
                                    }
                                    
                                }//.padding(.horizontal).frame(width:115)
                            }
                            VStack(alignment:.leading){
                                ScrollView(.horizontal, showsIndicators: false){
                                    if #available(iOS 16.0, *) {
                                        Chart(data) {
                                            BarMark(x:.value("Department", $0.department),y: .value("Profit", $0.profit))
                                            //.foregroundStyle(by: .value("Department", $0.department))
                                            
                                        }.chartPlotStyle{ plotArea in plotArea
                                                .background(.gray.opacity(0.7))
                                        }
                                        .padding(.top)
                                        .frame(width:170, height: 125)
                                        
                                        //                                            ForEach(item.totalrccount.indices, id: \.self) { index in
                                        //                                                BarMark(x: .value("Department", item.months[index]),
                                        //                                                        y: .value("Profit", item.totalrccount[index])
                                        //                                                )
                                        //                                            }
                                        
                                    }
                                    else {
                                        //                     Fallback on earlier versions
                                        
                                    }
                                }
                                Text(item.book_name).font(.system(size: 20, weight: .regular)).lineLimit(1)
                                
                            }.foregroundColor(Color("default_"))
                                .font(.system(size: 22, weight: .bold))
                            
                            Text("\(item.totrccount ?? "") RC")
                                .font(.system(size: 22, weight: .medium))
                            
                        }.padding(8)
                            .background(Color.white)
                            .cornerRadius(12).shadow(radius:8)
                            .padding(.horizontal)
                    }.padding(.top)
                    
                }
            }
        }.overlay(alignment: .topTrailing){
            Text("\(list.totCountRC) RC")
                .foregroundColor(.white).font(.system(size: 18,weight: .bold)).padding([.top, .trailing])
        }.onAppear{
            list.getCreditFundsData(currentPage: 1)
        }
    }
}

struct PublisherCreditFundsView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherCreditFundsView()
    }
}

struct Profit: Identifiable {
     let department: String
     let profit: Double
     var id: String { department }
}
let data: [Profit] = [
    Profit(department: "Production", profit: 15000),
    Profit(department: "Marketing", profit: 8000),
    Profit(department: "Finance", profit: 10000)
]

// MARK: - CreditFundsModel
public struct CreditFundsModel: Decodable {
    public let rcbooks: CreditFundsRcbooks
    public let totCountRC: Int
//    public let search: String
//    public let partner: CreditFundsPartner
//    public let data: Int
 
}

// MARK: - CreditFundsPartner
public struct CreditFundsPartner: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let full_name: String
    public let dob: String
    public let partner_role: CreditFundsPartnerRole
    public let partner_plan: CreditFundsPartnerPlan
 
}

// MARK: - CreditFundsPartnerPlan
public struct CreditFundsPartnerPlan: Decodable {
    public let id: Int
    public let partner_id: Int
    public let header_id: Int
    public let item_id: Int
    public let header_name: String
    public let header_code: String
    public let item_name: String
    public let item_code: String
    public let header_price: Int
    public let item_price: Int
    public let value: Int
    public let start_date: String
    public let end_date: String
 
}

// MARK: - CreditFundsPartnerRole
public struct CreditFundsPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
    public let created_by: Int
 
}

// MARK: - CreditFundsRcbooks
public struct CreditFundsRcbooks: Decodable {
    public let current_page: Int
    public let data: [CreditFundsDatum]
//    public let first_page_url: String
//    public let from: Int
    public let last_page: Int
//    public let to: Int
//    public let total: Int

     
}

// MARK: - CreditFundsDatum
public struct CreditFundsDatum: Decodable {
    public let id: Int
//    public let partner_id: Int
//    public let object_type_id: Int
//    public let object_type: String
//    public let object_id: Int
    public let rc_count: Int
//    public let type: String
//    public let source: String
//    public let description: String
//    public let created_by: Int
    public let book_name: String
    public let book_url: String
    public let book_views: CreditFundsBookViews
//    public let createdAt: String
    public let totalrccount: [CreditFundsTotalrccount]
    public let months: [String]
    public let totrccount: String?

     
}

public enum CreditFundsTotalrccount: Decodable  {
    
    case integer(Int)
    case string(String)
    
    // -- here
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(CreditFundsTotalrccount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Plan"))
    }
     
}
 

public enum CreditFundsBookViews: Decodable {
    case integer(Int)
    case string(String)
    
    // -- here
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(CreditFundsBookViews.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Plan"))
    }
    
}


//MARK: ViewModel
class  PublisherCreditFundsViewModel: ObservableObject {
    @Published var datas = [CreditFundsDatum]()
    @Published var currentPage: Int = 1
    @Published var totalPage:Int = 1
    @Published var totCountRC: Int = 0
    func getCreditFundsData(currentPage: Int) {
        
//                let apiurl = APILoginUtility.publisherIssueBooksApi
        guard let url = URL(string: "https://www.alibrary.in/api/credit-funds?page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: CreditFundsModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.rcbooks.last_page
                    self.totCountRC = results.totCountRC
                   
                    print(results.rcbooks.data.endIndex)
                    if !results.rcbooks.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.rcbooks.data
 
                        }
                        else{
                            self.datas.append(contentsOf: results.rcbooks.data)
                            
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
