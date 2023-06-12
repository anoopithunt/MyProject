//
//  LectureAudioView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 12/05/23.
//

import SwiftUI
import AVFoundation
import AVFAudio

struct LectureAudioView: View {
    
    @StateObject var list = BookShowListAudioViewModel()
    @State var song1 = false
    @StateObject private var soundManager = SoundManager()
    @State private var showPlayAgainButton = false
    @State private var isComplete = false
    
    var body: some View {
        VStack{

            VStack(alignment: .leading){
                AsyncImage(url: URL(string: list.banner)){ img in
                    img .resizable()
                        .frame(height: 185)
                }placeholder: {
                    Image("logo_gray")
                        .resizable()
                        .frame(height: 185)
                }
                
                Text("Anoop").lineLimit(2).font(.system(size: 22,weight: .regular))
                Text("Published: 2 days ago")
                    .font(.system(size: 17,weight: .regular))
                Text("Like 0")
                    .font(.system(size: 18,weight: .regular))
                MusicBarView(animating: $isComplete)
                    .frame(50)//.padding(.bottom,4)
                HStack{
                
                  Button(action: {
                      isComplete.toggle()
                  }, label: {
                      Text("free").font(.system(size: 22,weight: .bold)).foregroundColor(.red)
                      
                  })
                    Spacer()
                    Text("\(song1 ? soundManager.currentTime.formattedMinuteTimeString() : "00:00")/\(soundManager.duration.formattedMinuteTimeString())")
                        .foregroundColor(.pink)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Image(systemName: song1 ? "pause.circle.fill": "play.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.gray)
                        .background(Color.yellow)
                        .cornerRadius(24)
                        .padding(.trailing)
                        .onTapGesture {
                            soundManager.playSound(sound: list.lecture)
                            song1.toggle()
                            
                            if song1{
                                soundManager.audioPlayer?.play()
                            } else {
                                soundManager.audioPlayer?.pause()
                                
                            }
                            
                        }
                    
                }
            }.padding(8).frame(width: 235)
                .background(Color.orange.backgroundColor(.green))
                .cornerRadius(12)
                .shadow(radius:  32)
            
        }.onAppear{
            list.getBookShowListData()
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { _ in
                showPlayAgainButton = true
                song1 = false
            }
        }
        
    }
    
}



struct LectureAudioView_Previews: PreviewProvider {
    static var previews: some View {
//        LectureExView()
        LectureAudioView()
    }
}

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    private var timer: Timer?
    
    func playSound(sound: String) {
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
            setupTimer()
        }
    }
    
    private func setupTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.audioPlayer else { return }
            self.currentTime = player.currentTime().seconds
            if let duration = player.currentItem?.duration.seconds {
                
                if duration.isFinite {
                    self.duration = duration
                    
                } else {
                    self.duration = 0
                    
                }
                
            } else {
                self.duration = 0
                
            }
        }
    }
}

extension TimeInterval {
    func formattedTimeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? "00:00:00"
    }
    
    func formattedMinuteTimeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? "00:00"
    }
    
}



// MARK: - ShowBookAudioModel
public struct ShowBookAudioModel: Decodable {
    public let bookDetails: ShowBookAudioBookDetails
    public let partner_details: ShowBookAudioPartnerDetails
    public let success: String
    public let data: Int

}




// MARK: - ShowBookAudioBookDetails
public struct ShowBookAudioBookDetails:Decodable {
    public let id: Int
    public let name: String?
    public let tot_pages: Int
    public let title: String?
    public let author_name: String?
    public let isbn_no: String?
    public let size: String?
    public let validity_date: String?
    public let category_name: String
    public let subcategory_name: String
    public let bookowner: String
    public let is_school_owned: Int
    public let protectedpdf: String
    public let pdfcount: Int
    public let thumbnail: String?
    public let upload_type_name: String?
    public let published: String?
    public let is_purchased: Int?
    public let partBookRC: String?
    public let rc_enddate: String?
    public let current_time: String?
    public let demo_book_page: ShowBookAudioDemoBookPage
    public let partner_name: ShowBookAudioPartnerName
    public let book_media: ShowBookAudioPurpleBookMedia
    public let book_category_link: ShowBookAudioBookCategoryLink
    public let book_medias: [ShowBookAudioBookMediaElement]
    public let book_partner_link: ShowBookAudioBookPartnerLink
    public let upload_type: ShowBookAudioUploadType

}

// MARK: - ShowBookAudioBookCategoryLink
public struct ShowBookAudioBookCategoryLink:Decodable {
    public let id: Int
    public let category: ShowBookAudioCategory
    public let sub_category: ShowBookAudioSubCategory

}

// MARK: - ShowBookAudioCategory
public struct ShowBookAudioCategory:Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String

}

// MARK: - ShowBookAudioSubCategory
public struct ShowBookAudioSubCategory:Decodable {
    public let id: Int
    public let category_name: String
    public let description: String

}

// MARK: - ShowBookAudioPartnerBookrc
public struct ShowBookAudioPartnerBookrc: Decodable{
    public let id: Int
    public let rc_enddate: String

}

// MARK: - ShowBookAudioPurpleBookMedia
public struct ShowBookAudioPurpleBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let url: String

}

// MARK: - ShowBookAudioBookMediaElement
public struct ShowBookAudioBookMediaElement:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let url: String
    public let book_media_type: String
    public let media_type: String

}

// MARK: - ShowBookAudioBookPartnerLink
public struct ShowBookAudioBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int

}

// MARK: - ShowBookAudioDemoBookPage
public struct ShowBookAudioDemoBookPage:Decodable {
    public let id: Int
    public let url: String
}

// MARK: - ShowBookAudioPartnerName
public struct ShowBookAudioPartnerName: Decodable {
    public let id: Int
    public let full_name: String
    public let partner_role: ShowBookAudioPartnerRole

}

// MARK: - ShowBookAudioPartnerRole
public struct ShowBookAudioPartnerRole:Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String

}

// MARK: - ShowBookAudioUploadType
public struct ShowBookAudioUploadType:Decodable {
    public let id: Int
    public let name: String
    public let description: String

}

// MARK: - ShowBookAudioPartnerDetails
public struct ShowBookAudioPartnerDetails:Decodable {
    public let id: Int
    public let full_name: String
    public let partnerPlan: String
    public let rcCount: Int
    public let role: String
    public let prctype: String
    public let nprctype: String

}

//MARK: - View Model

class BookShowListAudioViewModel: ObservableObject{
   
    @Published var books = [ShowBookAudioBookMediaElement]()
    @Published var booksdetails:ShowBookAudioBookDetails?
    @Published var lecture = String()
    @Published var video: String?
    @Published var banner = String()
    @Published var totalPage = Int()
    @Published var currentPage = 1
    @Published var noBooks:Bool = false
    func getBookShowListData() {
        let apiurl = "https://www.alibrary.in/api/student/show-book?id=4072&page=\(currentPage)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: ShowBookAudioModel.self, token: token){ (result) in
            switch result {
                case .success(let results):
                DispatchQueue.main.async { [self] in
//                        if !results..data.isEmpty{
                    self.booksdetails = results.bookDetails
                        self.books = results.bookDetails.book_medias
                        for audio in books {
                            if audio.media_type == "audio"{
                                self.lecture = audio.url
                            }
                            else if  audio.media_type == "image"{
                                self.banner = audio.url
                               
                            }
                            else{
                                self.video = audio.url
                                print(self.video ?? "hello Video is null")
                            }
                        }
//                    print(self.booksdetails as Any)
//
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}


import PureSwiftUI

private let numBars = 5
private let spacerWidthRatio: CGFloat = 0.2
private let barWidthScaleFactor = 1 / (numBars.asCGFloat + (numBars - 1).asCGFloat * spacerWidthRatio)

struct MusicBarView: View {
    
    @Binding var animating:Bool //= false
    
    var body: some View {
        VStack{
            GeometryReader { (geo: GeometryProxy) in
                let barWidth = geo.widthScaled(barWidthScaleFactor)
                let spacerWidth = barWidth * spacerWidthRatio
                HStack(spacing: spacerWidth) {
                    ForEach(0..<numBars) { index in
                        Bar(minHeightFraction: 0.1, maxHeightFraction: 1, completion: animating ? 1 : 0)
                            .fillColor(.green)
                            .width(barWidth)
                            .animation(animating ? createAnimation() :  nil)
                    }
                    
                }
            }
            .onAppear {
                animating = true
            }
            
        }
    }
    
    private func createAnimation() -> Animation {
        Animation
            .easeInOut(duration: 0.8 + Double.random(in: -0.3...0.3))
            .repeatForever(autoreverses: true)
            .delay(Double.random(in: 0...4))
    }
}

private struct Bar: Shape {
    
    private let minHeightFraction: CGFloat
    private let maxHeightFraction: CGFloat
    var animatableData: CGFloat
    
    init(minHeightFraction: CGFloat, maxHeightFraction: CGFloat, completion: CGFloat) {
        self.minHeightFraction = minHeightFraction
        self.maxHeightFraction = maxHeightFraction
        self.animatableData = completion
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let heightFraction = minHeightFraction.to(maxHeightFraction, animatableData)
        
        path.rect(rect.scaled(.size(0.6, heightFraction), at: rect.bottomLeading, anchor: .center))
        
        return path
    }
}


struct LectureExView: View {
    @State var play: Bool = true
    var body: some View {
        MusicBarView(animating: $play)
            .frame(50)
//            .greedyFrame()
//            .ignoresSafeArea()
    }
   
}
