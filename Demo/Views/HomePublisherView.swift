//
//  HomePublisherView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 22/12/22.
//
import Marquee
import SwiftUI
import UIKit




private var colors:[Color] = [.gray, .red, .green, .orange, .purple]
var colorlist:[String] = ["#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0"]



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
//                .frame(width: 160)
                .padding(.leading).lineLimit(1).fixedSize()
            Text(address).font(.system(size: 19))
        }.foregroundColor(.white)
            .padding(.bottom)
            .frame( height: 235)
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
    public let colorlists: [String: String]
}

struct PublisherUsersList: Decodable {
    let id: Int
    let totalBooks: Int
    let totalfollowers: Int
    let totalBookViews: TotalBookView?
    let full_name: String?
    let full_address: String?
    let partner_media: [PartnerMedia]
    
}
public enum TotalBookView: Decodable {
    case integer(Int)
    case string(String)
    
    
    public var stringValue: String {
            switch self {
            case .integer(let intValue):
                return String(intValue)
            case .string(let stringValue):
                return stringValue
            }
        }
    

    public init(from decoder: Decoder) throws {
           if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
               self = .integer(intValue)
               print(intValue)
           } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
               self = .string(stringValue)
               print(stringValue)
           } else {
               throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid TotalBookViews value"))
           }
       }
}

struct PartnerMedia: Decodable{
    let id: Int
    let url: String
    let partner_media_type: PartnerMediaType
   
}

public struct PartnerMediaType: Decodable  {
    public let id: Int
    public let type: String

}



struct HomePublisher: View{
    @StateObject var list = PublisherModelVM()
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    var i: Int = 0
    var body: some View{
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Array(list.datas.enumerated()), id: \.1.id) { (index, userlist) in
                    VStack {
                        HStack{
                            if let totalBookViews = userlist.totalBookViews {
                                
                                switch totalBookViews {
                                case .integer(let intValue):
                                    Image(systemName: "eye")
                                        .font(.system(size: 15))
                                    Text(String(intValue))
                                        .font(.system(size: 15))
                                case .string(let stringValue):
                                    Image(systemName: "eye")
                                        .font(.system(size: 15))
                                    Text(stringValue)
                                        .font(.system(size: 15))
                                }
                            }
                            Spacer()
                            
                            Image("pdf_white").resizable().frame(width: 20, height: 22)
                            Text("\(userlist.totalBooks)").font(.system(size: 15))
                        }
                        .foregroundColor(.white)
                        //.padding()
                        
                        
                        ForEach(userlist.partner_media, id: \.id) { item in
                            if item.partner_media_type.type == "Logo" {
                                AsyncImage(url: URL(string: item.url)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 95,height: 95)
                                } placeholder: {
                                    Image("logo_gray").resizable().frame(height: 125)
                                }
                            }
                        }
                        Spacer()
                        Text(userlist.full_name ?? "").font(.title)
//                            .frame(width: 160)
                            .padding(.leading).lineLimit(1)
                            .foregroundColor(.white)//.fixedSize()
                        Text(userlist.full_address ?? "")
                            .font(.title2).foregroundColor(.white)
                    }
                    .padding()
                    .background(Color(hex: colorlist[index % colorlist.count]))
                    .cornerRadius(8)
                }
            }
        }
        
    }

}


extension Color {
    init(hex: String) {
        var hexValue = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}


class PublisherModelVM: ObservableObject {
    @Published var datas = [PublisherUsersList]()
    let url = "https://alibrary.in/api/publisherList"
    @Published var colorlists = [String: String]()
    
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
                        self.datas = results.userslist
                        self.colorlists = results.colorlists
                      
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}
