//
//  ShareView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 13/02/23.
//

import SwiftUI

struct ShareView: View {
    @State private var isShareSheetShowing = false
        
    var body: some View {
        Button(action: shareButton) {
            Image(systemName: "square.and.arrow.up")
                .font(.title)
                .foregroundColor(.black)
        }
    }
    func shareButton() {
           
           isShareSheetShowing.toggle()
           
           let url = URL(string: "https://www.alibrary.in/show-book?id=3898")
           let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

       }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
//        ShareView()
        ListDataView()
    }
}


public struct DeleteListModels:Decodable {
    public let bookDetails: DeleteListBookDetail
}

// MARK: - BookDetails
public struct DeleteListBookDetail:Decodable {
    public let data: [DeleteListData]
    public let total: Int
}

// MARK: - Datum
public struct DeleteListData:Decodable {
    public let id: Int
//    public let publication: String
    public let title: String
    public let url: String
    public let approve_status: ApproveStatus
}



// MARK: - ApproveStatus
public struct ApproveStatus:Decodable  {
    public let id: Int
    public let status: String
    public let reason: String
//    public let approvedBy: ApproveStatusApprovedBy

}

// MARK: - ApproveStatusApprovedBy
public struct ApproveStatusApprovedBy {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let schoolShortid: NSNull
    public let fullName: String
    public let gender: String
    public let referalCode: String

}

// MARK: - ApprovedPartner
public struct ApprovedPartner {
    public let id: Int
    public let bookid: Int
    public let approvedBy: ApprovedPartnerApprovedBy

}

// MARK: - ApprovedPartnerApprovedBy
public struct ApprovedPartnerApprovedBy {
    public let id: Int
    public let partnerUniqueid: String
    public let partnerLibraryid: String
    public let firstName: String
    public let lastName: String
    public let fullName: String
    public let gender: String
    public let referalCode: String

}

// MARK: - BookCategoryLink
public struct BookCategoryLink {
    public let id: Int
    public let bookid: Int
    public let category: Category
    public let subCategory: SubCategory

}

// MARK: - Category
public struct Category {
    public let id: Int
    public let parentCatid: Int
    public let categoryName: String
    public let description: String
    public let descBy: String
    public let url: String
    public let banner: String

}

// MARK: - SubCategory
public struct SubCategory {
    public let id: Int
    public let parentCatid: Int
    public let categoryName: String

}

// MARK: - BookMedia
public struct BookMedia {
    public let id: Int
    public let url: String

}


// MARK: - PartnerName
public struct PartnerName {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let fullName: String
    public let gender: String
    public let dob: String
    public let qrCodeurl: String
    public let referalCode: String

}





class GuestListService{
    
    func getListData(token: String,publish: Int, completion: @escaping (Result<DeleteListModels, NetworkError>) -> Void) {
        guard let url = URL(string: "\(APILoginUtility.guestUnPublishedApi)\(publish)") else {
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
            
            guard let response = try? JSONDecoder().decode(DeleteListModels.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
}




//View model

class GuestListViewModel: ObservableObject{
    
   @State var publish = 1
    @Published var datas:[DeleteListData] = []
   
    func getListData(publish: Int) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestListService().getListData(token: token,publish: publish){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                            self.datas = results.bookDetails.data
                    print(self.datas)
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ListDataView: View {
        @StateObject var list = GuestListViewModel()
    let options = ["All","Unapproved", "Disapproved", "Rejected"]
    @Environment(\.dismiss) var dismiss
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    @State  var searchText: String = ""
    
    @State var value = ""
    var placeholder = "All"
    
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            
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
                    Text("Unpublished Books").lineLimit(1)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    Menu {
                        ForEach(options, id: \.self){ client in
                            Button(client) {
                                self.value = client
                                if self.value == "All"{
                                    list.getListData(publish: 4)
                                }
                                else if self.value == "Unapproved" {
                                    list.getListData(publish: 1)
                                    
                                }
                                else if self.value == "Disapproved" {
                                    list.getListData(publish: 2)
                                }
                                else if self.value == "Rejected" {
                                    list.getListData(publish: 3)
                                }
                                
                            }
                        }
                    } label: {
                            HStack(spacing: 5){
                                Text(value.isEmpty ? placeholder : value).onAppear{
                                    
                                }
                                    .foregroundColor(value.isEmpty ? .white : .white)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color.white)
                                    .font(Font.system(size: 20, weight: .semibold))
                            }
                        
                    }
                     
                }.padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 65)
                    .background(Color("orange"))
                TextField("Search books..", text: $searchText)
                    .padding(8)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 0.6)
                    )
                ScrollView{
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach((list.datas) , id: \.id){item in
                                VStack(alignment: .leading){
                                AsyncImage(url: URL(string: item.url)){ img in
                                    img
                                        .resizable()
                                        .frame(height: 235)

                                }placeholder: {
                                    Image("logo_gray").resizable()
                                        .frame(height: 235)
                                }
                                Rectangle().frame(height: 0.1)
                                Text(item.title).font(.system(size: 10, weight: .light)).foregroundColor(Color("default_"))
                                
                                HStack{
                                    Text("status:\(item.approve_status.status)").font(.system(size: 12, weight: .light)).foregroundColor(.red).padding(.horizontal,6)
                                    Spacer()
                                    Image("delete_gray").resizable().frame(width: 15, height: 18)
                                }.padding(.horizontal,2).padding(.bottom,4)
                                
                                
                                
                            }.padding(2).background(Color.white).shadow(radius: 1)
                                
                        }
                    }
               
                }
            }.onAppear{
                list.getListData(publish: 4)
            }
        }
    }
   
}
