//
//  WebService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 27/07/22.
//

import Foundation
enum NetworkError: Error{
    case badURL
    case badID
}

class WebService {
    
    
    func getMovies(searchTerm: String) async throws -> [Movie] {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "omdbapi.com"
        components.queryItems = [
        URLQueryItem(name: "s", value: searchTerm.trimmed()),
        URLQueryItem(name: "apikey", value: "564727fa")
        
]
guard let url = components.url else {
    throw NetworkError.badURL
}
   
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
        throw NetworkError.badID
    }
    let movieResponse = try?JSONDecoder().decode(MovieResponse.self, from: data)

    return movieResponse?.movies ?? []
}
    }

