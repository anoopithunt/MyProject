//
//  BookRequestListShowView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 24/04/23.
//

import SwiftUI

struct BookRequestListShowView: View {
    @State var id: Int
    @StateObject var list = BookRequestListViewModel()
    @State private var backgroundColor = Color.gray
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    @FocusState private var isTextFieldFocused: Bool
    @State  var searchText: String = ""
    var body: some View {
        
        NavHeaderClosure(title: "User Book Accept"){
                ZStack{
                    Image("u").resizable()
                        .ignoresSafeArea()
                    VStack{
                        TextField("Search books..", text: $searchText).font(.title)
                            .padding(4).padding(.trailing,26).foregroundColor(.gray).background(Color.white)
                            .cornerRadius(8).focused($isTextFieldFocused)
                            .showClearButton($searchText)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 0.6)
                            )
                        ScrollView{
                                LazyVGrid(columns: columns, spacing: 10){
                                    
                                    ForEach(list.datas.filter { searchText.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(searchText) }, id: \.id){
                                        item in
                                        VStack(alignment:.leading){
                                          
                                            AsyncImage(url: URL(string: item.book_url))
                                            {
                                                img in
                                                
                                                NavigationLink(destination: {
                                                    EmptyView()
                                                        .navigationTitle("")
                                                        .navigationBarHidden(true)
                                                    .navigationBarBackButtonHidden(true)                                                }, label: {
                                                    img
                                                        .resizable()
                                                        .frame( height: 224)
                                                })
                                                
                                                
                                            }
                                        placeholder: {
                                            Image("logo_gray")
                                                .resizable()
                                                .frame( height: 224)
                                            
                                        }
                                            Text(item.title)
                                                .lineLimit(1)
                                                .font(.system(size: 22))
                                                .foregroundColor(Color("default_"))
                                            
                                            Text("By:\(item.uploaded_by ?? "")")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color("maroon"))
                                            Text(item.published ?? "")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color("default_"))
                                            
                                            HStack{
                                                Image("accept_gr")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                Spacer()
                                                Text("prime")
                                                    .font(.system(size: 24, weight: .bold))
                                                    .foregroundColor(Color.cyan)
                                                
                                            }
                                            
                                            
                                        }
                                        .padding(6)
                                        .background(Color.white)
                                        .cornerRadius(6)
                                        .shadow(radius: 1)
                                        .padding(6)
                                        
                                    }
                                    
                                }
                        }
                        .refreshable(action: {
                            
                            list.getBookRequestListData(id: id)
                            
                        })
                        .onAppear{
                            list.getBookRequestListData(id: id)
                            
                        }
                        
                    }.toast(isPresented: $list.noBooks) {
                        ToastView(message: "There is no Books...")
                            
                    }
                    
                }
                
//            }
            
        }
        
    }
    
}

struct BookRequestListShowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRequestListShowView(id: 17)
          
        }
}



import Foundation

// MARK: - BookRequestListModel
public struct BookRequestListModel:Decodable {
//    public let userbookrequest: UserBookRequestList
    public let requestBookLinks: RequestBookLinks
//    public let role: String
//    public let bookSearch: String?
//    public let is_closed: Int
//    public let data: Int

}

// MARK: - RequestBookLinks
public struct RequestBookLinks: Decodable {
//    public let current_page: Int
    public let data: [BookRequestListDatum]
//    public let path: String

}

// MARK: - Datum
public struct BookRequestListDatum: Decodable {
    public let id: Int
//    public let user_request_id: Int
//    public let book_id: Int
//    public let partner_id: Int
    public let title: String
//    public let category_name: String
//    public let subcategory_name: String
//    public let is_prime: Int
//    public let is_free: Int
//    public let is_blocked: Int
//    public let is_publish: Int
    public let uploaded_by: String?
    public let published: String?
    public let book_url: String
   
}

// MARK: - Userbookrequest
public struct UserBookRequestList: Decodable {
    public let id: Int
    public let description: String
    public let category_id: Int
    public let totalassigned: Int
    public let totalaccepted: Int
    public let partner_logo: String
    public let partner_name: String
    public let category_name: String
    public let subcategory_name: String
  
}




class BookRequestListViewModel: ObservableObject{
   
    @Published var datas = [BookRequestListDatum]()
    @Published var totalPage = Int()
    @Published var currentPage = 1
    @Published var noBooks:Bool = false
    func getBookRequestListData(id: Int) {
        let apiurl = "\(APILoginUtility.guestBookRequestListApi)\(id)&page=\(currentPage)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: BookRequestListModel.self, token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        if !results.requestBookLinks.data.isEmpty{
                           
                            self.datas = results.requestBookLinks.data
                            //                        self.totalPage = results.stackBook_details.total
                            
                            print(self.datas)
                        }
                        else{
                            self.noBooks = true
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}









