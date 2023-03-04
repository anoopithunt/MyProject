//
//  BookRequestView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 23/02/23.
//

import SwiftUI

struct BookRequestView: View {
    
    @StateObject var list = GuestBookRequestViewModel()
    @State private var selectedOption = 0
      let options = ["All", "self", "Others"]
    @State var value = ""
    var placeholder = "All"
    @State  var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        ZStack{
            Image("u").resizable().ignoresSafeArea()
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
                    Text("Book Requests")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                   
                    
                    Spacer()
                    //Drop Down List Design Start
                    Menu {
                        ForEach(options, id: \.self){ client in
                            Button(client) {
                                self.value = client
                                if self.value == "All"{
                                    list.getBookRequestData(request: 0)
                                }
                                else if self.value == "self" {
                                    list.getBookRequestData(request: 1)
                                }
                                else if self.value == "Others" {
                                    list.getBookRequestData(request: 2)
                                }
                            }
                        }
                    } label: {
                            HStack(spacing: 5){
                                Text(value.isEmpty ? placeholder : value).onAppear{
                                    
                                }
                                    .foregroundColor(value.isEmpty ? .black : .black)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color.white)
                                    .font(Font.system(size: 20, weight: .semibold))
                            }
                        
                    }
                    //Drop Down List Design End
                   
                    
                    Image("month_filter").resizable().frame(width: 25, height: 25)
                    
                }.padding(9)
                  .frame(width: UIScreen.main.bounds.width, height: 65)
                    .background(Color("orange"))
                
                if self.value == "self"  || self.value == "Others"{
                    
                    TextField("Search books..", text: $searchText).padding(8).cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 0.6)
                        )
                }
                ScrollView{
                    
                    ForEach(list.datas,id: \.id){
                        item in
                        HStack{
                            VStack{
                                AsyncImage(url: URL(string: item.partner_logo)){
                                    img in img.resizable().cornerRadius(45).frame(width:65, height:65)
                                }placeholder: {
                                    Image("logo_gray").resizable().frame(width:65, height:65).cornerRadius(20)
                                }
                            }.frame(width:85, height:100).background(Color.gray)
                            VStack(alignment: .leading){
                                HStack{
//
                                    Text(item.description).font(.system(size: 14, weight: .bold)).foregroundColor(Color("default_"))
                                    Spacer()
                                    Text(item.createdAt ?? "").font(.system(size: 14)).foregroundColor(Color(.gray))
                                    Image(systemName: "ellipsis").rotationEffect(.degrees(90)).font(.system(size: 16, weight: .bold)).foregroundColor(Color("default_"))
                                    
                                    
                                    
                                }
                                Text(item.subcategory_name ?? "").font(.system(size: 14, weight: .bold)).foregroundColor(Color(.gray))
                                
                                HStack{
                                    Image("approved").resizable().frame(width: 25, height:25)
                                    Text("\(item.totalaccepted)").font(.system(size: 14, weight: .bold)).foregroundColor(Color("default_"))
                                    Image("asign_red").resizable().frame(width: 25, height:25)
                                    Text("\(item.totalassigned)").font(.system(size: 14, weight: .bold)).foregroundColor(Color("default_"))
                                    Spacer()
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("View").foregroundColor(.white).padding(.horizontal, 6).background(Color("default_")).cornerRadius(10)
                                    })
                                    
                                }
                            }
                            
                        }.padding(.trailing, 12)
                        .frame(height:100)
                            .background(Color.white)
                            .cornerRadius(1)
                            .shadow(color: Color.gray, radius: 1)
                           
                    }
                }
            }.onAppear{
                list.getBookRequestData(request: 0)
            }
        }
       
    }
}

struct BookRequestView_Previews: PreviewProvider {
    static var previews: some View {
        BookRequestView()
//        DropDownList()
    }
}


//Model

import Foundation

// MARK: - GuestBookRequestModel
public struct GuestBookRequestModel :Decodable {
    public let userbookrequests: UserBookRequest
    public let request_type: String
    public let role: String
    public let categories: [BookRequestCategory]
//    public let subcategories: [Any?]
    public let category_id: Int
    public let sub_category_id: Int
//    public let data: Int
  

}

// MARK: - BookRequestCategory
public struct BookRequestCategory :Decodable {
    public let id: Int
    public let category_name: String
    public let parent_cat_id: Int

}

// MARK: - Userbookrequests
public struct UserBookRequest :Decodable {
    public let current_page: Int
    public let data: [BookRequestDatum]
    public let first_page_url: String
    public let from: Int
    public let last_page: Int
    public let last_page_url: String
    public let path: String
    public let per_page: Int
    public let to: Int
    public let total: Int

}

// MARK: - BookRequestDatum
public struct BookRequestDatum :Decodable {
    public let id: Int
    public let partner_logo: String
//    public let partner_name: String
    public let description: String
    public let category_id: Int?
    public let category_name: String?
    public let sub_category_id: Int?
    public let subcategory_name: String?
    public let createdAt: String?
    public let end_date: String?
    public let type: String?
    public let totalassigned: Int
    public let totalaccepted: Int

}


// MARK: - Authenticatication class

class GuestBookRequestService{
   
    func getBookRequestData(token: String,request: Int, completion: @escaping (Result<GuestBookRequestModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(APILoginUtility.guestBookRequestApi)\(request)") else {
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(GuestBookRequestModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
}




// MARK: - ViewModel class


class GuestBookRequestViewModel: ObservableObject{
    
   @State var request = 1
    @Published var datas  = [BookRequestDatum]()
    @Published var totalPage = Int()
    func getBookRequestData(request: Int) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestBookRequestService().getBookRequestData(token: token, request: request){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    
                    self.datas = results.userbookrequests.data
                    self.totalPage = results.userbookrequests.total
                     
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
