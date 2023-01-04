//
//  Movie.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 27/07/22.
//

import Foundation

struct MovieResponse: Decodable{
    let movies: [Movie]
    private enum CodingKeys: String, CodingKey{
        case movies = "search"
    }
}




struct Movie: Decodable {
    
    let imdbID: Int!
    let title: String!
    let poster: String!
    private enum CodingKeys: String, CodingKey{
        case imdbID = "imdbID"
        case title = "Title"
        case poster = "Poster"
    }
    
}
