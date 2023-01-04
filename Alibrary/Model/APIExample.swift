//
//  APIExample.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/07/22.
//

import SwiftUI

struct APIExample: View {
    
    @State var results = [TaskEntry]()
        
        func loadData() {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
                print("Your API end point is Invalid")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([TaskEntry].self, from: data) {
                        DispatchQueue.main.async {
                            self.results = response
                        }
                        return
                    }
                }
            }.resume()
        }
        
        var body: some View {
            List(results, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                        .foregroundColor(.red)
                }
            }.onAppear(perform: loadData)
    }
}

struct APIExample_Previews: PreviewProvider {
    static var previews: some View {
                APIExample()
           
    }
}
