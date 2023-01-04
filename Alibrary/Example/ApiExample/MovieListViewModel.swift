//
//  MovieListViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 27/07/22.
//

import Foundation
@MainActor
class MovieListViewModel: ObservableObject{
    @Published var movies: [MovieViewModel] = []
    func search(name: String) async {
        do{
            let movies = try await WebService().getMovies(searchTerm: name)
            self.movies = movies.map(MovieViewModel.init)
        }
        catch{
            print(error)
        }
    }
}

struct MovieViewModel {
    let movie: Movie
   
    var imdbId: Int {
       movie.imdbID
    }
    var title: String {
        movie.title
    }
    var poster: URL?{
        URL(string: movie.poster)
    }
}
