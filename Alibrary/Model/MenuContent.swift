//
//  MenuContent.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 13/07/22.
//

import Foundation

class MenuContent: Identifiable, ObservableObject {
    var id = UUID()
    var name: String = ""
    var image: String = ""
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
