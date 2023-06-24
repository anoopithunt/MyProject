//  PublisherBooksEarningView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 26/09/23.
//

import SwiftUI

struct PublisherBooksEarningView: View {
    @StateObject var list = PublisherBooksEarningViewModel()
    
    @Environment(\.dismiss) private var dismiss
      
    @State private var selectedYear = "Year"
    @State private var selectedMonth = "Month"
    
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            VStack{
                HStack(spacing: 22){
                    Button(action: {
                        dismiss()
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 32,weight: .bold))
                    })
                    Text("Book Earnings")
                        .font(.system(size: 32,weight: .bold))
                    Spacer()
                }.padding(.horizontal,6)
                
                
                HStack(spacing: 6){
                    HStack{
                        Image(systemName: "calendar").font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color.gray)
                        
                        Menu {
                            ForEach(list.months.sorted(by: <), id: \.key) { key, value in
                                Button(String(describing:  value)) {
                                    self.selectedMonth = value
                                    list.sel_month = key
                                    list.datas.removeAll()
                                    list.getEarningData(currentPage: list.currentPage)
                                }
                            }
                        } label: {
                            Text(String(describing: selectedMonth))
                                .foregroundColor(.black)
                                .font(.system(size: 18))
                            
                        }
                        .padding(.horizontal).frame(width: UIScreen.main.bounds.width/2.6,height:30).border(.black)
                        
                        //                        Spacer()
                    } .frame(width: UIScreen.main.bounds.width/1.8, height: 35)
                        .onAppear{
//                            self.selectedYear = list.currentyear
                        }
                    
                    
                    HStack{
                        Image(systemName: "calendar").font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Menu {
                            ForEach($list.years.indices, id: \.self) { index in
                                Button(String(describing:  list.years[index])) {
                                    self.selectedYear = "\(list.years[index])"
                                    list.sel_year = "\(list.years[index])"
                                    print(list.sel_year)
                                    list.datas.removeAll()
                                    list.getEarningData(currentPage: list.currentPage)
                                    
                                }
                            }
                        } label: {
                            Text(String(describing: selectedYear))
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                            
                        }
                        .padding(.horizontal)
                        .frame(height: 30)
                        .border(Color.black)
                        
                    }.padding(.horizontal)
                }
                Divider()
                    .frame(height:1)
                    .background(Color.black)
                    .padding(.horizontal,6)
                
                
                
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                        ForEach(list.datas, id: \.id){ item in
                            VStack(alignment: .leading, spacing: 2){
                                AsyncImage(url: URL(string: "\(item.book_url)")){ img in
                                    img
                                        .resizable()
                                        .frame(height: 235)
                                }placeholder: {
                                    Image("logo_gray")
                                        .resizable()
                                        .frame(height:235)
                                }
                                Text("\(item.book_name)")
                                    .lineLimit(1).truncationMode(.tail)
                                    .font(.system(size: 22,weight: .bold))
                                Text("Rc Count: ")
                                    .foregroundColor(Color.brown)
                                    .font(.system(size: 22,weight: .regular))
                                //                                + Text("\(item.t)")
                                //                                    .font(.headline)
                                //                                    .foregroundColor(Color("default_"))
                                
                                Text("Rc Value: ")
                                    .foregroundColor(Color.brown)
                                    .font(.system(size: 22,weight: .regular))
                                
                                //             + Text("\(item.tot_rcvalue) ")
                                //                                    .font(.headline)
                                //                                    .foregroundColor(Color("default_"))
                                
                            }
                            .padding(6)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        
                    }
                    .padding(.leading,4)
                }
                
            }
            
        }
        .onAppear{
           
            list.getEarningData(currentPage: 1)
        }
        
    }
    
}

struct PublisherBooksEarningView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherBooksEarningView()
    }
}
 
// MARK: - PublisherBooksEarningModel
public struct PublisherBooksEarningModel: Decodable{
    public let months: [String: String]
    public let years: [Int]
    public let currentmonth: String
    public let currentyear: String
    public let totalbookcount: Int
    public let totalPublisehrEarned: Double?
    public let booKpaymentDetails: [PublisherBooKpaymentDetail]
    
}

 
//   MARK: - PublisherBooKpaymentDetail
public struct PublisherBooKpaymentDetail:Decodable {
      public let id: Int
      public let payment_header_id: Int
      public let product_id: Int
      public let product_type: String
      public let unit_mrp: Int
      public let quantity: Int
      public let disc_percent: Int
      public let disc_amount: Double
      public let unit_price: Int
      public let book_url: String
      public let book_name: String
      public let pu_price: Double
      public let payment_header: PublisherBookEarningsPaymentHeader
 
}

 

// MARK: - PublisherBookEarningsPaymentHeader
public struct PublisherBookEarningsPaymentHeader: Decodable {
 
       public let id: Int
       public let partner_id: Int
       public let transaction_id: String
       public let total_amount: Int
       public let disc_percent: Int
       public let paytm_bankname: String
       public let paytm_gatewayname: String
       public let paytm_payment_mode: String
       public let paytm_status_respcode: String
       public let paytm_status_money: String
       public let paytm_order_id: String
       public let paytm_txn_date: String
       public let bank_txn_id: String
       public let status: String
 
}

 
// MARK: PublisherBooksEarningViewModel

class  PublisherBooksEarningViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var currentmonth: String = ""
    @Published var currentyear: String = ""
    @Published var years  = [Int]()
    @Published var totalPage: Int = 0
    @Published var sel_month = ""
    @Published var sel_year = ""
    @Published var months: [String: String] = [:]
    @Published var datas = [PublisherBooKpaymentDetail]()
     
    func getEarningData(currentPage: Int) {
        
//                let apiurl = APILoginUtility.publisherMyEarningApi
        guard let url = URL(string: "https://alibrary.in/api/publisher/tot-book-sale?month=\(self.sel_month)&year=\(self.sel_year)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
//        let service = HTTPLoginUtility()
        
        HTTPLoginUtility().getLoginData(from: url, model: PublisherBooksEarningModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
                    self.currentmonth = results.currentmonth
                   self.months = results.months
                    self.currentyear = results.currentyear
                   self.years = results.years
                   
                    
                    if !results.booKpaymentDetails.isEmpty {
                        
                        if self.totalPage == 1{
                            self.datas = results.booKpaymentDetails
 
                        }
                        else{
                            self.datas.append(contentsOf: results.booKpaymentDetails)
                            
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
