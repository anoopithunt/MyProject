//
//  MainBannerModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/22.
//

import Foundation
struct MainBannerModel: Decodable{
    var mainBanners: [MainBanners]
  
}
struct MainBanners:Decodable{
    public var id: Int
    public var url: String
}
