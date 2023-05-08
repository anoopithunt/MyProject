//
//  PublisherModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 26/07/22.
//

import Foundation
import SwiftUI
struct PublisherListModel: Identifiable {
   
    var id = UUID()
    var totalBooks: String
    var full_name: String
    var totalBookViews: String
    var totalfollowers: String
//    var url: String
    

}


// MARK: - Welcome
public struct PublisherModel:Decodable {
    public let userslist: [PublisherUserslist]
    let colorlists: [String: String]
}

// MARK: - Userslist
public struct PublisherUserslist: Decodable {
    public let id: Int
    public let full_name: String?
    public let dob: String?
    public let qr_code_url: String?
    public let totalBooks: Int?
//        public let totalBookViews: Any?
    public let totalfollowers: Int?
    public let full_address: String?
//    public let user_data: UserData
//    public let partner_media: [PublisherModelPartnerMedia]
    
}

// MARK: - UserData
public struct UserData: Decodable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String?
    public let fcm_token: String?
    public let is_active: Int
    public let updated_by: Int?

}


// MARK: - PublisherModelPartnerMedia
public struct PublisherModelPartnerMedia: Decodable {
    public let id: Int
    public let partner_media_type_id: Int
    public let url: String
    public let partner_media_type: PartnerMediaType

}

// MARK: - PartnerMediaType
public struct PartnerMediaType: Decodable {
    public let id: Int
//    public let type: String
    public let description: String
    public let is_active: Int?
//    public let created_by: Int?

}

// MARK: - Colorlists
//public struct Colorlists : Decodable{
//    public let the1: String
//    public let the2: String
//    public let the3: String
//    public let the4: String
//    public let the5: String
//    public let the6: String
//
//}


public struct ColorList: Decodable {
    let colorlists: [String: String]
}


struct PublisherList1_Previews: PreviewProvider {
    static var previews: some View{
//        PublisherList()
        ContentView1()
    }
}



struct ContentView1: View {
    @State private var colorList: ColorList?

    var body: some View {
        VStack {
            if let colors = colorList?.colorlists {
                ForEach(colors.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    Rectangle()
                        .fill(Color(hex: value)).cornerRadius(12)
                        .frame(width: 100, height: 100)
                        .overlay(Text(key))
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            guard let url = URL(string: "https://alibrary.in/api/publisherList") else {
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let colorList = try decoder.decode(ColorList.self, from: data)
                    DispatchQueue.main.async {
                        self.colorList = colorList
                    }
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
}

    
//        private enum CodingKeys: String, CodingKey {
//            case totalBookViews
//        }
//
//        public init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            // Try decoding as Int first
//            if let intValue = try? container.decode(Int.self, forKey: .totalBookViews) {
//                totalBookViews = intValue
//            } else {
//                // If it's not an Int, decode as String
//                let stringValue = try container.decode(String.self, forKey: .totalBookViews)
//                totalBookViews = stringValue
//            }
//        }
