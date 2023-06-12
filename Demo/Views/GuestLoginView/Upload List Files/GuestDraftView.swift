//
//  GuestDraftView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 26/02/23.
//

import SwiftUI

struct GuestDraftView: View {
    @StateObject var list = GuestDraftViewModel()
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    @FocusState private var isTextFieldFocused: Bool

    @Environment(\.dismiss) var dismiss
    
    @State  var searchText: String = ""
    var body: some View {
        
        
        NavigationView{
            ZStack{
                Image("u").resizable()
                //                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                VStack(spacing: 2){
                 
                        HStack(spacing: 25){
                            Button(action: {
                                dismiss()
                            },
                                   label: {
                                
                                Image(systemName: "arrow.backward")
                                    .font(.system(size:22, weight:.heavy))
                                    .foregroundColor(.white)
                            })
                            Text("Draft List")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.white)
                            Spacer()
                           
                            
                        }.padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width, height: 65)
                            .background(Color("orange"))
                    TextField("Search books..", text: $searchText).font(.title)
                        .padding(4).padding(.trailing,26).foregroundColor(.gray)
                        .cornerRadius(8).focused($isTextFieldFocused)
                        .showClearButton($searchText)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 0.6)
                        )
                        
                    
                    
                    
                   
                    
                    ScrollView{
                        
                        LazyVGrid(columns: columns, spacing: 10){
                            
                            ForEach(list.datas, id: \.id){ item in
                                
                                VStack{
                                    
                                    AsyncImage(url: URL(string: "item.url")){img in
                                        
                                        NavigationLink(destination: AlibraryWebView().navigationTitle("")
                                            .navigationBarHidden(true)
                                            .navigationBarBackButtonHidden(true), label: {
                                            
                                            img.resizable()
                                                .frame(width: UIScreen.main.bounds.width/2.3, height: 260).cornerRadius(8)
                                        })
                                        
                                       
                                    }placeholder: {
                                        Image("logo_gray")
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width/2.3, height: 260).cornerRadius(8)
                                    }
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .frame(height: 0.7)
                                    HStack{
                                        Text(item.title ?? "").foregroundColor(Color("default_")).lineLimit(2)
                                       
                                        Spacer()
                                        
                                        Image("delete_gray").resizable().frame(width: 18, height: 22)
                                        
                                    }.padding(.horizontal).padding(.bottom)
                                    
                                }.background(Color.white)
                                   
                                    //.frame(width: UIScreen.main.bounds.width/2.25, height: 300)
                                    .cornerRadius(12).shadow(color: .gray, radius: 2)
                            }
                            
                            }
                    }
                Spacer()
                }.onAppear{
                    list.getUploadListDraftData()
                }
            }
        }
    }
}



struct TextFieldClearButton: ViewModifier {
    @Binding var fieldText: String
    @State var btncolor: Color = .gray
    func body(content: Content) -> some View {
        content
            .overlay {
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = ""
                        } label: {
                            Image(systemName: "multiply").font(.title).padding(.trailing, 4).foregroundColor(btncolor)
                        }
                        .foregroundColor(.gray)
                        .padding(.trailing, 4)
                    }
                }
                else {
                    HStack {
                        Spacer()
                        Image("magnifying_glass_right").resizable().frame(width: 25, height: 25).shadow(color: .black, radius: 1.2).padding(.trailing)
                    }
                }
            }
    }
}



extension View {
    func showClearButton(_ text: Binding<String>) -> some View {
        self.modifier(TextFieldClearButton(fieldText: text))
        
    }
    func showClearButtonOfSearchField(_ text: Binding<String>) -> some View {
        self.modifier(SearchFieldClearButton(fieldText: text))
    }
}


struct GuestDraftView_Previews: PreviewProvider {
    static var previews: some View {
        GuestDraftView()
    }
}



// MARK: - Welcome
public struct GuestDraftModel:Decodable {
    public let bookDetails: GuestDraftBookDetails

}

// MARK: - BookDetails
public struct GuestDraftBookDetails:Decodable {
    public let current_page: Int
    public let data: [GuestDraftDatum]
    public let total: Int

}

// MARK: - Datum
public struct GuestDraftDatum:Decodable {
    public let id: Int
    public let html_url: String
    public let tot_pages: Int
    public let title: String?
    public let url: String
    public let book_media: GuestDraftBookMedia

}

// MARK: - BookMedia
public struct GuestDraftBookMedia:Decodable {
    public let id: Int
    public let book_id: Int
    public let url: String?
    public let created_by: Int

}



// MARK: - Authentication

class GuestDraftService{
    
    func getUploadListDraftData(token: String, completion: @escaping (Result<GuestDraftModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: APILoginUtility.guestUploadListDraftApi!) else {
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
            
            guard let response = try? JSONDecoder().decode(GuestDraftModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
}




//View model

class GuestDraftViewModel: ObservableObject{
    
   
    @Published var datas = [GuestDraftDatum]()
   
    func getUploadListDraftData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestDraftService().getUploadListDraftData(token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.bookDetails.data
                    print(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

