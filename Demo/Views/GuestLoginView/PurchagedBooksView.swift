//
//  PurchagedBooksView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 23/01/23.
//

import SwiftUI
import UIKit

import Foundation

public struct PurchasedBookModel : Decodable{
    public let purchasedBooks: PurchasedBooks
}

public struct PurchasedBooks:Decodable {
    public let current_page: Int
    public let data: [PurchagedBooksDatum]

}

public struct PurchagedBooksDatum: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
     public let book: PurchagedBookDetails
    public let partner: PurchasedBooksPartner
   
   

    
}

public struct PurchagedBookDetails: Decodable {
    public let id: Int
    public let name: String
    public let isbn_no: String
    public let book_media: PurchasedBooksBookMedia
    public let partner_name: PurchasedBooksPartnerName
}
public struct PurchasedBooksBookMedia:Decodable {
    public let id: Int
    public let bookid: Int?
    public let url: String?

}
public struct PurchasedBooksPartnerName:Decodable {
    public let id: Int
    public let qr_code_url: String

}


public struct PurchasedBooksPartner:Decodable {
    public let id: Int
       public let user_id: Int
       public let qr_code_url: String

}



struct PurchagedBooksView: View {
    @Environment(\.dismiss) var dismiss
    private var column = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject private var list = PurchasedBooksViewModel()
    var body: some View {
        ZStack{
            Image("u").resizable().foregroundColor(.white).ignoresSafeArea()
            NavigationView{
                VStack{
                    HStack(spacing: 20){
                        
                        Button(action: {
                            dismiss()
                            
                        }, label: {
                            Image(systemName: "arrow.left").font(.system(size: 25))
                        })
                        
                        
                        Text("**Purchaged Collections**").font(.system(size: 25))
                        Spacer()
                    }.padding(.horizontal).frame(height: 75).background(Color("orange")).foregroundColor(.white)
                    ScrollView {
                        LazyVGrid(columns: column, spacing: 10) {
                            ForEach(list.datas, id: \.id){ item in
                                NavigationLink(destination: {
                                    ShowBooksDetailsView( id: "\(item.book.id)")
                                        .navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    PurchagedBooksTile(name: item.book.name, img: "https://storage.googleapis.com/pdffilesalib/pdf/coverpage/\( item.book.book_media.url ?? "")")
                                })
                                
                            }
                        }
                        
                    }
                    
                    
                }.onAppear{
                    list.getPurchasedBooksData()
                }
            }
        }
    }
}

struct PurchagedBooksView_Previews: PreviewProvider {
    static var previews: some View {
        PurchagedBooksView()
    }
}

struct PurchagedBooksTile: View{
    @State var name: String
    @State var img: String
    var body: some View{
//        ZStack{
//            Image("u").resizable().foregroundColor(.white).ignoresSafeArea()
            VStack(alignment: .leading,spacing:8){
                AsyncImage(url: URL(string: img)){
                    image in
                    image.resizable().frame(height: 250)
                }placeholder: {
                    Image("logo_gray").resizable().frame(height: 250)
                }
                Text(name).bold().foregroundColor(Color("default_"))
                Text("Purchased book").bold().foregroundColor(.black)
                HStack{
                    
                    Image("purchased_book_owner").resizable().frame(width: 45, height: 45)
                    Spacer()
                    Image("rc_read_book_a").resizable().frame(width: 45, height: 45)
                   
                }.padding(.horizontal,5)
            }.padding(8).background(Color.white).cornerRadius(5).shadow(radius: 2)
//        }
    }
}


class PurchasedBooksViewModel: ObservableObject{
   
    @Published var datas = [PurchagedBooksDatum]()
//    @Published var datas = Int()
 
    func getPurchasedBooksData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        PurchasedBooksService().getPurchasedBooksData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.datas = results.purchasedBooks.data
                        print(results)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
     
        
    }
      
}




class PurchasedBooksService{
    
    func getPurchasedBooksData(token: String, completion: @escaping (Result<PurchasedBookModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: APILoginUtility.guestPurchagedbooksApi!) else {
            completion(.failure(.invalidURL))
            return
        }
//        guard let url = URL(string: "\(EndPoint.purchagedbooks)") else {
//                    completion(.failure(.invalidURL))
//                    return
//                }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(PurchasedBookModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
            
            
        }
}
