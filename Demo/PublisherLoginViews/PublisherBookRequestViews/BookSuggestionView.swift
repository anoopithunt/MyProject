//
//  BookSuggestionView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 11/10/23.
//

import SwiftUI
 
struct BookSuggestionView: View {
     
    @StateObject var list = PublisherBookSuggestionViewModel()
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavHeaderClosure(title: "Book Suggestion"){
        
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                VStack{
                    TextField("search stacks", text: $list.searchText)
                        .font(.title)
                        .padding(4)
                        .padding(.trailing,26)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .focused($isTextFieldFocused)
                        .showClearButton($list.searchText)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 0.6)
                            
                        )
                        .frame(height: 55)
                   
                   
                        ScrollView{
                            if list.datas.isEmpty {
                                   Text("No results found")
                                       .foregroundColor(.white)
                                       .padding()
                            } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                                ForEach(list.datas.filter { list.searchText.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(list.searchText) }, id: \.title){item in
                                    
                                    
                                    VStack(alignment: .leading, spacing: 2){
                                        
                                        AsyncImage(url: URL(string: "\(item.book_url)")){
                                            img in
                                            img
                                                .resizable()
                                                .frame(height: 235)
                                        }placeholder: {
                                            Image("logo_gray")
                                                .resizable()
                                                .frame(height:235)
                                        }
                                        Text("\(item.title)")
                                            .lineLimit(1).truncationMode(.tail)
                                            .font(.system(size: 16))
                                        Text("By: \(item.uploaded_by) ")
                                            .foregroundColor(Color.brown)
                                            .font(.system(size: 13,weight: .regular))
                                        //
                                        Text("\(item.published) ")
                                            .foregroundColor(Color.brown)
                                            .font(.system(size: 14,weight: .regular))
                                        //
                                        
                                    }
                                    .padding(6)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius:2)
                                }
                                
//                                if list.currentPage < list.totalPage {
//                                    CircularProgressBar()
//                                        .frame(35)
//                                        .onAppear {
//                                            list.currentPage += 1
//                                            list.getBookSuggestionData(currentPage: list.currentPage)
//
//                                        }
//
//                                }
                                
                            }
                            .padding(.leading,4)
                            
                        }
                    }
                }
                
            }.onAppear{
                list.getBookSuggestionData(currentPage: 1)
            }
        }
        
    }
}

struct BookSuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        BookSuggestionView()
    }
}
  
// MARK: - BookSuggestionModel
public struct BookSuggestionModel:Decodable {
//    public let userbookrequest: Userbookrequest
    public let books:  SuggestionBooks
//    public let role: String
//    public let bookSearch: String
//    public let is_accepted: Int
 
}

 
// MARK: -  SuggestionBooks
public struct  SuggestionBooks :Decodable{
    public let current_page: Int
    public let data: [BookSuggestionDatum]
    public let last_page: Int
//    public let to: Int
//    public let total: Int
    
    
}

// MARK: - BookSuggestionDatum
public struct BookSuggestionDatum : Decodable {
    public let id: Int
    public let title: String
    public let book_url: String
    public let published: String
    public let uploaded_by: String
//    public let category_name: String
//    public let subcategory_name: String

}

// MARK: - Userbookrequest
public struct Userbookrequest: Decodable {
    public let id: Int
    public let partner_id: Int
    public let description: String
    public let partner_name: String
    public let partner_logo: String
    public let category_name: String
    public let sub_category_id: Int
    public let subcategory_name: String
    public let end_date: String
    public let for_book: Int
 
}



// MARK: PublisherBookSuggestionViewModel1
class  PublisherBookSuggestionViewModel1: ObservableObject {
    @Published var datas = [BookSuggestionDatum]()
    @Published var currentPage: Int = 1
    @Published var totalPage:Int = 1
    @Published var searchText: String = "" {
          didSet {
              currentPage = 1 // Reset currentPage when searchText changes
              print("The name has changed to \(searchText)")
              getBookSuggestionData(currentPage: currentPage)
          }
      }
    func getBookSuggestionData(currentPage: Int) {
         
       
        guard let url = URL(string: "https://www.alibrary.in/api/guest/view-bookrequest?id=61&bookSearch=\(self.searchText)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: BookSuggestionModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.books.last_page
                    print(self.totalPage)
                    if !results.books.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.books.data
                        }
                        else{
                            self.datas.append(contentsOf: results.books.data)
                            
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



// MARK: PublisherBookSuggestionViewModel
class PublisherBookSuggestionViewModel: ObservableObject {
    @Published var datas = [BookSuggestionDatum]()
    @Published var currentPage: Int = 1
    @Published var totalPage: Int = 1
    @Published var searchText: String = "" {
        didSet {
            currentPage = 1 // Reset currentPage when searchText changes
//            self.datas.removeAll()
            if self.searchText == "" {
                
                self.datas.removeAll()
                self.currentPage = 1
                getBookSuggestionData(currentPage: 1)
            }
            getBookSuggestionData(currentPage: currentPage)
        }
    }

    func getBookSuggestionData(currentPage: Int) {
        guard let searchTextEncoded = self.searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Failed to encode search text")
            return
        }

        guard let url = URL(string: "https://www.alibrary.in/api/guest/view-bookrequest?id=61&bookSearch=\(searchTextEncoded)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
      

        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }

        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: BookSuggestionModel.self, token: token) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.books.last_page

                    if self.totalPage == 1 {
                        self.datas = results.books.data
                    } else {
                        self.datas.append(contentsOf: results.books.data)
                    }

                    if self.currentPage < self.totalPage {
                        self.currentPage += 1
                        self.getBookSuggestionData(currentPage: self.currentPage)
                    }
                    print(self.datas)
                }
            case .failure(let error):
                print(error.localizedDescription)
                // Handle the error here, e.g., display an alert or log the error.
            }
        }
    }
}



struct BookSuggestionView1: View {
    
    @State var searchText: String = ""
    @StateObject var list = PublisherBookSuggestionViewModel1()
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        NavHeaderClosure(title: "Book Suggestion"){
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                VStack{
                    TextField("search stacks", text: $list.searchText)
                        .font(.title)
                        .padding(4)
                        .padding(.trailing,26)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .focused($isTextFieldFocused)
                        .showClearButton($list.searchText)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 0.6)
                            
                        )
                        .frame(height: 55)
                    
                    ScrollView{
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                            ForEach(list.datas , id: \.title) { item in
                                
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
                                    Text(item.title)
                                    
                                }.padding(6)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius:2)
                            }
                            
                        }.padding(.leading,4)
                        
                    }
                    
                }
                
            }.onAppear{
                list.getBookSuggestionData(currentPage: 1)
            }
            
        }
        
    }
}



