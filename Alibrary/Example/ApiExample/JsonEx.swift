//
//  JsonEx.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/07/22.
//
import Foundation
import SwiftUI

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
}




struct JsonEx: View {
    @ObservedObject var networkManager = NetworkManager()

       // return the title of the second item in the `posts` array
       var title: String {
           guard networkManager.posts.count >= 2 else {
//               // decide what to do when data is not yet loaded or count is <= 1
               return "Loading..."
           }
//           return networkManager.posts[7].title
           return networkManager.posts[4].title
       }

       var body: some View {
         
               Text(title)


           .onAppear {
               self.networkManager.fetchData()
           }
       }
    
    }

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

struct JsonEx_Previews: PreviewProvider {
    static var previews: some View {
        JsonEx()
    }
}
