//
//  ImageSliderViews.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 03/12/22.
//

import SwiftUI
import Combine

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
        ImageSlider1()
//        SliderExView()
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


import Foundation

// MARK: - Welcome
public struct SliderModel: Decodable {
    public let bookDetails: [SliderBookDetail]
}

// MARK: - BookDetail
public struct SliderBookDetail: Decodable {
    public let id: Int
    public let name: String
    public let book_media: Book_media
    public let book_category_link: HomeBookCategoryLink
}

public struct Book_media: Decodable{
    public let id: Int
    public let url: String
}

public struct HomeBookCategoryLink: Decodable{
    public let id: Int
    public let sub_category: HomeSubCategory
}
public struct HomeSubCategory: Decodable{
    public let id: Int
    public let category_name: String
}

class SliderViewModel: ObservableObject {
    @Published var datas = [SliderBookDetail]()
    @Published var images = [String]()
    var currentIndex = 0
    let url = "https://www.alibrary.in/api/webhome"
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    init() {
        getData { _ in }
    }

    func getData(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(url)") else {
            completion(.failure(NSError(domain: "SliderViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(SliderModel.self, from: data)
                    DispatchQueue.main.async {
                        self.datas = results.bookDetails
                        self.images = self.datas.map { $0.book_media.url }
                        completion(.success(()))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func startTimer() {
        currentIndex = 0 // Set currentIndex to 0 before starting the timer
//        timer.upstream.connect()
    }

    @objc func updateCurrentIndex() {
        if currentIndex == datas.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
}


class SliderViewModel1: ObservableObject {
//    @Published var datas = [SliderBookDetail]()
    @Published var images = [String]()
    var currentIndex = 0
    let url = "https://www.alibrary.in/api/webhome"
//    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(SliderModel.self, from: data)
                   
                    DispatchQueue.main.async {
                        
//                        self.datas = results.bookDetails
                        for img in  results.bookDetails{
                            self.images.append(img.book_media.url)
                            print(self.images)
                        }
                       
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct SliderExView: View {
    @StateObject var list = SliderViewModel()
    @State private var selection = 0
       let colors: [Color] = [.red, .green, .blue]
       let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack{
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(list.datas, id: \.id) { item in
                            AsyncImage(url: URL(string: item.book_media.url)) { image in
                                image.resizable().frame(width: UIScreen.main.bounds.width, height: 275)
                            } placeholder: {
                                Image("logo_gray").resizable().frame(width: UIScreen.main.bounds.width, height: 245)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .id(UUID())
                        .offset(x: CGFloat(list.currentIndex) * -UIScreen.main.bounds.width, y: 0)
                        .animation(.linear, value: 0)
                    }
                }
            }
        }
        .onAppear {
            list.getData { result in
                if case .success = result {
                    list.startTimer()
                }
            }
        }
        .onDisappear {
            list.timer.upstream.connect().cancel()
        }
        .onChange(of: list.datas) { _ in
            list.startTimer()
        }
        .onReceive(list.timer) { _ in
            list.updateCurrentIndex()
        }
    }
}

extension SliderBookDetail: Equatable {
    public static func ==(lhs: SliderBookDetail, rhs: SliderBookDetail) -> Bool {
        return lhs.id == rhs.id
    }
}


struct ImageSlider1: View {
    @StateObject var list = SliderViewModel1()
    
    var body: some View {
        
        VStack {
            ImageAutoSlider(imageUrls: list.images, autoScrollInterval: 2, animationDuration: 0.2).frame(height: 133)
            
        }.onAppear {
                    list.getData()
        }
    }
}





