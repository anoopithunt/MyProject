//
//  MagzineBannerModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/09/22.
//

import Foundation

public struct MagazineModel: Decodable {
        public let magzineBanners: [MagzineBanner]
    
  
}

public struct MagzineBanner: Decodable, Identifiable {
    public let id: Int
    public let url: String

}
