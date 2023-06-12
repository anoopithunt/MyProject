//
//  MagazineBannerView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 28/03/23.
//

import SwiftUI

struct MagazineBannerView: View {
    @StateObject var list = MagazineBannerVM()
    var body: some View {
        VStack{
            ImageAutoSlider(imageUrls: list.images, autoScrollInterval:2, animationDuration: 0.8).frame(height: 122)
        
        }
       
    }
}

struct MagazineBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MagazineBannerView()
    }
}



public struct MagazineModel: Decodable {
        public let magzineBanners: [MagzineBanner]
    
  
}

public struct MagzineBanner: Decodable, Identifiable {
    public let id: Int
    public let url: String

}


class MagazineBannerVM: ObservableObject{
    @Published var datas = [MagzineBanner]()
    @Published var images = [String]()
//    var currentIndex = 0
    let url = "https://www.alibrary.in/api/webhome"

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
