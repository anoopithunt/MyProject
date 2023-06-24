//
//  PublisherMyEarningView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 29/08/23.
//

import SwiftUI

struct PublisherMyEarningView: View {
    @StateObject var list = PublisherMyEarningViewModel()
    var body: some View {
        NavHeaderClosure(title: "My Earnings"){
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                        
                        NavigationLink(destination: {
                            PublisherRCEarningsView().navigationBarBackButtonHidden(true)
                            
                            
                        }, label: {
                            dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.totCountRC)", mainTileImage: "rcf_ti", tileName: "RC Earnings")
                        })
                        .padding()
                        NavigationLink(destination: {
                            PublisherBooksEarningView().navigationBarBackButtonHidden()
                            
                        }, label: {
                            dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.totalPublisehrEarned)", mainTileImage: "book_req", tileName: "Book Earnings")
                        })
                        NavigationLink(destination: {
                            PublisherTotalEarningsView().navigationBarBackButtonHidden()
                            
                        }, label: {
                            
                            dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.totalEarned)", mainTileImage: "book_req", tileName: "Total Earnings")
                        })
                        
                        
                        
                    }
                    Spacer()
                    
                }
                
                
            }.onAppear{
                list.getEarningData()
            }
//        }.overlay(alignment: .topTrailing){
//            Text("\(list.totCountRC)RC")
//                .foregroundColor(.white).font(.system(size: 26,weight: .bold)).padding(.top).padding(.trailing)
        }
    }
    
    
    func dashBoardTile(iconTileImage: String?, tileCount: String,mainTileImage: String?, tileName: String) -> some View{
        VStack(spacing:6){
            HStack {
                Spacer()
                Image(iconTileImage ?? "")
                    .resizable()
                    .frame(width: 22, height: 22, alignment: .center)
                    .padding(.leading,35)
                //                Spacer()
                //                    .frame(width: 14)
                Text(tileCount)
                    .bold()
                    .font(.custom("_", size: 23))
                    .foregroundColor(Color.black.opacity(0.8))
                
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical,6)
            HStack {
                Image(mainTileImage ?? "")
                    .resizable()
                    .frame(width: 90, height: 84, alignment: .leading)
                    .padding(.leading,5)
                    .padding(.bottom)
                    .padding(.top,-25)
                
                Spacer()
                
            }.padding(.horizontal)
            ZStack(alignment: .center){
                Rectangle()
                    .size( width: 442, height: 2)
                    .foregroundColor(.black)
                Text(tileName)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.white)
                
            }.padding(.bottom,6)
                .background(Color.gray.opacity(0.9))
            
        }
        .background(Color(hue: 1.0, saturation: 0.016, brightness: 0.83))
        .frame(width: UIScreen.main.bounds.width*0.48, height: UIScreen.main.bounds.height*0.18, alignment: .center)
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 5)
        
    }
}

struct PublisherMyEarningView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherMyEarningView()
    }
}

//MARK: PublisherMyEarningModel

public struct PublisherMyEarningModel: Decodable {
    public let totalbookcount: Int
    public let totalPublisehrEarned: Int
    public let totCountRC: Int
    public let totalRCEarn: Int
    public let totalEarned: Int
//    public let partner: PublisherMyEarningPartner
}


// MARK: - PublisherMyEarningPartner
public struct PublisherMyEarningPartner: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let role_id: Int
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let partner_role: PublisherMyEarningPartnerRole
 
}

// MARK: - PublisherMyEarningPartnerRole
public struct PublisherMyEarningPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
 
}



//MARK: PublisherMyEarningViewModel
class  PublisherMyEarningViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var totalPage:Int = 1//Int()
    @Published var totalbookcount: Int = 0//Int()
    @Published var totalPublisehrEarned: Int = 0//Int()
    @Published var totCountRC: Int = 0//Int()
    @Published var totalRCEarn: Int = 0//Int()
    @Published var totalEarned: Int = 0//Int()
    
    func getEarningData() {
        
        let apiurl = APILoginUtility.publisherMyEarningApi
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: PublisherMyEarningModel.self, token: token){ (result) in
            switch result {
            
            case .success(let results):
                DispatchQueue.main.async {
                    self.totCountRC = results.totCountRC
                    self.totalPublisehrEarned = results.totalPublisehrEarned
                    self.totalRCEarn = results.totalRCEarn
                    self.totalbookcount = results.totalbookcount
                    self.totalEarned = results.totalEarned
                    print(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
        
    }

}
