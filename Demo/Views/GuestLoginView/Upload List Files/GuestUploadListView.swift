//
//  GuestUploadListView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 25/02/23.
//

import SwiftUI

struct GuestUploadListView: View {
    @StateObject var list = GuestUploadListDashboardViewModel()
  
    var body: some View {
        
        
        NavigationView{
            ZStack{
                Image("u").resizable()
                //                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                    .ignoresSafeArea()
                
                VStack(spacing: 0){
                    HStack(spacing: 25){
                        Button(action: {
                            
                        },
                               label: {
                            
                            Image(systemName: "arrow.backward")
                            
                                .font(.system(size:22, weight:.heavy))
                            
                                .foregroundColor(.white)
                        })
                        Text("Upload List")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                        Spacer()
                        Image("cloud_screen").resizable().frame(width: 30, height: 25)
                        
                    }.padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width, height: 65)
                        .background(Color("orange"))
                  
                        HStack{
                            NavigationLink(destination: {
                                
                            }, label: {
                                
                                
                                GuestUploadListTileView(uploadData: $list.publishPDFs, uploadIcon: "pdf_gray", uploadImage: "published", uploadType: "Published PDF")
                            })
                            
                            NavigationLink(destination: {
                                
                            }, label: {
                                GuestUploadListTileView(uploadData: $list.unPublishPDFs, uploadIcon: "pdf_gray", uploadImage: "unpublished", uploadType: "Unpublished PDF")
                               
                            })
                        }
                        
                        
                        
                        HStack{
                            NavigationLink(destination: {
                                
                            }, label: {
                                
                                GuestUploadListTileView(uploadData: $list.draftPdfs, uploadIcon: "pdf_gray", uploadImage: "draft", uploadType: "Draft PDF")
                                
                            })

                            
                          
                            NavigationLink(destination: {
                                
                            }, label: {
                                
                                GuestUploadListTileView(uploadData: $list.draftPdfs, uploadIcon: "delete_gray_new", uploadImage: "delete_uploads", uploadType: "Delete PDF")
                            })

                         
                        }
                 
                    
                  
                    Spacer()
                    
                }.onAppear{
                    list.getUploadListDashboardData()
                }
            }
        }
        
    }
}

struct GuestUploadListView_Previews: PreviewProvider {
    static var previews: some View {
        GuestUploadListView()
    }
}



import Foundation

// MARK: - UploadListDashboardModel
public struct UploadListDashboardModel:Decodable {
    public let publishPDFs: Int
    public let unPublishPDFs: Int
    public let draftPdfs: Int
    public let deletePdfs: Int
    public let partner: UploadListDashboardPartner
    public let data: Int

}

// MARK: - UploadListDashboardPartner

public struct UploadListDashboardPartner:Decodable {
    public let id: Int
    public let first_name: String?
    public let last_name: String?
    public let full_name: String?
    public let gender: String?
    public let dob: String?

}



class GuestUploadListDashboardService{
    
    func getUploadListDashboardData(token: String, completion: @escaping (Result<UploadListDashboardModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: APILoginUtility.guestUploadListDashboardApi!) else {
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
            
            guard let response = try? JSONDecoder().decode(UploadListDashboardModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
}




//View model

class GuestUploadListDashboardViewModel: ObservableObject{
    
    @Published var publishPDFs = Int()
    @Published var unPublishPDFs = Int()
    @Published var draftPdfs = Int()
    @Published var deletePdfs = Int()
   
    func getUploadListDashboardData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestUploadListDashboardService().getUploadListDashboardData(token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.publishPDFs = results.publishPDFs
                    self.unPublishPDFs = results.unPublishPDFs
                    self.draftPdfs = results.draftPdfs
                    self.deletePdfs = results.deletePdfs
                    print(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}




struct GuestUploadListTileView:View{
    @Binding var uploadData: Int
    @State var uploadIcon: String = ""
    @State var uploadImage: String = ""
    @State var uploadType: String = ""
    
    
    
    var body: some View{
        VStack(alignment: .leading){
            HStack(spacing: 12){
                Spacer()
                Image(uploadIcon).resizable().frame(width: 17, height: 19)
                Text("\(uploadData)").foregroundColor(.gray).font(.system(size: 22, weight: .semibold))
            }.padding()
            Image(uploadImage).resizable().frame(width: 75, height: 75).padding(.leading)
            VStack(alignment: .leading){
                Rectangle().foregroundColor(.black).frame(height: 2.3)
                Text(uploadType).foregroundColor(.white).font(.system(size: 20, weight: .medium)).padding(.leading)
            }.padding(.bottom,4).background(Color.gray)
            
        }.background(Color("gray")).cornerRadius(6).frame(width: UIScreen.main.bounds.width/2.2 , height: 235)
    }
}
