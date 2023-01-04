//
//  ExploreCategoriesModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/10/22.
//

import Foundation
public struct CategoryModel:Decodable {
    public let bookcategories: [Bookcategory]
}


public struct Bookcategory: Decodable, Hashable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String

}

public struct ExploreModel: Decodable {
    public let bookcategory: ExploreBookcategory
    public let bookDetails: [ExploreBookDetail]
    let subcategorycol: [Subcategorycol]
    public let subCategoryname: String
    public var categoryBooks: CategoryBooks
}


public struct ExploreBookDetail: Decodable, Hashable {
    public let id: Int
    public let name: String
    public let book_media: BookMedia
}
public struct ExploreBookcategory: Decodable{
    public let id: Int
    public let category_name: String
    public let desc_by: String
    public let description: String
    public let banner: String
    
}
public struct BookMedia: Decodable, Hashable{
    public var id: Int
    public let url: String
}
struct Subcategorycol: Decodable, Hashable{
        public let id: Int
        public let category_name: String
}
public struct CategoryBooks: Decodable {
    public var data: [ListBookDetails]
    public var next_page_url: String?
    public var path: String
}
public struct ListBookDetails: Decodable,Hashable{

    var book_media: BookMediaDetails
   
}
public struct BookMediaDetails: Decodable,Hashable{
    var id:Int
    var url:String
    
}
