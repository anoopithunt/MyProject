//
//  PublisherRCEarningsView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 18/09/23.
//

import SwiftUI

struct PublisherRCEarningsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var list = PublisherRCEarningsViewModel()
    
    @State private var options = ["Select Month","January", "February", "March", "April", "May", "June", "July", "August", "September","October", "November","December"]
    //    @State private var years = ["Select Year","2020","2021", "2022", "2023", "2024"]
    @State private var selectedYear = 2023
    @State private var selectedMonth = "Select Month"
    var body: some View {
        
        ZStack{
            Image("u")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                HStack(spacing: 22){
                    Button(action: {
                        dismiss()
                        
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 32,weight: .bold))
                    })
                    Text("RC Earnings")
                        .font(.system(size: 32,weight: .bold))
                    Spacer()
                }.padding(.horizontal)
                
                
                HStack(spacing: 6){
                    HStack{
                        Image(systemName: "calendar")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Button(action: {
                            
                        }, label: {
                            Picker("Select Month", selection: $selectedMonth) {
                                
                                ForEach(options, id: \.self){
                                    month in
                                    Text(String(describing: month)).tag(month)
                                        .font(.system(size: 32,weight: .bold))
                                }
                            }
                            .tint(.black)
                            .pickerStyle(.menu)
                            .border(Color.black)
                            
                        })
                    }.frame(width: UIScreen.main.bounds.width/1.8)
                    
                    HStack{
                        Image(systemName: "calendar").font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Menu {
                            ForEach(list.years.indices, id: \.self) { index in
                                Button(String(describing: list.years[index])) {
                                    
                                    self.selectedYear = list.years[index]
                                    list.sel_year = "\(list.years[index])"
                                    print(list.sel_year)
                                    list.datas.removeAll()
                                    list.getRCEarningsData(currentPage: 1)
                                }
                            }
                        } label: {
                            Text(String(describing: selectedYear))
                                .foregroundColor(.black)
                                .font(.system(size: 22))
 
                        }
                        .padding(.horizontal)
                        .border(Color.black)
 
                    }.padding(.horizontal)
                }
                 Divider()
                    .background(Color.black)
                    .padding(.horizontal)
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
                                + Text("\(item.tot_rccount)")
                                    .font(.headline)
                                    .foregroundColor(Color("default_"))
                                
                                Text("Rc Value: ")
                                    .foregroundColor(Color.brown)
                                    .font(.system(size: 22,weight: .regular))
                                
                                + Text("\(item.tot_rcvalue) ")
                                    .font(.headline)
                                    .foregroundColor(Color("default_"))
                                
                            }
                            .padding(6)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius:2)
                        }
                        
                    }
                    .padding(.leading,4)
                    
                }
                Spacer()
                
            }
            
        }.onAppear{
            list.getRCEarningsData(currentPage: 1)
        }
        
    }
    
}

struct PublisherRCEarningsView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherRCEarningsView()
    }
}


//MARK: - PublisherRCEarningAPI: https://alibrary.in/api/publisher/mRC-earned?month=09&year=2023&page=1
 
// MARK: - PublisherRCEarningModel
public struct PublisherRCEarningModel: Decodable {
    public let months: [String: String]
    public let years: [Int]
    public let currentmonth: String
    public let currentyear: String
//    public let totCountRC: Int
//    public let totRCValue: Int
    public let rcbooks: PublisherRCEarningBooks
   
}
 
// MARK: - PublisherRCEarningBooks
public struct PublisherRCEarningBooks:Decodable {
    public let current_page: Int
    public let data: [PublisherRCEarningDatum]
//    public let first_page_url: String
//    public let from: Int
    public let last_page: Int
//    public let to: Int
//    public let total: Int

    
}

// MARK: - PublisherRCEarningDatum
public struct PublisherRCEarningDatum: Decodable {
    public let id: Int
//    public let object_type: String
//    public let object_id: Int
//    public let rc_count: Int
//    public let type: String
//    public let source: String
//    public let description: String
    public let tot_rccount: Int
    public let tot_rcvalue: Int
    public let book_url: String
    public let book_name: String
 
}

 
//MARK: PublisherRCEarningsViewModel
class  PublisherRCEarningsViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var years  = [Int]()
    @Published var totalPage: Int = 0
    @Published var datas = [PublisherRCEarningDatum]()
    @Published var sel_month = ""
    @Published var sel_year = ""
    @Published var months: [String: String] = [:]
    func getRCEarningsData(currentPage: Int) {
        
      let apiurl = APILoginUtility.publisherRCEarningApi + "?month=\(self.sel_month)&year=\(self.sel_year)&page=\(self.currentPage)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
//        let service = HTTPLoginUtility()
 
        HTTPLoginUtility().getLoginData(from: url, model: PublisherRCEarningModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.rcbooks.last_page
                     
                    self.months = results.months
                    
                    self.years = results.years
                    print(self.datas)
                    if !results.rcbooks.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.rcbooks.data
                            
                            print(self.datas.last!)
                        }
                        else{
                            self.datas.append(contentsOf: results.rcbooks.data)
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
