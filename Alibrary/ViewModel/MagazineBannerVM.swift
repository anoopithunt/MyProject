//
//  MagazineBannerVM.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/09/22.
//

import Foundation
//import SwiftUI
//import SwiftyJSON



//class MagazineBannerVM: ObservableObject{
//    @Published var datas = [MagzineBanner]()
//    init(){
//        let source = "https://www.alibrary.in/api/web-home"
//        let url = URL(string: source)!
//        let session = URLSession(configuration: .default)
//
//        session.dataTask(with: url){
//            (data, _, err) in
//            if err != nil{
//                print(err?.localizedDescription ?? "Hello Error")
//                return
//            }
//
//            let json = try!JSON(data: data!)
//            for i in json["magzineBanners"]{
//                let url = i.1["url"].stringValue
//
//                DispatchQueue.main.async {
//                    self.datas.append(MagzineBanner( bannerUrl: url))
//                }
//
//            }
//
//        }
//        .resume()
//    }
//
//
//}
//


class MagazineBannerVM: ObservableObject{
    @Published var datas = [MagzineBanner]()
    @Published var images = [String]()
//    var currentIndex = 0
    let url = "https://www.alibrary.in/api/web-home"

    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(MagazineModel.self, from: data)
                   
                    DispatchQueue.main.async {
                        
                        self.datas = results.magzineBanners
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

