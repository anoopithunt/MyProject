//
//  PaymentHistoryView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 14/02/23.
//

import SwiftUI

struct PaymentHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var list = PaymentHistoryViewModel()
    var body: some View {
        
        ZStack{
            Image("u").resizable()
               .ignoresSafeArea()
            VStack{
                HStack(spacing: 25){
                    Button(action: {
                        dismiss()
                    },
                           label: {
                        
                        Image(systemName: "arrow.backward")
                        
                            .font(.system(size:22, weight:.heavy))
                        
                            .foregroundColor(.white)
                    })
                    Text("Payment History")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    
                }.padding(9)
                  .frame(width: UIScreen.main.bounds.width, height: 65)
                    .background(Color("orange"))
                
                ScrollView{
                    ForEach(list.datas, id: \.id){ item in
                        ZStack{

                            Color("graylight")
                            
                            HStack{
                                if item.product_type == "plan" {
                                    Image("prime_ring")
                                        .resizable()
                                        .frame(width: 45, height: 45, alignment: .leading)
                                    
                                } else if item.product_type == "read-credit" {
                                    Image("rc_ring")
                                        .resizable()
                                        .frame(width: 45, height: 45, alignment: .leading)
                                    
                                }
                                else {
                                    AsyncImage(url: URL(string: item.book_url)){
                                        image in
                                        image.resizable()
                                            .frame(width: 50, height: 45, alignment: .leading)
                                    }placeholder: {
                                        
                                            
                                        Image("logo_gray")
                                            .resizable()
                                            .frame(width: 50, height: 45, alignment: .leading)
                                    }
                                }
                          VStack(alignment: .leading){
                              Text(item.product_name ?? "")
                                  .font(.system(size: 16, weight: .medium))
                                  .foregroundColor(.black).lineLimit(2)
                              Text(item.createdAt ?? "")
                                        .font(.system(size: 14, weight: .light))
                                        .foregroundColor(.gray)
                                    Text("Order ID:\(item.id)")
                                        .font(.system(size: 14, weight: .light))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                VStack{
                                    Text("₹\(Int(item.paid_amount ?? 0))")
                                        .font(.system(size: 20, weight: .light))
                                        .foregroundColor(.gray)
                                    Spacer()
                                    if item.status == "TXN_SUCCESS" {
                                        Text("success").foregroundColor(Color("green")).font(.system(size: 12, weight: .light))
                                    } else {
                                        Text("Failed").foregroundColor(.red).font(.system(size: 12, weight: .light))
                                    }
                                    
                                }.padding(.vertical)
                            }.padding(.horizontal,6)
                        }.cornerRadius(10)
                            .frame(width: UIScreen.main.bounds.width - 10, height: 90, alignment: .leading)
                            .shadow(color: .black.opacity(0.4), radius: 0.5)
                    }
                }.refreshable {
                    list.getPaymentHistoryData()                }
//                Spacer()
            }.onAppear{
                list.getPaymentHistoryData()
            }
        }
       
    }
}

struct PaymentHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentHistoryView()
    }
}
//Model Creating

import Foundation

// MARK: - Welcome
public struct PaymentHistoryModel:Decodable {
    public let samestate: String
    public let paymentHeaders: PaymentHeaders

}

// MARK: - PaymentHeaders
public struct PaymentHeaders:Decodable {
    public let current_page: Int
    public let data: [PaymentHistoryDatum]
    public let total: Int
}

// MARK: - Datum
public struct PaymentHistoryDatum:Decodable {
    public let id: Int
//    public let total_amount: Int?
//    public let disc_percent: Int?
    public let disc_amount: Double?
    public let sgst: Int?
    public let cgst: Int?
    public let ugst: Int?
    public let paid_amount: Double?
    public let status: String?
    public let product_type: String?
    public let product_name: String?
    public let book_url: String
    public let createdAt: String?
    public let payment_item: PurplePaymentItem
    public let payment_items: [PaymentItemElement]


}

// MARK: - PurplePaymentItem
public struct PurplePaymentItem:Decodable {
    public let id: Int
    public let payment_header_id: Int
    public let product_id: Int
    public let product_type: String?

}
//
// MARK: - PaymentItemElement
public struct PaymentItemElement:Decodable {
    public let id: Int
    public let product_type: String?
//    public let product_detail: PaymentProductDetail
    public let productItems: String?
}
//
// MARK: - ProductDetail
public struct PaymentProductDetail:Decodable {
    public let id: Int
    public let name: String?
    public let book_url: String?

}

// Authenticatication class
class PaymentHistoryService{
    
    func getPaymentHistoryData(token: String, completion: @escaping (Result<PaymentHistoryModel, NetworkError>) -> Void) {
//        https://www.alibrary.in/api/student/payment-history?&page=1
        guard let url = URL(string: APILoginUtility.studentPaymentHistoryApi!) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(PaymentHistoryModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
    
}


//View model

class PaymentHistoryViewModel: ObservableObject{
   
    @Published var datas = [PaymentHistoryDatum]()
    @Published var totalPage = Int()
//    @Published var currentPage = 1
    func getPaymentHistoryData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        PaymentHistoryService().getPaymentHistoryData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.datas = results.paymentHeaders.data
                        self.totalPage = results.paymentHeaders.total
                        //self.datas.append(contentsOf: results.paymentHeaders.data)
                      
                        print(self.datas)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}

