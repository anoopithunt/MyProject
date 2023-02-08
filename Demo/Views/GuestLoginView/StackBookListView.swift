//
//  StackListView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 10/02/23.
//

import SwiftUI

struct StackBookListView: View {
//    @Environment(\.dismiss) var dismiss
    @StateObject var list = StacksBooksListViewModel()
    let columns =  [GridItem(.flexible()), GridItem(.flexible()) ]
    @State private var isShareSheetShowing = false
    @State var id: Int
    @State var name: String
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("u").resizable()
                VStack(spacing: 0) {
                    HStack(spacing: 25){
                        Button(action: {
//                            dismiss()
                        },
                               label: {
                            
                            Image(systemName: "arrow.backward")
                            
                                .font(.system(size:22, weight:.heavy))
                            
                                .foregroundColor(.white)
                        })
                        Text(name)
                        
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        
                        Button(action: {
                            //                        self.shown = true
                        }, label: {
                            Image("stack_plus_n")
                                .resizable()
                                .frame(width: 30, height: 35)
                        })
                        Button(action: shareButton, label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 30)
                        })
                        
                    }.padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width, height: 65)
                        .background(Color("orange"))
                    Spacer()
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 12) {
                            
                            ForEach(list.datas, id: \.id){ item in
                                VStack(alignment: .leading){
                                    AsyncImage(url: URL(string: item.book_media.url)){image in
                                        
                                        NavigationLink(destination: {
                                            ShowBooksDetailsView( id: "\(item.stack_book.id)").navigationTitle("")
                                                .navigationBarHidden(true)
                                                .navigationBarBackButtonHidden(true)
                                        }, label: {
                                            image.resizable()
                                                .frame(maxHeight: 225)
                                        })
                                    }placeholder: {
                                        Image("logo_gray").resizable().frame(maxHeight: 225)
                                    }
                                    
                                    HStack{
                                        Text(item.stack_book.name).foregroundColor(Color("default_")).font(.system(size: 16)).lineLimit(2)
                                        Spacer()
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(Color("default_"))
                                    }
                                }.padding(12).background(Color.white).cornerRadius(8).shadow(color: .gray, radius: 0.8)
                            }
                        }
                    }
                }.onAppear{
                    list.getStackBooksListData(id: self.id)
                }
               
            }
           
        }
    }
    func shareButton() {
           
           isShareSheetShowing.toggle()
           
           let url = URL(string: "https://www.alibrary.in/show-book?id=3898")
           let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

       }
}

struct StackBookListView_Previews: PreviewProvider {
    static var previews: some View {
        StackBookListView(id: 790, name: "BooksName")
    }
}


//Stack Book List Model Design


import Foundation

// MARK: - Welcome
public struct StackBookListModel:Decodable {
    public let stackBook_details: StackBookDetails

}

// MARK: - StackBookDetails
public struct StackBookDetails:Decodable {
    public let current_page: Int
    public let data: [StackBookListDatum]
    public let total: Int

}

// MARK: - Datum
public struct StackBookListDatum:Decodable {
    public let id: Int
    public let stack_details: StackBookListDetails
    public let stack_book: StackBookList
    public let book_media: StackBookListMedia
    public let partner_stack: PartnerBookListStack

}

// MARK: - BookMedia
public struct StackBookListMedia:Decodable {
    public let id: Int
//    public let book_id: Int
    public let url: String
//    public let created_at: Int

}

// MARK: - PartnerStack
public struct PartnerBookListStack:Decodable {
    public let id: Int
    public let partner_detail: PartnerDetail

}

// MARK: - PartnerDetail
public struct PartnerDetail:Decodable {
    public let id: Int
    public let dob: String

}

// MARK: - StackBook
public struct StackBookList:Decodable {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let tot_pages: Int
    public let title: String
    public let author_name: String
    public let isbn_no: String
    public let size: String
    public let publish_date: String
    public let validity_date: String
    public let published: String

}

// MARK: - StackDetails
public struct StackBookListDetails:Decodable {
    public let id: Int
    public let name: String
    public let description: String

}

// MARK: - StackDetail

//public struct StackDetail:Decodable {
//    public let id: Int
//    public let name: String
//    public let description: String
//    public let copyStack: [Any?]
//
//}

 //Authentication Class


class StacksBooksListService{
    
    func getStackBooksListData(token: String,id: Int, completion: @escaping (Result<StackBookListModel, NetworkError>) -> Void) {
        let apiurl = APILoginUtility.studentStacksBookListApi!+"\(id)"
        guard let url = URL(string: apiurl) else {
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
            
            guard let response = try? JSONDecoder().decode(StackBookListModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
    
}



//View Model


class StacksBooksListViewModel: ObservableObject{
   
    @Published var datas = [StackBookListDatum]()
//    @Published var image: [String] = []
    @Published var totalPage = Int()
    @Published var currentPage = 1
    func getStackBooksListData(id: Int) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        StacksBooksListService().getStackBooksListData(token: token,id: id){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.datas = results.stackBook_details.data
                        self.totalPage = results.stackBook_details.total
                        
//                        self.datas.append(contentsOf: results.studentStacks.data)
//                        for data in self.datas {
//                            for imgdata in data.stack_book_link{
//                                self.image.append(imgdata.book_url)
//                            }
//                        }
                        print(self.datas)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}
