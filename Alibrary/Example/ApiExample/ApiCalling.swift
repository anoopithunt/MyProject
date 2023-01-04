//
//  ApiCalling.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 27/07/22.
//

import SwiftUI

struct ApiCalling: View {
    @StateObject private var movieListVM = MovieListViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView{
            List(movieListVM.movies,id:\.imdbId){ movie in
                HStack{
                    AsyncImage(url: movie.poster, content:{ image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100)
                        
                    }, placeholder: {
                        ProgressView()
                    } )
                    Text(movie.title)
                }
                .listStyle(.plain)
                .searchable(text: $searchText)
                .onChange(of: searchText){
                    value in
                    async {
                        if !value.isEmpty && value.count > 3{
                            await movieListVM.search(name: value)
                        } else{
                            movieListVM.movies.removeAll()
                        }
                    }
                }
                
            }
        }
        .navigationTitle("Movie")
    }
}

struct ApiCalling_Previews: PreviewProvider {
    static var previews: some View {
        ApiCalling()
    }
}
