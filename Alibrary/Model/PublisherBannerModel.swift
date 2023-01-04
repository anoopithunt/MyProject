//
//  PublisherBannerModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/09/22.
//

import SwiftUI
import Foundation


public struct BannerModel: Decodable , Hashable{
    public let publisherBanners: [PublisherBanners]


}

public struct PublisherBanners: Decodable, Hashable, Identifiable {
    public let id: Int
    let url: URL
}
