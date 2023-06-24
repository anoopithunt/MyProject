//
//  PublisherBookRequestView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 19/10/23.
//
 
import SwiftUI

struct PublisherBookRequestView: View {
    @FocusState private var isTextFieldFocused: Bool
    @StateObject var list = PublisherBookRequestViewModel()
    @State private var selectedOption = 0
    let options = ["All", "self", "Others"]
    @State var value = ""
    @State var category_name = "All"
    @State var isCatSel: Bool = false
    @State var subcat_name = "All"
    var placeholder = "All"
    @State  var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
      
        NavigationView{
          
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
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
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                         
                        Spacer()
                        //Drop Down List Design Start
                        Menu {
                            
                            ForEach(options, id: \.self){ client in
                                 
                                Button(client) {
                                    self.value = client
                                    
                                    if self.value == "All"{
                                        list.request = 0
                                        list.datas.removeAll()
                                        list.getBookRequestData(currentPage: 1)
                                    }
                                    else if self.value == "self" {
                                        list.request = 1
                                        list.datas.removeAll()
                                        list.getBookRequestData(currentPage: 1)
                                    }
                                    else if self.value == "Others" {
                                        list.request = 2
                                        list.datas.removeAll()
                                        list.getBookRequestData(currentPage: 1)
                                    }
                                }
                            }
                        } label: {
                            
                            HStack(spacing: 5){
                                
                                Text(value.isEmpty ? placeholder : value)
                                    .foregroundColor(.black )
                                    .frame(width: 65)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color.white)
                                    .font(Font.system(size: 20, weight: .semibold))
                                
                            }
                            
                        }
                        
//                       Drop Down List Design End
                        
                    }
                    .padding(9)
                    .frame(width: UIScreen.main.bounds.width, height: 65)
                    .background(Color("orange"))
                    
                    if self.value == "self"  || self.value == "Others"{
                        VStack(alignment: .leading){
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                                
                                Menu {
                                    
                                    ForEach(list.categories, id: \.id){ client in
                                        
                                        Button(client.category_name) {
                                            self.isCatSel = true
                                            self.subcat_name = "All"
                                            list.subcat_id = 0
                                            self.category_name = client.category_name
                                            list.datas.removeAll()
                                            list.cat_id = client.id
                                            print(client.parent_cat_id)
                                            list.getBookRequestData(currentPage: 1)
                                        }
                                    }
                                } label: {
                                    Text(self.category_name)
                                        .frame(width: .infinity)
                                        .padding(8).lineLimit(1)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.red, lineWidth: 0.6)
                                        )
                                }
                                if isCatSel {
                                    
                                    Menu {
                                        
                                        ForEach(list.subCategories, id: \.id){ client in
                                            
                                            Button(client.category_name) {
                                                self.subcat_name = client.category_name
                                                list.datas.removeAll()
                                                list.subcat_id = client.id
                                                print(client.parent_cat_id)
                                                list.getBookRequestData(currentPage: 1)
                                            }
                                        }
                                    } label: {
                                        Text(self.subcat_name)
                                            .frame(width: .infinity)
                                            .multilineTextAlignment(.leading)
                                            .padding(8)
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.red, lineWidth: 0.6)
                                            )
                                    }
                                }
                            }
                        }
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
                                        
                                        Text(item.description)
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(Color("default_"))
                                        
                                        Spacer()
                                        
                                        Text(item.createdAt )
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(.gray))
                                        Image(systemName: self.value == "self" ? "ellipsis" : "")
                                            .rotationEffect(.degrees(90))
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color("default_"))
                                    }
                                   
                                    Text(item.subcategory_name )
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(Color(.gray))
                                    
                                    HStack{
                                        Image("approved")
                                            .resizable()
                                            .frame(width: 25, height:25)
                                        Text("\(item.totalaccepted)")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(Color("default_"))
                                        Image("asign_red")
                                            .resizable()
                                            .frame(width: 25, height:25)
                                        Text("\(item.totalassigned)")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(Color("default_"))
                                        
                                        Spacer()
                                        NavigationLink(destination: {
//                       BookRequestListShowView(id: item.id)
                                            BookSuggestionView()
                                                .navigationTitle("")
                                                .navigationBarHidden(true).navigationBarBackButtonHidden(true)
                                        },
                                         
                                         label: {
                                            Text("Suggest").foregroundColor(.white).padding(8).background(Color("default_")).cornerRadius(10)
                                        })
                                        
                                    }
                                }
                                
                            }.padding(.trailing, 12)
                                .frame(height:100)
                                .background(Color.white)
                                .cornerRadius(6)
                                .shadow(color: Color.gray, radius: 4)
                            
                        }
                    }
                }.onAppear{
                    list.getBookRequestData(currentPage: 1)
                }
            }
            
        }
    }
}
 
struct PublisherBookRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherBookRequestView()
    }
}
  

// MARK: - PublisherBookRequestModel
public struct PublisherBookRequestModel: Decodable {
    public let userbookrequests: PublisherBookRequest
//    public let request_type: String
//    public let role: String
    public let categories: [PublisherBookRequestCategory]
    public let subcategories: [PublisherBookRequestSubCategory]
//    public let category_id: Int
//    public let sub_category_id: Int
//    public let data: Int
 
}

// MARK: - PublisherBookRequestCategory
public struct PublisherBookRequestCategory:Decodable {
    public let id: Int
    public let category_name: String
    public let parent_cat_id: Int
 
}
// MARK: - PublisherBookRequestCategory
public struct PublisherBookRequestSubCategory:Decodable {
    public let id: Int
    public let category_name: String
    public let parent_cat_id: Int
 
}

// MARK: - PublisherBookRequest
public struct PublisherBookRequest:Decodable {
    public let current_page: Int
    public let data: [PublisherBookRequestDatum]
    public let last_page: Int
    public let total: Int

     
}

// MARK: - PublisherBookRequestDatum
public struct PublisherBookRequestDatum : Decodable{
    public let id: Int
    public let partner_id: Int
    public let partner_logo: String
    public let partner_name: String
    public let description: String
    public let category_id: Int
    public let category_name: String
    public let sub_category_id: Int
    public let subcategory_name: String
    public let end_date: String
    public let created_at: String
    public let created_by: Int
    public let type: String
    public let createdAt: String
    public let totalassigned: Int
    public let totalaccepted: Int
}


class  PublisherBookRequestViewModel: ObservableObject {
    @Published var datas = [PublisherBookRequestDatum]()
    @Published var categories = [PublisherBookRequestCategory]()
    @Published var subCategories = [PublisherBookRequestSubCategory]()
    @Published var currentPage: Int = 1
    @Published var totalPage:Int = 1
    @Published var request:Int = 0
    @Published var cat_id:Int = 0
    @Published var subcat_id:Int = 0
    
//    @Published var searchText: String = "" {
//          didSet {
//              currentPage = 1 // Reset currentPage when searchText changes
//              print("The name has changed to \(searchText)")
//              getBookRequestData(currentPage: currentPage)
//          }
//      }
    
    func getBookRequestData(currentPage: Int) {
//         https://www.alibrary.in/api/guest/user-book-requests?request_type=1&category_id=&sub_category_id=
        guard let url = URL(string: "https://www.alibrary.in/api/guest/user-book-requests?request_type=\(self.request)&category_id=\(self.cat_id)&sub_category_id=\(self.subcat_id)&page=\(self.currentPage)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        
        let defaults = UserDefaults.standard
        
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        let service = HTTPLoginUtility()
        service.getLoginData(from: url, model: PublisherBookRequestModel.self, token: token){ (result) in
            
            switch result {
            case .success(let results):
                
                DispatchQueue.main.async {
                    self.totalPage = results.userbookrequests.last_page
                    self.categories = results.categories
                    self.subCategories = results.subcategories
                    print(self.categories[6] as Any)
                    if !results.userbookrequests.data.isEmpty {
                        if self.totalPage == 1{
                            self.datas = results.userbookrequests.data
                        }
                        else{
                            self.datas.append(contentsOf: results.userbookrequests.data)
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

