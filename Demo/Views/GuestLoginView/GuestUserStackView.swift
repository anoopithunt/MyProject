//
//  GuestUserStackView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 08/04/23.
//

import SwiftUI
import Combine


struct GuestUserStackView: View {
    @State var rotate: [Int] = [-10, 10, 0]
    //    @State var index: Int = -1
    @State var searchText: String = ""
    @StateObject var list = GuestUserStackViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        
        NavHeaderClosure(title: "Public Stacks"){
            
            ZStack{
                
                Image("u").resizable().ignoresSafeArea()
                
                VStack(spacing:0){
                    
                    ScrollView{
                        TextField("search stacks", text: $searchText)
                            .font(.title)
                            .padding(4)
                            .padding(.trailing,26)
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                            .focused($isTextFieldFocused)
                            .showClearButton($searchText)
                            .overlay(
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 0.6)
                            )
                            .frame(height: 55)
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(list.datas, id:\.id){ item in
                                
                                VStack{
                                    NavigationLink(destination: {
                                        
                                        GuestStackBookListView( id: item.id,title: "\(item.name)")
                                            .navigationTitle("")
                                        
                                            .navigationBarHidden(true)
                                        
                                            .navigationBarBackButtonHidden(true)
                                        
                                    }, label: {
                                        ZStack(alignment: .center){
                                            ForEach(0..<min(item.stack_book_links.count, 3), id: \.self) { index in
                                                AsyncImage(url: URL(string: item.stack_book_links[index].url)){ img in
                                                    img.resizable()
                                                        .frame(width: 125, height: 155)
                                                        .rotationEffect(Angle(degrees: Double(rotate[index % rotate.count])))
                                                        .shadow(radius: 5)
                                                    
                                                }placeholder: {
                                                    Image("logo_gray")
                                                        .resizable()
                                                        .frame(width: 145, height: 155)
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    })
                                    VStack(alignment: .leading){
                                        
                                        Text(item.name)
                                            .foregroundColor(Color("default_"))
                                        
                                        Text("By: \(item.createdBy)")
                                            .foregroundColor(Color("maroon"))
                                        
                                        HStack{
                                            Text("\(item.stack_book_links_count)")
                                            
                                                .foregroundColor(Color("default_"))
                                            
                                            Image("stack_blue")
                                                .resizable()
                                                .frame(width: 18, height: 22)
                                            
                                            Spacer()
                                            Button(action: {
                                                
                                            }, label: {
                                                Text("Copy")
                                                    .font(.system(size:18))
                                                
                                                    .padding(.horizontal)
                                                    .padding(.vertical,4)
                                                    .foregroundColor(.white)
                                                    .background(Color.cyan)
                                                    .cornerRadius(12)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 15)
                                                            .stroke(Color.white, lineWidth: 1.0)
                                                            .shadow(radius:0.8)
                                                        
                                                    )
                                                
                                            })
                                            
                                        }
                                        
                                    }.padding(2)
                                    
                                }.padding(20)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                                
                            }
                            if list.currentPage < list.totalPage{
                                ProgressView()
                                    .frame(alignment: .center)
                                    .onAppear{
                                        list.currentPage = list.currentPage + 1
                                        list.getUserStackBookData()
                                        
                                    }
                                
                            }
                            Spacer()
                        }
                    }
                }
                .refreshable(action: {
                    //Refresh Action for recall the API
                    
                })
            }
        }
        .onAppear{
            list.getUserStackBookData()
        }
    }
}


struct GuestUserStackView_Previews: PreviewProvider {
    static var previews: some View {
        GuestUserStackView()

    }
}

//MARK:  View Model



class GuestUserStackViewModel: ObservableObject{
    
    @Published var datas = [GuestUserStackDatum]()
//    @Published var total = Int()
    @Published var image: [String] = []
    @Published var currentPage = 0
    @Published var totalPage = Int()
    @Published var id = Int()
    
    func getUserStackBookData() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationGuestUserStackService().getUserStackBookData(token: token, currentPage: currentPage) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.datas.append(contentsOf: results.stacks.data)
                    self.totalPage = results.stacks.total
                    for data in self.datas {
                        for imgdata in data.stack_book_links.reversed(){
                             self.image.append(imgdata.url)
                           
                        }
                        
                        }
                    
                    
                }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}




class AuthenticationGuestUserStackService {
    func getUserStackBookData(token: String,currentPage:Int, completion: @escaping (Result<GuestUserStackModel, NetworkError>) -> Void) {
        
//
        guard let url = URL(string: "https://alibrary.in/api/guest/user-stacks?page=\(currentPage)") else {
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
            
            guard let response = try? JSONDecoder().decode(GuestUserStackModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}


// MARK: - GuestUserStackModel

public struct GuestUserStackModel:Decodable {
    public let stacks: GuestUserStackStacks
//    public let partner: GuestUserStackPartner
//    public let data: Int

}

// MARK: - Partner
public struct GuestUserStackPartner:Decodable {
    public let id: Int
    public let partner_unique_id: String
//    public let user_id: Int
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let partner_role: GuestUserStackPartnerRole

}

// MARK: - PartnerRole
public struct GuestUserStackPartnerRole:Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String

}

// MARK: - Stacks
public struct GuestUserStackStacks:Decodable {
    public let current_page: Int
    public let data: [GuestUserStackDatum]
    public let total: Int

}

// MARK: - Datum
public struct GuestUserStackDatum:Decodable {
    public let id: Int
    public let name: String
    public let description: String
    public let stack_book_links_count: Int
    public let stack_book_links: [GuestUserStackStackBookLink]
    public let bookcount: Int
    public let createdBy: String

}

// MARK: - StackBookLink
public struct GuestUserStackStackBookLink:Decodable {
    public let id: Int
    public let stack_id: Int
    public let book_id: Int
    public let url: String
//    public let stack_book: GuestUserStackStackBook

}

// MARK: - StackBook
public struct GuestUserStackStackBook:Decodable {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let pdf_url: String
    public let html_url: String
    public let title: String
    public let author_name: String
    public let isbn_no: String
    public let size: String
    public let tot_likes: String
    public let tot_view: Int
    public let publish_date: String
//    public let validity_date: String
    public let book_partner_link: GuestUserStackBookPartnerLink
    public let book_media: GuestUserStackBookMedia

}

// MARK: - BookMedia
public struct GuestUserStackBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String

}

// MARK: - BookPartnerLink
public struct GuestUserStackBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int

}



class GlobalView<ModelType: Codable>: UIView {
    private let apiUrl: URL
    
    init(apiUrl: URL) {
        self.apiUrl = apiUrl
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(completion: @escaping (Result<ModelType, Error>) -> Void) {
        guard let token = getToken() else {
            completion(.failure(MyError.authenticationError))
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? MyError.noData))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(ModelType.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(MyError.decodingError))
            }
        }.resume()
    }
    
    private func getToken() -> String? {
        // implementation for getting token goes here
        return nil
    }
}

enum MyError: Error {
    case noData
    case authenticationError
    case decodingError
}


class AuthenticationGuestUserStackService1 {
    func getUserStackBookData<ModelType: Codable>(modelType: ModelType.Type, apiUrl: URL, token: String, currentPage:Int, completion: @escaping (Result<ModelType, NetworkError>) -> Void) {
        
        let guestUserStackView = GlobalView<ModelType>(apiUrl: apiUrl)
        guestUserStackView.loadData { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(.decodingError))
                print(error)
            
                
            }
        }
    }
}
