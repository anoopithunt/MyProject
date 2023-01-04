//
//  CorouserView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 05/07/22.
//

import SwiftUI
//import SDWebImageSwiftUI
//
//
//struct CorouserViewQ: View {
////   let categoryName: String!
//
//    @ObservedObject var list = HomePageCorouselVM()
//    func getScale(proxy: GeometryProxy) -> CGFloat {
//        let midPoint: CGFloat = 205
//
//        let viewFrame = proxy.frame(in: CoordinateSpace.global)
//
//        var scale: CGFloat = 1.0
//        let deltaXAnimationThreshold: CGFloat = 115
//
//        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
//        if diffFromCenter < deltaXAnimationThreshold {
//            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 440
//        }
//
//        return scale
//    }
//
//
//    var body: some View  {
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack( alignment: .center, spacing: 50){
//                    ForEach(list.datas, id: \.self){ item in
//                        GeometryReader {     proxy in
//                            let scale = getScale(proxy: proxy)
//
//                            VStack {
//                                Text(item.title)
//                                    .bold()
//                                    .font(.system(size: 15))
//                                    .foregroundColor(.white)
//                                Text(item.subcategory_name)
////                                    .bold()
//                                    .font(.system(size: 15))
//                                    .foregroundColor(.white)
//
//
//
//                                ZStack{
//
//
//
//                                    WebImage(url: URL(string: item.url)!, options: .highPriority, context: nil)
//                                        .placeholder{Image("logo_gray").resizable()}
//                                        .resizable()
//                                        .opacity(0.3)
//                                        .frame(width: 150, height: 200)
//                                        .rotation3DEffect(.degrees(180), axis: (x: -10, y: 0, z: 0))
//                                        .rotationEffect(.radians(.pi))
//                                        .padding(.top,70)
//                                        .cornerRadius(5)
//                                        .frame(width: 150, height: 270)
//
//
//                                    WebImage(url: URL(string: item.url)!, options: .highPriority, context: nil)
//                                        .placeholder{
//                                            Image("logo_gray").resizable()
//                                        }.resizable()
//                                        .padding(.bottom,40)
//                                        .frame(width: 150, height: 270)
//                                        .cornerRadius(5)
//
//
//                                }
//                            }
//                            .scaleEffect(CGSize(width: scale, height: scale/1.2))
//                                    .animation(.linear(duration: 0.1), value: 2)
//
//
//
//
//                        }
//                        .frame(width: 125, height: 300)
//                        .padding(.horizontal,18)
//
//
//
//                    }
//
//            }
//                .padding(32)
//
//
//
//        }
//
//
//        }
//
//
//
//}

struct CorouserView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
        CorouserView()
       
//        Spacer()
        
        }
        
    }
}



struct CorouserView: View {
//   let categoryName: String!
    
    @ObservedObject var list = HomePageCorouselViewModel(_httpUtility: HttpUtility())
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 205
         
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
         
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 115
         
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 440
        }
         
        return scale
    }
    var body: some View  {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack( alignment: .center, spacing: 50){
                ForEach(list.datas, id: \.id){ item in
                    GeometryReader {proxy in
                        let scale = getScale(proxy: proxy)
                        VStack {
                            Text(item.subcategory_name)
                                .bold()
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                            Text(item.title)
//                                    .bold()
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                            ZStack{
                                AsyncImage(url: URL(string: item.url)){
                                    image in
                                    image.resizable()
                                        .frame(width: 150, height: 200).opacity(0.1)
                                        .rotation3DEffect(.degrees(180), axis: (x: -10, y: 0, z: 0))
                                        .rotationEffect(.radians(.pi))
                                        .padding(.top,70)
                                        .cornerRadius(5)
//                                            .frame(width: 150, height: 270)
                                        
                                }placeholder: {
                                    
                                }
                                AsyncImage(url: URL(string: item.url)){
                                    image in
                                    NavigationLink(destination: ShowBooksDetailsView(bookTitle: item.subcategory_name, id: "\(item.id)")
                                        .navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)){
                                            image.resizable()
                                                .padding(.bottom,40)
                                                .frame(width: 150, height: 270)
                                                .cornerRadius(5)
                                            
                                        }
                                    
                                }placeholder: { Image("logo_gray").resizable().frame(width: 150, height: 270)
                                    
                                }
//                                        }
                        }
                            
                        }.scaleEffect(CGSize(width: scale, height: scale/1.2))
                                    .animation(.linear(duration: 0.1), value: 2)
                          
                    }.frame(width: 125, height: 300)
                        .padding(.leading,18)
                    
                }
                
            }.padding(32)
            
        }.onAppear{
                list.getData()
            
        }
        
    }
    
}
