//
//  ImageSliderViews.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 03/12/22.
//

import SwiftUI

struct ImageSliderViews: View {
    @StateObject var list = Base64ViewModel()
    var body: some View {
    
        
        
        VStack {
            VStack{
                ScrollView{
                    ForEach(list.datas, id: \.self){ item in
                        let category = item.category.base64Decoded()
                        let correct_answer = item.correct_answer.base64Decoded()
                        
                        let incorrectAnswers = item.incorrect_answers
                       
                        Text(category ?? "Something Error").foregroundColor(.yellow).font(.system(size: 30))
                        Text(item.question.base64Decoded()!).foregroundColor(.teal).bold()
                        HStack{
                            
                            ForEach(incorrectAnswers, id: \.self){ itemIndex in
                                Text(itemIndex.base64Decoded()!).font(.system(size: 12, weight: .heavy))
                                
                            }
                            
                            Text("**\(correct_answer!)**").foregroundColor(.red).bold()
                            Spacer()
                        }.padding()
                        
                    }.border(.green, width: 4).padding()
                }
            }
        }
    }
}

struct ImageSliderViews_Previews: PreviewProvider {
    static var previews: some View {
        ImageSliderViews()
    }
}


import Foundation

public struct Base64Model:Decodable {
    public let results: [Result1]

}

public struct Result1:Decodable, Hashable {
    public let category: String
    public let type: String
    public let difficulty: String
    public let question: String
    public let correct_answer: String
    public let incorrect_answers: [String]

}


class Base64ViewModel: ObservableObject{

    @Published var datas = [Result1]()
       let url = "https://opentdb.com/api.php?amount=50&encode=base64"
       
       init() {
           getData(url: url)
       }
       
       
       func getData(url: String) {
           guard let url = URL(string: "\(url)") else { return }
           URLSession.shared.dataTask(with: url) { (data, _, _) in
               if let data = data {
                   do {
                       let results1 = try JSONDecoder().decode(Base64Model.self, from: data)
                       DispatchQueue.main.async {
                           self.datas = results1.results
                           print(self.datas.startIndex)
                         
                       }
                   }
                   catch {
                       print(error)
                   }
               }
           }.resume()
       }
}


extension Data {
    /// Same as ``Data(base64Encoded:)``, but adds padding automatically
    /// (if missing, instead of returning `nil`).
    public static func fromBase64(_ encoded: String) -> Data? {
        // Prefixes padding-character(s) (if needed).
        var encoded = encoded;
        let remainder = encoded.count % 4
        if remainder > 0 {
            encoded = encoded.padding(
                toLength: encoded.count + 4 - remainder,
                withPad: "=", startingAt: 0);
        }

        // Finally, decode.
        return Data(base64Encoded: encoded);
    }
}

extension String {
    public static func fromBase64(_ encoded: String) -> String? {
        if let data = Data.fromBase64(encoded) {
            return String(data: data, encoding: .utf8)
        }
        return nil;
    }
}



