//
//  ImageAutoSlider.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 13/04/23.
//
import SwiftUI
import Combine

// When We want to set the images as auto slider images like gallery in android then we must store the data in an array then we use this View
// Syntax of the Auto Slider is :-  ImageAutoSlider(imageUrls: list.images, autoScrollInterval: 4, animationDuration: 1)

// imageUrls this is an array where stores the images and list.images = this is list is object of view model and images is array of string where stores all images.
// autoScrollInterval = this is auto scroll interval time
// animationDuration = this is auto animation duration time



struct ImageAutoSlider: View {
    let imageUrls: [String]
    let autoScrollInterval: TimeInterval
    let animationDuration: TimeInterval
    
    @State private var currentIndex = 0
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    
    init(imageUrls: [String], autoScrollInterval: TimeInterval = 3, animationDuration: TimeInterval = 0.6) {
        self.imageUrls = imageUrls
        self.autoScrollInterval = autoScrollInterval
        self.animationDuration = animationDuration
        self.timer = Timer.publish(every: autoScrollInterval, on: .main, in: .common).autoconnect()
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: 0) {
                    ForEach(0..<imageUrls.count, id: \.self) { index in
                        let imageUrl = imageUrls[index]
                        GeometryReader { geometry in
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width)
                            } placeholder: {
                                Image("logo_gray")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width)
                            }
                            .offset(x: CGFloat(index - currentIndex) * UIScreen.main.bounds.width, y: 0)
                            .animation(.linear(duration: animationDuration))
                        }
                    }
                }
//                .frame(width: UIScreen.main.bounds.width)
                .onAppear {
                    scrollViewProxy = proxy
                }
                .onChange(of: currentIndex) { _ in
                    scrollViewProxy?.scrollTo(currentIndex, anchor: .leading)
                }
            }
        }
        .onReceive(timer) { _ in
            currentIndex = currentIndex < imageUrls.count - 1 ? currentIndex + 1 : 0
        }
    }
}



//struct ImageAutoSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageAutoSlider()
//    }
//}
