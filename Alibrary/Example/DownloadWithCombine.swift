//
//  DownloadWithCombine.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 18/07/22.
//

import SwiftUI

struct DownloadWithCombine: View {
    @State var results = [TaskEntry]()
        
        func loadData() {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
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

                       AsyncImage(url: URL(string: item.url))
                           .frame(width: 200, height: 200)
                           .padding()
              

                   }
            
                   .background(Color.gray.opacity(0.5))
                   .cornerRadius(12)
                   .frame( width:UIScreen.main.bounds.width-84, alignment: .center)
                   
               }
        .onAppear(perform: loadData)

           
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
