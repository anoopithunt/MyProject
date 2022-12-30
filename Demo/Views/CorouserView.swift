//
//  CorouserView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 07/01/23.
//

import SwiftUI

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
                        GeometryReader {     proxy in
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



                                    AsyncImage(url: URL(string: item.url)){image in
                                        image.resizable().frame(width: 150, height: 200).opacity(0.1).rotation3DEffect(.degrees(180), axis: (x: -10, y: 0, z: 0))
                                            .rotationEffect(.radians(.pi))
                                            .padding(.top,70)
                                            .cornerRadius(5)
//                                            .frame(width: 150, height: 270)

                                    }placeholder: {

                                    }
                                    
                                            AsyncImage(url: URL(string: item.url)){image in
                                                image.resizable()
                                                    .padding(.bottom,40)
                                                    .frame(width: 150, height: 270)
                                                    .cornerRadius(5)
                                            }placeholder: {
                                                Image("logo_gray").resizable().frame(width: 150, height: 270)
                                            }
                                      
                                }
                            }
                            .scaleEffect(CGSize(width: scale, height: scale/1.2))
                                    .animation(.linear(duration: 0.1), value: 2)




                        }
                        .frame(width: 125, height: 300)
                        .padding(.leading,18)



                    }

            }
                .padding(32)



        }.onAppear{
            list.getData()
        }


        }



}

struct CorouserView_Previews: PreviewProvider {
    static var previews: some View {
        CorouserView()
    }
}
import SwiftUI


class HomePageCorouselViewModel: ObservableObject {
    
    @Published var datas = [BookDetailModel]()
    
    private let httpUtility: HttpUtility
    
    init(_httpUtility: HttpUtility) {
        httpUtility = _httpUtility
        
    }
    
    func getData()
    {
        let apiUrl = "https://www.alibrary.in/api/web-home"
        //            let apiUrl = ApiUtils.searchBooksCollectionApiurl!
//        let params = "\(self.currentPage)"
        let request = URLRequest(url: URL(string: apiUrl)!)
        
//        request.httpMethod = "GET"
//        request.httpBody = params.data(using: .utf8)
        httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: BookDetailCorouselModel.self) { (results) in
            DispatchQueue.main.async {
                self.datas = results.bookDetails
                
                
            }
            
            
            
        }
    }
}


struct exa: View{
    @StateObject var list = HomePageCorouselViewModel(_httpUtility: HttpUtility())
    var body: some View{
        VStack{
            
                ScrollView(.horizontal){
                    HStack{
                    ForEach(list.datas, id: \.id){ item in
                        AsyncImage(url: URL(string: item.url)).frame(width: 125, height: 225)
                    }
                }
            }
        }.onAppear{
            list.getData()
        }
    }
}







//public struct BookDetail: Identifiable, Hashable {
//    public let id: String
//    public let title: String
//    public let url: String
////    public let categoryName: String
//    public let subcategory_name: String
//
//    public init(id: String, url: String, subcategory_name: String, title: String) {
//        self.id = id
//        self.title = title
//        self.url = url
////        self.categoryName = categoryName
//        self.subcategory_name = subcategory_name
//    }
//
//}

public struct BookDetailCorouselModel:Decodable {
    public let bookDetails: [BookDetailModel]

}



public struct BookDetailModel: Decodable {
    public let id: Int
    public let title: String
    public let url: String
    public let category_name: String
    public let subcategory_name: String

  

}
