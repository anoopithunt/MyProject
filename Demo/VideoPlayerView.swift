//
//  VideoPlayerView.swift
//  Demo
//  Created by Sandeep Kesarwani on 08/08/22.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
//    @State private var player = AVPlayer()
    var body: some View {
        
        VStack {
            ZStack {
                VideoPlayer(player: AVPlayer(url:  URL(string: "https://bit.ly/swswift")!))
                    .frame(height: 300)
              Spacer()
                
                    
                    
                    HStack {
                        Spacer()
                        Text("Live")
                            .padding(.horizontal,8)
                            .background(Color.red)
                            .cornerRadius(6)
                        Label("4.5k", systemImage: "eye")
                            .padding(.horizontal,8)
                            .background(Color(.systemGray4))
                            .cornerRadius(6)
                    }
               
            }
            
        }
        Spacer()
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VideoPlayerView()
            Spacer()
        }
    }
}
