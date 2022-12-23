//
//  HomePublisherView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 22/12/22.
//
import Marquee
import SwiftUI
import UIKit
private var colors:[Color] = [.gray, .red, .green, .orange, .purple]
struct HomePublisherView: View {
    @State var totalBookViews = "707k"
    @State var totalBooks = "23"
    @State var address = "Pratapgarh"
    @State var fullName = "Alibrary Publication Prayagraj"
    @State var url = "https://alibrary.in/storage/images/partner/logo/Gyan_logo_181220210443_5.png"
    @State var bgColor = "default"
    var body: some View{
        VStack{
            HStack{
                Image(systemName: "eye").font(.system(size: 15))
                Text(totalBookViews).font(.system(size: 15))
                Spacer()
                Image("pdf_white").resizable().frame(width: 20, height: 22)
                Text(totalBooks).font(.system(size: 15))
            }
            .foregroundColor(.white)
            .padding()

            AsyncImage(url: URL(string: url)){ image in
                    
                    image
                    .resizable()
                    .frame( height: 96)
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                
            }placeholder: {
                Image("logo_gray").resizable().frame( height: 96, alignment:.center)
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(.all,8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
            }
                
            Spacer()
            Text(fullName).font(.title)
                .frame(width: 160)
                .padding(.leading).lineLimit(1).fixedSize()
            Text(address).font(.title2)
        }.foregroundColor(.white)
            .padding(.bottom)
            .frame(width: 175, height: 235)
            .background(Color(.purple)).opacity(0.7)
            .cornerRadius(8)
    }
}

struct HomePublisherView_Previews: PreviewProvider {
    static var previews: some View {
//        HomePublisherView()
        HomePublisher()
    }
}






struct ServerResponse: Decodable {
    let userslist: [PublisherUsersList]
}

struct PublisherUsersList: Decodable, Identifiable {
    let id: Int
    let totalBooks: Int
    let totalfollowers: Int
    let fullAddress: String?
    let partnerMedia: [PartnerMedia]
    
    enum CodingKeys: String, CodingKey {
        case id, totalBooks,totalfollowers
        case partnerMedia = "partner_media"
        case fullAddress = "full_address"
    }
}

struct PartnerMedia: Decodable, Identifiable {
    let id: Int
    let logourl: String
    let partner_media_type: PartnerMediaType
    enum CodingKeys: String, CodingKey {
        case id , partner_media_type
        case logourl = "url"
       
    }
}

public struct PartnerMediaType: Decodable  {
    public let id: Int
    public let type: String

}



struct HomePublisher: View{
    @StateObject var list = PublisherModelVM()
    @State private var size = CGSize.zero
    var body: some View{
        
        
        
            
            ScrollView(.horizontal) {
                HStack{
                   ForEach(list.datas, id: \.id){ item in
                       //                    if item.partner_media_type.type == "Logo"{
                       //                        AsyncImage(url: URL(string: item.logourl)){ image in
                       //                            image
                       //                                .resizable()
                       //                                .frame(width: 235, height: 125).cornerRadius(8)
                       //
                       //                        } placeholder: {
                       //                            Image("logo_gray") .resizable()
                       //                                .frame(width: 235, height: 125).cornerRadius(8)
                       //                        }
                       //                    Text(item.logourl)
                       //                    }
                       if item.partner_media_type.type == "Logo" {
                           AsyncImage(url: URL(string: item.logourl)
                                      , content: {
                               image in image.resizable().frame(width:UIScreen.main.bounds.width, height: 100)
                           }, placeholder: {
                               Image("logo_gray").resizable().frame(width:UIScreen.main.bounds.width, height: 235)
                           })
                       }
                     
                       
                       
                   }
    //               ForEach(list.datas1, id: \.id){
    //                   item in
    //                   Text(item.fullAddress ?? "Hello")
    //                   Text("\(item.partnerMedia.endIndex)")
    //               }
                }.marquee(duration: 12, autoreverse: false)
            }
       
    }
}

class PublisherModelVM: ObservableObject {
    @Published var datas = [PartnerMedia]()
    @Published var datas1 = [PublisherUsersList]()
    @Published var logo = [String]()
    let url = "https://alibrary.in/api/publisherList"
    
    init() {
        getData(url: url)
    }
    
    func getData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(ServerResponse.self, from: data)
                   
                    DispatchQueue.main.async {
                        
                        for user in results.userslist {
                            
                            self.datas.append(contentsOf: user.partnerMedia)
                        
                            
                        }
                        self.datas1 = results.userslist
                       
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
    
}





