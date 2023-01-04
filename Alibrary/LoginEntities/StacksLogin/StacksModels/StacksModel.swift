//
//  StacksModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import Foundation


public struct StacksModel:Decodable {
    public let studentStacks: StudentStacks
}


public struct StudentStacks:Decodable {
    public let data: [StacksDatum]
    public let total: Int
}

public struct StacksDatum:Decodable {
    public let id: Int
    public let stack_book_link: [StackBookLink]
    public let bookcount: Int
    public let stack_book_link_count: Int
    public let stack_detail: StackDetail

   
}

public struct StackBookLink :Decodable{
    public let id: Int
    public let book_url: String
    public let stack_book: StackBook

}

public struct StackBook:Decodable {
    public let id: Int
    public let name: String
    public let title: String
    public let author_name: String
    public let isbn_no: String
    
}

public struct StackDetail:Decodable {
    public let id: Int
    public let name: String
    public let description: String
  
   
}
