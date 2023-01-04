//
//  GuestLibraryModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation

// MARK: - GuestLibraryModel
struct GuestLibraryModel: Decodable{
    var  guestPDFCount :Int
    var  guestStackCount: Int
    var  ownPDFCount: Int
    var  ownStackCount: Int
    var  success: String
    var  data:Int
}
