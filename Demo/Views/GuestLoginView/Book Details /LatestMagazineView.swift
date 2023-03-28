//
//  LatestMagazineView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 24/03/23.
//

import SwiftUI

struct LatestMagazineView: View {
    @Environment(\.dismiss) var dismiss
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    @StateObject var list = PublicProfilePublisherViewModel()
    @State private var isLoading: Bool = false
    let options = ["All", "Prime", "Free", "Paid"]
    @State var value = ""
    var placeholder = "All"
    @State var selectedIndex = 0
    @State var id: Int
    @FocusState private var isTextFieldFocused: Bool
    
    
    @State  var searchText: String = ""
    var body: some View {
        ZStack{
            Image("u")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing:0){
                HStack(spacing: 25){
                    Button(action: {
                        dismiss()
                    },
                           label: {
                        
                        Image(systemName: "arrow.backward")
                            .font(.system(size:22, weight:.heavy))
                            .foregroundColor(.white)
                    })
                    Text(list.full_name)
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.white)
                    Spacer()
                    AsyncImage(url: URL(string: list.logo)){ img in
                        img.resizable()
                            .frame(width: 55, height: 55)
                            .cornerRadius(28)
                    }placeholder: {
                        Image("logo_gray").resizable()
                            .frame(width: 55, height: 55)
                            .cornerRadius(28)
                    }
                    
                    
                }.padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 90)
                    .background(Color("orange"))
                
                ScrollView{
                    VStack(spacing: 0){
                        
                        AsyncImage(url: URL(string: list.banner)){img in
                            img.resizable()
                                .frame(height: 225)
                            
                        }placeholder: {
                            Color.gray
                                .frame(height: 225)
                        }
                        HStack(spacing: 8){
                            Image("pdf_white")
                                .resizable()
                                .frame(width: 25, height: 28)
                            
                            Text("\(list.total)")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                            Button(action: {
                                
                            }, label: {
                                Text("Follow")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                                    .padding(6)
                                    .padding(.horizontal,8)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white, lineWidth: 1)
                                )
                                
                            })
                            Image("followers_white")
                                .resizable()
                                .frame(width: 13, height: 22)
                            Text("\(list.followers)")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                            Spacer()
                            
                            
                            Menu {
                                ForEach(options.indices, id: \.self) { index in
                                    Button(options[index]) {
                                        self.value = options[index]
                                        self.selectedIndex = index
                                        list.bookType = ["all", "prime", "free", "paid"][index]
                                        list.filterData = true
                                        list.currentPage = 1
                                        list.getBookData()
                                    }
                                }
                            } label: {
                                Text("\(options[selectedIndex]) \(list.total)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                            
                            
                        }.padding(.horizontal).frame(height: 65).background(Color("default_"))
                    LazyVGrid(columns: columns, spacing: 10, pinnedViews: [.sectionHeaders]){
                                Section(header:
                                            VStack{
                                    TextField("", text: $searchText).font(.title).accentColor(.clear)
                                        .padding(4).padding(.trailing,29)
                                        .padding(.leading,searchText.isEmpty ? 29 : 4)
                                        .foregroundColor(.white)
                                        .cornerRadius(8).focused($isTextFieldFocused)
                                        .showClearButtonOfSearchField($searchText)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 22)
                                                .stroke(Color.white, lineWidth: 1)
                                        ).overlay(alignment: .leading, content: {
                                            if searchText.isEmpty {
                                                Image("magnifying_glass_left" ).resizable().frame(width: 20, height: 20).padding(.leading,8)
                                            }
                                        })
                                        .overlay(alignment: .leading, content: {
                                            Text("Search books..").padding(.leading,32)
                                                .foregroundColor(.white)
                                                .font(.title)
                                                .opacity(searchText.isEmpty ? 1 : 0)
                                        } ).padding(0)
                                }.padding(.horizontal)
                                    .frame(height: 65).background(Color("default_")))
                                {
                                    ForEach(list.datas, id: \.id){item in
                                        VStack(alignment: .leading){
                                            AsyncImage(url: URL(string: item.book_media.url)){ img in
                                                img .resizable()
                                                    .frame(height: 255)
                                            }placeholder: {
                                                Image("logo_gray")
                                                    .resizable()
                                                    .frame(height: 255)
                                            }
                                            
                                            Text(item.title).lineLimit(2).font(.system(size: 22,weight: .regular))
                                            Text("Published: \(item.published)")
                                                .font(.system(size: 17,weight: .regular))
                                            Text("Like \("\(item.tot_likes ?? "0")")")
                                                .font(.system(size: 18,weight: .regular))
                                            HStack{
                                                Spacer()
                                                if item.is_free == 1
                                                {
                                                    Text("free").font(.system(size: 22,weight: .bold)).foregroundColor(.red)
                                                } else{
                                                    Text("paid").font(.system(size: 22,weight: .bold)).foregroundColor(.cyan)
                                                }
                                                
                                            }
                                        }.padding(8)
                                            .background(Color.white)
                                            .cornerRadius(4).shadow(radius: 1)
                                        
                                    }.padding(2)
                                    if list.currentPage < list.totalPage{
                                        
                                        CircleProgressView()
                                        
                                            .frame(alignment: .center)
                                        
                                            .onAppear{
                                               
                                                list.currentPage = list.currentPage + 1
                                                list.getBookData()
                                            }
                                        }
                                    
                                }
                            }
                        
                    }
                    
                }
            }.onAppear{
                list.id = self.id
                list.getBookData()
            }
        }
    }
}

struct LatestMagazineView_Previews: PreviewProvider {
    static var previews: some View {
//        LatestMagazineView()
        LatestMagazineView(id: 11)
      
    }
}



class PublicProfilePublisherViewModel: ObservableObject{
    
    @Published var datas = [PublicProfilePublisherDatum]()
    @Published var banner = String()
    @Published var logo = String()
    @Published var followers = Int()
    @Published var total = Int()
    @Published var full_name = String()
    @Published var currentPage = 0
    @Published var totalPage = Int()
    @Published var id = Int()
    var filterData = false
    var bookType = "all"
    
    func getBookData() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationPublicProfilePublisherService().getBookData(token: token, currentPage: currentPage, type: bookType, id: id) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.books.last_page ?? 1
                    self.followers = results.followers ?? 0
                    self.full_name = results.userDetails.full_name
                    self.total = results.books.total ?? 0
                    for img in results.userDetails.partner_media {
                        
                        if img.partnerMediatype == "Logo"{
                            self.logo = img.url
                            print(self.currentPage + self.datas.count)
                                           
                        }
                                           
                        else if img.partnerMediatype == "Banner"{
                                              
                            self.banner = img.url
                                                
                            //         print(self.banner)
                                            }
                                        }
                    if self.filterData {
                        self.datas.removeAll()
                    }
                    
                    self.currentPage += 1
                    self.datas.append(contentsOf: results.books.data)
                    
                    self.filterData = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMoreContentIfNeeded(currentItem item: PublicProfilePublisherDatum?) {
        guard let item = item else {
            getBookData()
            return
        }
        let thresholdIndex = datas.index(datas.endIndex, offsetBy: -5)
        if datas.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            getBookData()
        }
    }
    
}







class AuthenticationPublicProfilePublisherService {
    func getBookData(token: String,currentPage:Int,type: String,id: Int, completion: @escaping (Result<PublicProfilePublisherModel, NetworkError>) -> Void) {
        
//
        guard let url = URL(string: "\(APILoginUtility.publicProfileApi)id=\(id)&bookSearch=&page=\(currentPage)&type=\(type)") else {
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
            
            guard let response = try? JSONDecoder().decode(PublicProfilePublisherModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}


struct SearchFieldClearButton: ViewModifier {
    @Binding var fieldText: String

    func body(content: Content) -> some View {
        content
            .overlay{
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = ""
                        } label: {
                            Image(systemName: "multiply")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding(.trailing, 4)
                        }
                        .foregroundColor(.white)
                        .padding(.trailing, 4)
                    }
                }
            }
    }
}



import Foundation

// MARK: - PublicProfilePublisher
public struct PublicProfilePublisherModel :Decodable{
    public let userDetails: PublicProfilePublisherDetails
    public let books: PublicProfilePublisherBooks
//    public let stackDetails: [Any?]
    public let uploadType: [PublicProfilePublisherUploadType]
//    public let teachCount: String
//    public let stuCount: String
    public let followers: Int?  //Followers
//    public let loginUser: PublicProfilePublisherLoginUser
////    public let bookSearch: NSNull
//    public let type: String
//    public let data: Int

}

// MARK: - PublicProfilePublisherBooks
public struct PublicProfilePublisherBooks:Decodable {
    public let current_page: Int
    public let data: [PublicProfilePublisherDatum]
//    public let first_page_url: String
//    public let from: Int
    public let last_page: Int?
//    public let last_page_url: String
//    public let next_page_url: String
//    public let path: String
//    public let per_page: Int
//    public let prev_page_url: String?
//    public let to: Int
    public let total: Int?

    
}

// MARK: - PublicProfilePublisherDatum
public struct PublicProfilePublisherDatum:Decodable {
    public let id: Int
//    public let upload_type_id: Int
//    public let name: String
//    public let pdf_url: String
//    public let html_url: String
//    public let tot_pages: Int
//
    public let title: String
//    public let long_desc: String
//    public let meta_keyword: String
//    public let author_name: String
//    public let isbn_no: String
    public let is_free: Int?
    public let tot_likes: String?
    public let tot_view: Int?
    public let publish_date: String
    public let validity_date: String
    public let published: String
    public let book_media: PublicProfilePublisherBookMedia
//    public let book_partner_link: PublicProfilePublisherBookPartnerLink
 
}

// MARK: - PublicProfilePublisherBookMedia
public struct PublicProfilePublisherBookMedia:Decodable {
    public let id: Int
    public let url: String
    public let created_by: Int
}

// MARK: - PublicProfilePublisherBookPartnerLink
public struct PublicProfilePublisherBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int

}

// MARK: - PublicProfilePublisherLoginUser
public struct PublicProfilePublisherLoginUser:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let user_id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let partner_role: PublicProfilePublisherPartnerRole

}

// MARK: - PublicProfilePublisherPartnerRole
public struct PublicProfilePublisherPartnerRole:Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String

}

// MARK: - PublicProfilePublisherUploadType
public struct PublicProfilePublisherUploadType:Decodable {
    public let id: Int
    public let name: String
    public let description: String

}

// MARK: - PublicProfilePublisherDetails
public struct PublicProfilePublisherDetails:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let full_name: String
    public let qr_code_url: String
    public let partner_media: [PublicProfilePublisherPartnerMedia]
    public let address_link: PublicProfilePublisherAddressLink
    public let partner_role: PublicProfilePublisherPartnerRole
    public let user_data: PublicProfilePublisherUserData
//    public let partnerFollow: NSNull

}

// MARK: - PublicProfilePublisherAddressLink
public struct PublicProfilePublisherAddressLink:Decodable {
    public let id: Int
    public let partner_id: Int
    public let address_id: Int
//    public let createdBy: Int
    public let address: PublicProfilePublisherAddress

}

// MARK: - PublicProfilePublisherAddress
public struct PublicProfilePublisherAddress:Decodable {
    public let id: Int
    public let mobile_1: String
    public let email_id: String

}

// MARK: - PublicProfilePublisherPartnerMedia
public struct PublicProfilePublisherPartnerMedia:Decodable {
    public let id: Int
    public let partner_media_type_id: Int
    public let media_type_id: Int
    public let partner_id: Int
    public let url: String
    public let partnerMediatype: String
    public let partner_media_type: PublicProfilePublisherPartnerMediaType

}

// MARK: - PublicProfilePublisherPartnerMediaType
public struct PublicProfilePublisherPartnerMediaType:Decodable {
    public let id: Int
    public let type: String
    public let description: String
    public let is_active: Int

}

// MARK: - PublicProfilePublisherUserData
public struct PublicProfilePublisherUserData:Decodable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String

}





class AuthenticationPublicProfilePublisherService1 {
    func getBookData(token: String,currentPage:Int,type: String,id: Int, completion: @escaping (Result<PublicProfilePublisherModel, NetworkError>) -> Void) {
        
        
        
        guard let url = URL(string: "\(APILoginUtility.publicProfileApi)id=\(id)&bookSearch=&page=\(currentPage)&type=\(type)") else {
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
            
            guard let response = try? JSONDecoder().decode(PublicProfilePublisherModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}


class PublicProfilePublisherViewModel1: ObservableObject{
    
    @Published var datas = [PublicProfilePublisherDatum]()
    @Published var followers = Int()
    @Published var total = Int()
    @Published var full_name = String()
    @Published var currentPage = 1
    @Published var totalPage = Int()
    var filterData = false
    var bookType = "all"
    @Published var id = Int()
    func getBookData() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        AuthenticationPublicProfilePublisherService1().getBookData(token: token, currentPage: currentPage, type: bookType, id: id) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.totalPage = results.books.last_page ?? 1
                    self.followers = results.followers ?? 0
                    self.full_name = results.userDetails.full_name
                    self.total = results.books.total ?? 0
                    
                    if self.filterData {
                        self.datas.removeAll()
                    }
                    
                    self.currentPage += 1
                    self.datas.append(contentsOf: results.books.data)
                    
                    self.filterData = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMoreContentIfNeeded(currentItem item: PublicProfilePublisherDatum?) {
        guard let item = item else {
            getBookData()
            return
        }
        let thresholdIndex = datas.index(datas.endIndex, offsetBy: -5)
        if datas.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            getBookData()
        }
    }
}



struct LatestMagazineView1: View {
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    @StateObject var list = PublicProfilePublisherViewModel1()
    @State var selectedIndex = 0
    let options = ["All", "Prime", "Free", "Paid"]
    @State var value = ""
    var placeholder = "All"
    @State var id: Int// = 128
    var body: some View {
        
        VStack(spacing:0){
          
                    VStack(spacing: 0){
            HStack(spacing: 8){
                Image("pdf_white")
                    .resizable()
                    .frame(width: 25, height: 28)
                
                Text("\(list.total)")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                Button(action: {
                    
                }, label: {
                    Text("Follow")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding(6)
                        .padding(.horizontal,8)
                        .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 1)
                    )
                    
                })
                Image("followers_white")
                    .resizable()
                    .frame(width: 13, height: 22)
                Text("\(list.followers)")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                Spacer()
                
                
                Menu {
                    ForEach(options.indices, id: \.self) { index in
                        Button(options[index]) {
                            self.value = options[index]
                            self.selectedIndex = index
                            list.bookType = ["all", "prime", "free", "paid"][index]
                            list.filterData = true
                            list.currentPage = 1
                            list.getBookData()
                        }
                    }
                } label: {
                    Text(options[selectedIndex])
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
                
            }
            .padding(.horizontal)
             .frame(height: 65).background(Color("default_"))
                        
        ScrollView{
            LazyVGrid(columns: columns, spacing: 10){
                ForEach(list.datas, id: \.id){
                    item in
                    VStack(alignment: .leading){
                        AsyncImage(url: URL(string: item.book_media.url)){
                            img in
                            img .resizable()
                                .frame(height: 255)
                            
                        }placeholder: {
                            Image("logo_gray")
                                .resizable()
                                .frame(height: 255)
                            
                        }
                        Text(item.title)
                            .lineLimit(2)
                            .font(.system(size: 22,weight: .regular))
                        
                    }.padding(8)
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 1)
                    
                }.padding(2)
                if list.currentPage < list.totalPage{
                    ProgressView()
                        .frame(alignment: .center)
                        .onAppear{
                            list.currentPage = list.currentPage + 1
                            list.getBookData()
                        }
                }
                
            }
            
        }
                        
         
                    }
            
        }
        .onAppear{
            list.id = self.id
            list.getBookData()
            
        }
    }
}



struct ContentView3: View {
    @State private var showingBottomSheet = false
    @State private var publisherSheet = false
    @State private var content = AnyView(Stacks())

    var body: some View {
        NavigationView {
            VStack {
                content
                Button("Show Bottom Sheet") {
                    showingBottomSheet.toggle()
                }.foregroundColor(.red)
                NavigationLink( "", destination: DashboardView(), isActive: $publisherSheet)
            }
              
            .sheet(isPresented: $showingBottomSheet) {
                VStack {
                 

                    Button(action: {
                        content = AnyView(LatestMagazineView1(id: 17))
                        showingBottomSheet = false
                    }, label: {
                        Text("Any View 2")
                    })

                    
                    Button("Click me") {
                        
                        publisherSheet = true
                        showingBottomSheet = false
                    }
                        .buttonStyle(CustomButton())
                }
            }
        }
    }
}



struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        var isPressed = configuration.isPressed
        let backgroundColor = isPressed ? Color.red.opacity(0.2) : Color.clear
        
        return configuration.label
            .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
            .background(backgroundColor)
            .onHover { isHovering in
                if !isHovering {
                    withAnimation {
                        isPressed = false
                    }
                }
            }
            .animation(.easeInOut(duration: 0.2), value: isPressed)
    }
}
