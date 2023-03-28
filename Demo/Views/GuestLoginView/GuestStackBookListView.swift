//
//  GuestStackBookListView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 10/04/23.
//

import SwiftUI

struct GuestStackBookListView: View {
    @StateObject var list = GuestStackBookListViewModel()
    @State var searchText: String = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @FocusState private var isTextFieldFocused: Bool
  @State var id: Int// = 891
    @State var title: String = ""
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea(.keyboard)
            NavHeaderClosure(title: title){
                
                ScrollView{
                    VStack{
                        TextField("search stacks", text: $searchText).font(.title)
                            .padding(4).padding(.trailing,26).foregroundColor(.gray)
                            .cornerRadius(8).focused($isTextFieldFocused)
                            .showClearButton($searchText)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 0.6)
                            ).frame(height: 55)
                        
                        
                        
                        
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(list.datas, id: \.id){ item in
                                VStack(alignment: .leading){
                                    AsyncImage(url: URL(string: item.book_media.url)){
                                        img in
                                        img.resizable().frame(height: 275)
                                    }placeholder: {
                                        Image("logo_gray").resizable().frame(height: 275)
                                    }
                                    Text("\(item.stack_book.title)").foregroundColor(Color("default_"))
                                }.padding(6).background(Color.white).cornerRadius(8).shadow(radius: 1)
                            }
                            
                            
                        }
                    }.onAppear{
                        list.getStackBookListData(id: id)
                    }
                }
            } .overlay(starOverlay, alignment: .topTrailing)
        }
        
    }
    private var starOverlay: some View {
        HStack(spacing:14){
            Button(action: {
                
            }, label: {
                
                Text("Copy").font(.system(size:22))
                    .padding(.horizontal).padding(.vertical,4)
                    .foregroundColor(.white)
                    .background(Color.cyan)
                    .cornerRadius(12).overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 1.0).shadow(radius:0.8)
                    )
            })
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(.white).font(.system(size: 22,weight: .bold))
                
        }.padding([.top, .trailing])
    }
}

struct GuestStackBookListView_Previews: PreviewProvider {
    static var previews: some View {
        GuestStackBookListView( id: 890)
    }
}


// MARK: - GuestStackBookListModel
public struct GuestStackBookListModel:Decodable {
//    public let stack_detail: GuestStackBookListStackDetail
    public let stackBook_details: GuestStackBookListStackBookDetails
//    public let success: String
//    public let data: Int

}

// MARK: - StackBookDetails
public struct GuestStackBookListStackBookDetails:Decodable  {
    public let current_page: Int
    public let data: [GuestStackBookListDatum]
//    public let to: Int
    public let total: Int

}

// MARK: - GuestStackBookListDatum
public struct GuestStackBookListDatum :Decodable {
    public let id: Int
//    public let stack_id: Int
//    public let book_id: Int
    public let createdBy: String?
//    public let stack_details: GuestStackBookListStackDetails
    public let stack_book: GuestStackBookListStackBook
    public let book_media: GuestStackBookListBookMedia
//    public let partner_stack: GuestStackBookListPartnerStack

   
}

// MARK: - GuestStackBookListBookMedia
public struct GuestStackBookListBookMedia:Decodable  {
    public let id: Int
//    public let book_media_type_id: Int
//    public let media_type_id: Int
    public let book_id: Int
    public let url: String
//    public let created_by: Int

}

// MARK: - GuestStackBookListPartnerStack
public struct GuestStackBookListPartnerStack :Decodable {
    public let id: Int
    public let partner_id: Int
    public let stack_id: Int
    public let is_active: Int
    public let partner_detail: GuestStackBookListPartnerDetail

}

// MARK: - GuestStackBookListPartnerDetail
public struct GuestStackBookListPartnerDetail:Decodable  {
    public let id: Int
    public let partner_unique_id: String
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let gender: String
    public let dob: String

}

// MARK: - GuestStackBookListStackBook
public struct GuestStackBookListStackBook:Decodable  {
    public let id: Int
//    public let upload_type_id: Int
    public let name: String?
//    public let pdf_url: String
//    public let html_url: String
//    public let tot_pages: Int
    public let title: String
//    public let long_desc: String
//    public let meta_keyword: String
    public let author_name: String?
//    public let isbn_no: String
//    public let size: String
//    public let publish_date: String
//    public let is_deleted: Int
//    public let ownership: String
//    public let validity_date: String
    public let published: String?

}

// MARK: - GuestStackBookListStackDetails
public struct GuestStackBookListStackDetails:Decodable  {
    public let id: Int
    public let name: String
    public let description: String

}

// MARK: - GuestStackBookListStackDetail
public struct GuestStackBookListStackDetail :Decodable {
    public let id: Int
    public let name: String
    public let description: String
//    public let copyStack: [Any?]
 
}



//MARK: GuestStackBookListViewModel



class GuestStackBookListViewModel: ObservableObject{
    
    @Published var datas = [GuestStackBookListDatum]()
//    @Published var total = Int()
    @Published var image: [String] = []
    @Published var currentPage = 0
    @Published var totalPage = Int()
//    @Published var id = Int()
    
    func getStackBookListData(id: Int) {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationGuestStackBookListService().getStackBookListData(token: token, currentPage: currentPage, id: id) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.datas.append(contentsOf: results.stackBook_details.data)
                    self.totalPage = results.stackBook_details.total
 
                }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}




class AuthenticationGuestStackBookListService {
    
    
    func getStackBookListData(token: String,currentPage:Int,id:Int, completion: @escaping (Result<GuestStackBookListModel, NetworkError>) -> Void) {
        
//
        guard let url = URL(string: "https://alibrary.in/api/student/stack-book-list?id=\(id)&bookSearch=&page=\(currentPage)") else {
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
            
            guard let response = try? JSONDecoder().decode(GuestStackBookListModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}

