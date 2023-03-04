//
//  ReportedBooklistView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 11/03/23.
//

import SwiftUI

struct ReportedBooklistView: View {
    
    @StateObject var list = GuestReportedBookListViewModel()
   
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
            ZStack {
                
                Image("u").resizable().ignoresSafeArea()
                
                VStack(spacing: 1) {
                    HStack(spacing: 25){
                        
                        Button(action: {
                            dismiss()
                        },
                               label: {
                            
                            Image(systemName: "arrow.backward")
                            
                                .font(.system(size:22, weight:.heavy))
                            
                                .foregroundColor(.white)
                        })
                        Text("Reported Books List")
                            .font(.system(size: 25, weight: .medium))
                            .foregroundColor(.white)
                       
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                      .frame(width: UIScreen.main.bounds.width, height:65)
                      .background(Color("orange"))
                      
                  
                    
                    
                    VStack {
                        ScrollView{
                            ForEach(list.datas, id: \.id){ item in
                                HStack{
                                    VStack(alignment: .leading, spacing: 2){
                                        Text(item.createdAt)
                                            .foregroundColor(.gray)
                                            .font(.system(size: 16))
                                        Text( item.book_name)
                                            .foregroundColor(.black)
                                            .font(.system(size: 18))
                                        Text("Book Owner: \(item.partnername)")
                                            .font(.system(size: 18))
                                            .padding(.trailing, 6)
                                            .lineLimit(2)
                                            .foregroundColor(Color("default_"))
                                                    
                                        Text("Report: \(item.reporttype)")
                                            .foregroundColor(Color.green)
                                            .font(.system(size: 18, weight: .light))
                                        
                                        Text(item.comment)
                                            .foregroundColor(.gray)
                                            .font(.system(size: 16))
                                        
                                    }
                                    .padding(4)
                                    Spacer()
                                    AsyncImage(url: URL(string: item.book_url)){ img in
                                                img.resizable()
                                                    .frame(width:125, height:145)
                                            }placeholder: {
                                                Image("logo_gray")
                                                    .resizable()
                                                    .frame(width:125, height:145)
                                            }
                                    }.frame(height:150).background(Color("gray"))
                                }
                            
                        }
                        
                    }.onAppear{
                        list.getReportedBookData()
                        
                    }
                    Spacer()
                }
        }
    }
}

struct ReportedBooklistView_Previews: PreviewProvider {
    static var previews: some View {
        ReportedBooklistView()
    }
}




// MARK: - ReportedBookListModel
public struct ReportedBookListModel: Decodable {
    public let userBookReports: [ReportedBookUserBookReport]
    public let data: Int

}

// MARK: - UserBookReport
public struct ReportedBookUserBookReport:Decodable {
    public let id: Int
    public let report_type_id: Int
    public let book_id: Int
    public let partner_id: Int
    public let comment: String
    public let created_at: String
    public let partnername: String
    public let reporttype: String
    public let book_url: String
    public let book_name: String
    public let createdAt: String

}


class GuestReportedBookListService{
   
    func getReportedBookData(token: String, completion: @escaping (Result<ReportedBookListModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(APILoginUtility.guestReportedBookListApi)") else {
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(ReportedBookListModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
}




// MARK: - ViewModel class


class GuestReportedBookListViewModel: ObservableObject{
    @Published var datas:[ReportedBookUserBookReport]  = []

    func getReportedBookData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestReportedBookListService().getReportedBookData(token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.userBookReports
                    print(self.datas)
                     
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
