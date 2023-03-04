//
//  ReadCreditView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 12/12/22.
//

import SwiftUI

struct ReadCreditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var list = RCTransactionViewModel()
    @State var shown = false
    var body: some View {
        NavigationView {
            ZStack {
                Image("u")
                    .resizable()
                ZStack {
                    VStack {
                        HStack(spacing: 25){
                            Button(action: {
                                dismiss()
                                
                            }, label: {
                                Image(systemName: "arrow.backward")
                                    .font(.system(size:22, weight:.bold))
                                    .foregroundColor(.white)
                            })
                            Text("**Read Credit(RC)...**")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(list.totalRC) RC").font(.system(size: 20, weight: .medium)).foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                self.shown = true
                            }, label: {
                                Image(systemName: "plus").font(.system(size: 22, weight: .medium)).foregroundColor(.white)
                            })
                            
                           
                        }.padding().frame(width: UIScreen.main.bounds.width, height: 65).background(Color("orange"))
                        
                        ScrollView{
                            ForEach(list.datas, id: \.id){ item in
                                VStack(alignment: .leading, spacing: 8){
                                    Text(item.createdAt).foregroundColor(.gray)
                                    HStack{
                                        Text(item.description).foregroundColor(.gray)
                                        Spacer()
                                        Text("\(item.rc_count) RC").foregroundColor(.gray)
                                        Image(systemName: "arrow.down").foregroundColor(.green)
                                    }
                                }.padding().background(Color.white).cornerRadius(12).shadow(color: .gray, radius: 0.5)
//                                if list.currentPage < list.totalPage - 1{
//                                    CircleProgressView().frame(alignment: .center).onAppear{
//                                            list.currentPage = list.currentPage + 1
////                                            print("\(list.currentPage)")
//                                        list.getRCTransactionData()
//                                        }
//                                    }
                            }
                            
                        }
                        Spacer()
                    }.onAppear{
                        list.getRCTransactionData()
                    }
                    
                    
                    if shown {
                        BuyReadCreaditAlert(rcShow: $shown)
                    }
                }
            }.navigationBarTitle("")
        }
    }
}

struct ReadCreditView_Previews: PreviewProvider {
    static var previews: some View {
        ReadCreditView()
       
    }
}
struct BuyReadCreaditAlert: View{
    @Binding var rcShow: Bool
    @State private var isLoading = true
    let screenSize = UIScreen.main.bounds
    @State var text: String = ""
    @State var rupee: String = ""
    var body: some View{
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(12)
                Text("Buy Read Credit").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding()
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
           
                VStack {

                    FloatingTextField(placeHolder: "Read Credit (Minimum 300)", text: $text).padding()
                    FloatingTextField(placeHolder: "Total Cost (Rupee)", text: $rupee).padding()
 

                    HStack{
                        Spacer()
                        Button(action: {
                                            self.rcShow = false
                            
                        }){
                            Text("Cancel").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }.padding(12)
                        Button(action: {
                                           
                            
                        }){
                            Text("Buy Now").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(Color("green"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }.padding(23)
                    }
                    
           
               
            }
            
            
        }
            .frame(width: screenSize.width * 0.9, height: .infinity)
                .background(Color.white.opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                        .animation(.spring(), value: rcShow)

        }
       
    }
    }

import Foundation

// MARK: - Welcome
public struct RCTransHistoriesModel:Decodable, Encodable {
    public let rcTransHistories: RCTransHistories
    public let totalRc: RCTransTotalRc
    public let rcSources: [RCTransSource]
   

}

public struct RCTransSource:Decodable, Encodable {
    public let id: Int
    public let source: String
    public let description: String

}

public struct RCTransHistories:Decodable, Encodable {
    public let current_page: Int
    public let data: [RCTransDatum]
    public let first_page_url: String
    public let from: Int
    public let last_page: Int
    public let last_page_url: String
    public let path: String
    public let per_page: Int
    public let total: Int

}

// MARK: - Datum
public struct RCTransDatum :Decodable, Encodable{
    public let id: Int
    public let partner_id: Int
    public let rc_count: Int
//    public let object_type: String
//    public let type: String
//    public let source: String
    public let description: String
    public let book_name: String
    public let book_url: String
    public let rc_url: String
    public let createdAt: String
    public let rcCount: Int?

}

// MARK: - TotalRc
public struct RCTransTotalRc:Decodable, Encodable {
    public let id: Int
    public let total_rc: Int

}


class RCTransactionViewModel: ObservableObject{
   
    @Published var datas = [RCTransDatum]()
   @Published var totalRC = Int()//[RCTransTotalRc]()
    @Published var totalPage = Int()
    @Published var currentPage = 1
    func getRCTransactionData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        RCTransactionService().getRCTransactionData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.datas = results.rcTransHistories.data
                        self.totalRC = results.totalRc.total_rc
                        self.totalPage = results.rcTransHistories.total
//                        self.datas.append(contentsOf: results.rcTransHistories.data)
//                        print(results)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
     
        
    }
      
}



class RCTransactionService{
    
    func getRCTransactionData(token: String, completion: @escaping (Result<RCTransHistoriesModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: APILoginUtility.guestRCtransactionApi!) else {
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
            
            guard let response = try? JSONDecoder().decode(RCTransHistoriesModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
            
            
        }
}


