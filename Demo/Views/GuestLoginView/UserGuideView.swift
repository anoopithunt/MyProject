//
//  UserGuideView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 14/04/23.
//

import SwiftUI

struct UserGuideView: View {
    @StateObject var list = UserGuideViewModel(_httpUtility: HttpUtility())
    var body: some View {
        NavigationView{

        ZStack{
            Image("u").resizable().ignoresSafeArea()
            VStack(spacing:22){
                    NavHeaderClosure(title: "User Guide"){
                        
                        ScrollView{
                            ForEach(list.datas, id: \.id){ item in
                                
                                NavigationLink(destination: {
                                    UserGuidePdfView(title: item.title , pdfurl: item.url)
                                        .navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    HStack{
                                        VStack(alignment: .leading, spacing: 8){
                                            Text(item.title).foregroundColor(.black).font(.system(size: 26))
                                            Text(item.description).foregroundColor(.gray).font(.system(size: 22))
                                        }
                                        
                                        Spacer()
                                        
                                    }.padding().frame(width: UIScreen.main.bounds.width, height: 125).background(Color.white).cornerRadius(7).shadow(radius: 2)
                                }).background(Color.yellow)
                              
                            }
                        }.onAppear{
                            list.getUserguideData()
                        }
                    }
                }
            }
        }
    }
}

struct UserGuideView_Previews: PreviewProvider {
    static var previews: some View {
        UserGuideView()
    }
}

// MARK: - Model

public struct UserGuideModel: Decodable {
    public let userGuides: [UserGuide]
    public let data: Int

}

// MARK: - UserGuide
public struct UserGuide: Decodable {
    public let id: Int
    public let title: String
    public let description: String
    public let url: String
}




class UserGuideViewModel: ObservableObject {
    
    @Published var datas = [UserGuide]()
    
    private let httpUtility: HttpUtility
    
    init(_httpUtility: HttpUtility) {
        httpUtility = _httpUtility
        
    }
    
    func getUserguideData()
    {
        let apiUrl = ApiUtils.userGuideApi
        httpUtility.getApiData(requestUrl: URL(string: "\(apiUrl)")!, resultType: UserGuideModel.self) { (results) in
            DispatchQueue.main.async {
                self.datas = results.userGuides
                
            }
            
            
            
        }
    }
}
