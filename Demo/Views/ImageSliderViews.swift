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
        ImageSlider()
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
    public let title: String
    public let url: String
}

class SliderViewModel: ObservableObject {
    @Published var datas = [SliderBookDetail]()
    @Published var images = [String]()
    var currentIndex = 0
    let url = "https://www.alibrary.in/api/web-home"
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
                        self.images = self.datas.map { $0.url }
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
        timer.upstream.connect()
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
    @Published var datas = [SliderBookDetail]()
    @Published var images = [String]()
    var currentIndex = 0
    let url = "https://www.alibrary.in/api/web-home"
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

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
                        
                        self.datas = results.bookDetails
                        for img in self.datas{
                            self.images.append(img.url)
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
                            AsyncImage(url: URL(string: item.url)) { image in
                                image.resizable().frame(width: UIScreen.main.bounds.width, height: 215)
                            } placeholder: {
                                Image("logo_gray").resizable().frame(width: UIScreen.main.bounds.width, height: 215)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .id(UUID())
                        .offset(x: CGFloat(list.currentIndex) * -UIScreen.main.bounds.width, y: 0)
                        .animation(.linear)
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


struct ImageSlider: View {
    @StateObject var viewModel = SliderViewModel1()
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { scrollView in
                    LazyHStack(spacing: 0) {
                        ForEach(viewModel.images, id: \.self) { imageUrl in
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .frame(width: geometry.size.width, height: geometry.size.height/3)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: geometry.size.width, height: geometry.size.height/3)
                            }
                        }
                    }
                    .onChange(of: currentIndex) { value in
                        withAnimation {
                            scrollView.scrollTo(value, anchor: .center)
                        }
                    }
                }
                .frame(height: geometry.size.height)
                .onAppear {
                    viewModel.getData()
                    startTimer()
                }
            }
        }
        .onReceive(timer) { _ in
            currentIndex = currentIndex < viewModel.images.count - 1 ? currentIndex + 1 : 0
        }
    }
    
    func startTimer() {
        timer.upstream.connect().cancel()
    }
}

