//
//  LectureVideoView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 29/04/23.
//

import SwiftUI
import AVKit


// = AVPlayer(url: URL(string: "https://storage.googleapis.com/pdffilesalib/alibpublisher/pdf/video/20230426120844_1_42.mp4")!)
struct LectureVideoView: View {
    var player: AVPlayer?
    @State private var showingImagePermissionAlert = false

    @StateObject var list = BookShowListAudioViewModel()
   
    var body: some View {
        VStack{
            
            if let videoURL = URL(string: "https://www.youtube.com/watch?v=EwLl3-S5zLo") {
            VideoPlayer(player: AVPlayer(url: videoURL))
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 432)
            Spacer()
        }
        }.onAppear{
//            list.getBookShowListData()
        }
        
    }
    
}

struct LectureVideoView_Previews: PreviewProvider {
    static var previews: some View {
        LectureVideoView()
    }
}

struct VideoView: UIViewRepresentable {

    var player: AVPlayer

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player: player)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(player: player)
    }

    class Coordinator: NSObject {
        var player: AVPlayer

        init(player: AVPlayer) {
            self.player = player
            super.init()
        }
    }
}


class PlayerUIView: UIView {
    
    init(player: AVPlayer) {
        super.init(frame: .zero)
        let playerLayer = AVPlayerLayer(player: player)
        layer.addSublayer(playerLayer)
        playerLayer.frame = bounds // set the correct size
        player.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}

import Foundation
import CoreLocation
import Photos

// MARK: - Bookmedia
public struct LectureVideoModel: Decodable {
    public let bookmedias: [LectureVideoBookmedia]

}


// MARK: - Bookmedia
public struct LectureVideoBookmedia: Decodable {
    public let id: Int
    public let book_id: Int
    public let chapter: String
    public let page_from: String
    public let page_to: String
    public let url: String
    public let duration: Int
    public let thumbnail: String?

}



struct VideoPlayerOverlay: View {
    let thumbnailImage: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: thumbnailImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            
            // Additional overlay content
        }
    }
}



struct CustomAlertViews: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
//            Color.black.opacity(0.1)
//                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Custom Alert")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("This is a custom alert message.")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    // Handle button action
                    
                    // Dismiss the alert
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("OK")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
            .frame(width: 300)
        }
//        .edgesIgnoringSafeArea(.all)
    }
}


struct AlertViews: View {
//    let thumbnailImage: UIImage
    @State private var showAlert = false
    var body: some View {
        VStack {
            Button("Show Alert") {
                           showAlert = true
                       }
            Spacer()
            Button("Show Alert") {
                           showAlert = false
                       }
            
            
            // Additional overlay content
        }.fullScreenCover(isPresented: $showAlert, content: {
            
            withAnimation(.easeInOut(duration: 0.3)){
                CustomAlertViews()
            }
        })
    }
}
