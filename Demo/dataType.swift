//
//  dataType.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 09/08/22.
//

    import Foundation
   
    struct dataType: Identifiable{
       
        var id = UUID()
        var totalBooks: String
        var full_name: String
        var totalBookViews: String
        var totalfollowers: String
        var partner_media: Partner_Media?
        
     
       
  
       
    }

struct Partner_Media: Codable{
    var id = UUID()
    
    
    var url: String
    
}




