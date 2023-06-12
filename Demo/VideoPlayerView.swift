//
//  VideoPlayerView.swift
//  Demo
//  Created by Anup Kumar Mishra on 08/08/22.
//

import SwiftUI
import AVKit
import YouTubePlayerKit

struct VideoPlayerView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale
    @State var player = AVPlayer()
//    var player: AVPlayer
    var body: some View {
        VStack {
            Spacer()
            //         GeometryReader { proxy in
            //             VideoPlayer(player: player)
            //                 .ignoresSafeArea()
            //                 .frame(width: proxy.size.width, height: proxy.size.height/3.5)
            //                 .onAppear() {
            //                     player.isMuted = true
            //                     player.play()
            //                 }
            //         }
            VideoPlayer(player: AVPlayer(url: URL(string: "https://storage.googleapis.com/pdffilesalib/alibpublisher/pdf/video/20230426120844_1_42.mp4")!))
                .frame(height: 250)
            //         VideoPlayer(player: AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=EwLl3-S5zLo")!))
            //  WWDC 2019 Keynote
            YouTubePlayerView(
                "https://youtube.com/watch?v=EwLl3-S5zLo"){ state in
                    // Overlay ViewBuilder closure to place an overlay View
                    // for the current `YouTubePlayer.State`
                    switch state {
                    case .idle:
                        Image("soft").resizable()
                            .frame(height: 250)
                    case .ready:
                        EmptyView()
                    case .error(_):
                        Text(verbatim: "YouTube player couldn't be loaded")
                    }
                }
                .frame(height: 250)
            VideoPlayer(player: player)
                .onAppear() {
                    player = AVPlayer(url: URL(string: "http://youtube.com/watch?v=psL_5RIBqnY")!)
                }
            Spacer()
            
            Text(locale.description)
            Text(calendar.description)
            Text(horizontalSizeClass == .compact ? "Compact": "Regular")
            Text(colorScheme == .dark ? "Dark mode" : "Light mode")
            Spacer()
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(player: AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=EwLl3-S5zLo")!))
    }
}

//struct VideoPlayerView1: UIViewControllerRepresentable {
//    var videoURL: URL
//
//    func makeUIViewController(context: Context) -> AVPlayerViewController {
//        let player = AVPlayer(url: videoURL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        return playerViewController
//    }
//
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//        // No update needed
//    }
//}
//VideoPlayerView1(videoURL: URL(string: "https://www.youtube.com/watch?v=EwLl3-S5zLo")!)
//            .frame(width: 400, height: 300)

