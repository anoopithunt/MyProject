//
//  ReadCreditView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 12/12/22.
//

import SwiftUI

struct ReadCreditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var list = RCTransactionViewModel()
    
    @State private var selectedButtonIndex = 0
    
    @State var source = ""
    @State var name = ""
    @State var type = ""
    @State var book = ""
    @State var startDate = ""
    @State var endDate = ""
    
    @State var shown = false
    @State var isBuy = false
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
                        HStack{
                            Button(action: {
                                self.selectedButtonIndex = 0
                                list.getRCTransactionData(source: source)
                            }, label: {
                                Text("All").padding(.horizontal)
                                    .padding(.vertical, 4)
                                    .background(Color("default_"))
                                    .cornerRadius(18)
                                    .foregroundColor(selectedButtonIndex == 0 ? Color.orange : Color.white)
                                
                                    .font(.system(size: 22, weight: .regular))
                            })
                            
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(list.rcSources.indices, id: \.self) { index in
                                        
                                        Button(action: {
                                            self.selectedButtonIndex = index + 1
                                            list.getRCTransactionData(source: list.rcSources[selectedButtonIndex-1].source)
                                        }, label: {
                                            
                                            Text(list.rcSources[index].description)
                                                .padding(.horizontal)
                                                .padding(.vertical, 4)
                                                .background(Color("default_"))
                                                .cornerRadius(18)
                                                .foregroundColor(selectedButtonIndex == index + 1 ? Color.orange : Color.white)
                                                .font(.system(size: 22, weight: .regular))
                                            
                                        })
                                        
                                    }
                                }
                            }
                        }
                        
                        ScrollView{
                            ForEach(list.datas, id: \.id){ item in
                                Button(action: {
                                    isBuy = true
                                    name = item.book_name
                                    if item.description == "Book Purchase"{
                                        book = item.book_url
                                    }
                                    else {
                                        book = item.rc_url
                                        
                                    }
                                    type = item.description
                                    startDate = item.createdAt
                                    endDate = item.rc_enddate
                                }, label: {
                                    VStack(alignment: .leading, spacing: 8){
                                        
                                        Text(item.createdAt).foregroundColor(.gray)
                                        HStack{
                                            Text(item.description).foregroundColor(.gray)
                                            Spacer()
                                            Text("\(item.rc_count) RC").foregroundColor(.gray)
                                            Image(systemName: item.description == "Book Purchase" ? "arrow.up" : "arrow.down").foregroundColor(item.description == "Book Purchase" ? .red : .green)
                                        }
                                    }.padding()
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .shadow(color: .gray, radius: 0.5)
                                    
                                })
                                
                                
                                
                            }
                            
                            if list.currentPage  < list.totalPage {
                                
                                GeometryReader { proxy in
                                    
                                    Color.clear
                                        .frame(height: 100)
                                    
                                        .onAppear {
                                            
                                            let yOffset = proxy.frame(in: .global).maxY
                                            
                                            let contentHeight = UIScreen.main.bounds.height
                                            
                                            let height = UIScreen.main.bounds.height
                                            
                                            let threshold = contentHeight - height
                                            
                                            if yOffset > threshold {
                                                
                                                list.loadNextPage(source: source)
                                            }
                                        }
                                }
                            }
                        }
                        Spacer()
                    }.onAppear{
                        list.getRCTransactionData(source: source)
                    }
                    
                    if shown {
                        BuyReadCreaditAlert(rcShow: $shown)
                    }
                    else if isBuy {
                        BuyPurchaseAlert(isBuy: $isBuy, name: name, book: book, type: type,startDate: startDate, endDate: endDate)
                    }
                }
            }.navigationBarTitle("")
        }
    }
}

struct ReadCreditView_Previews: PreviewProvider {
    static var previews: some View {
        ReadCreditView()
//        BuyPurchaseAlert()
       
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

                    FloatingTextField(placeHolder: "Read Credit (Minimum 300)", text: $text).keyboardType(.numberPad).padding()
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

struct BuyPurchaseAlert: View{
    @Binding var isBuy:Bool
    @State var name: String// = "Parenting with Presence Practices"
    @State var book: String// = "Parenting with Presence Practices"
    @State var type: String //= "Book Purchase"
    @State  var read: String = "1"
    
    @State  var startDate: String //= "12-05-2023 05:16:56"
    @State  var endDate: String //= "11-06-2023 00:00:00"
   
    var body: some View{
        ZStack{
            Color.black.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 24){
                
                    AsyncImage(url: URL(string: book)){
                        img in
                        img.resizable()
                            .frame(width: 255, height: 255)
                            .padding()
                    }placeholder: {
                        Image("logo_gray")
                            .resizable()
                            .frame(width: 235, height: 255)
                            .padding()
                    }
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 20) {
                    if type == "Book Purchase" {
                        Text("Name")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                        Text(name)
                            .foregroundColor(.gray)
                            .font(.system(size: 18)).lineLimit(2)
                    }
                    Text("Type")
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    Text(type)
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                    Text("Read")
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    HStack{
                        Text(read)
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        Image(systemName: type == "Book Purchase" ? "arrow.up" : "arrow.down").font(.system(size: 18, weight: .heavy))
                            .foregroundColor(type == "Book Purchase" ? .red : .green)
                    }
                    Text("Read Start Date")
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    Text(startDate)
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    if type == "Book Purchase"{
                        Text("Read End Date")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                        Text(endDate)
                            .foregroundColor(.orange)
                            .font(.system(size: 16))
                    }
                }.padding(8)
                HStack(spacing: 12){
                    Spacer()
                    Button(action: {
                        self.isBuy = false
                    }, label: {
                        Text("OKay")
                            .padding(.horizontal, 25)
                            .padding(.vertical, 8)
                            .background(Color("default_"))
                            .cornerRadius(25)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                    
                    })
                  
                }.padding(.horizontal)
                    .padding()
            }.background(Color.white)
                .cornerRadius(4)
                .shadow(radius: 2)
                .padding()
        }
    }
}
 
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
    public let total: Int

}

// MARK: - Datum
public struct RCTransDatum :Decodable, Encodable{
    public let id: Int
    public let partner_id: Int
    public let rc_count: Int
    public let object_type: String
    public let type: String
//    public let source: String
    public let description: String
    public let book_name: String
    public let book_url: String
    public let rc_url: String
    public let rc_enddate: String
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
       @Published var rcSources = [RCTransSource]()
       @Published var totalRC = Int()
       @Published var totalPage = Int()
       @Published var currentPage = 0
//    var filterData = false
//    var bookType = ""
    
    func getRCTransactionData(source: String, page: Int = 1) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        RCTransactionService().getRCTransactionData(token: token, source: source, page: page){ (result) in
            
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    if page == 1 {
                        self.datas = results.rcTransHistories.data
                        self.rcSources = results.rcSources
                        print(self.datas)
                    } else {
                        self.datas.append(contentsOf: results.rcTransHistories.data)
                        
                    }
                                
                    self.totalRC = results.totalRc.total_rc
                                   
                    self.totalPage = results.rcTransHistories.total
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                        }
                    }
            
        }
  
    func loadNextPage(source: String) {
            guard currentPage < totalPage else { return }
            currentPage += 1
            getRCTransactionData(source: source, page: currentPage)
        }
     
        
    }
      




class RCTransactionService{
    
    // https://alibrary.in/api/guest/rc-history?source=plan-purchase&page=
    func getRCTransactionData(token: String,source: String,page: Int, completion: @escaping (Result<RCTransHistoriesModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: APILoginUtility.guestRCtransactionApi! + "?source=\(source)&page=" ) else {
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


