//
//  NewsAPIView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 08/08/22.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
//View Show on Screen
struct NewsAPIView: View {
    @ObservedObject var list = getData()
    var body: some View {
        NavigationView{
            List(list.datas){ i in
        
                NavigationLink(destination:
                                VideoPlayerView()

                    .navigationBarTitle("This is News Result", displayMode: .inline)
                ){
                    HStack(spacing: 15){
                        VStack(alignment: .leading, spacing: 10){
                            Text(i.full_name)
                                .fontWeight(.heavy)
                                .foregroundColor(.yellow)
                            Text(i.totalBookViews)
                                .fontWeight(.heavy)
                                .foregroundColor(.orange)
                            Text("\(i.totalfollowers)")
                                .foregroundColor(.green)
                            Text("\(i.totalBooks)")
                                .foregroundColor(.red)


                        }.padding()
              
                    }
                    .padding(.vertical,15)
                  
                }
                .padding(.vertical,15)
                .cornerRadius(22)
            }
//            }
            .navigationBarTitle("Headlines")
        }
    }
}

struct NewsAPIView_Previews: PreviewProvider {
    static var previews: some View {
        NewsAPIView()
    }
}

// Model

//Fetching Data from Api Through Class In swiftui

class getData: ObservableObject{
    @Published var datas = [dataType]()
    init(){
        let source = "https://alibrary.in/api/publisherList"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
   
        session.dataTask(with: url){
            (data, _, err) in
            if err != nil{
                print(err?.localizedDescription ?? "Hello Error")
                return
            }
            
            let json = try!JSON(data: data!)
            for i in json["userslist"]{
                let totalBookViews = i.1["totalBookViews"].stringValue
                let full_name = i.1["full_name"].stringValue
                let totalBooks  = i.1["totalBooks"].stringValue
                let totalfollowers  = i.1["totalfollowers"].stringValue
//                let name = i.1["name"].stringValue
                let url = i.1["url"].stringValue
                
                
               
         
               
               
                DispatchQueue.main.async {
                 
                    self.datas.append(dataType(totalBooks: totalBooks, full_name: full_name, totalBookViews: totalBookViews, totalfollowers: totalfollowers, partner_media: Partner_Media.init( url: url)))
                    
                }
               
            }
               
        }
        .resume()
    }


}



//                            WebImage(url: URL(string: "https://www.google.com/search?q=ios+image&rlz=1C5CHFA_enIN1012IN1012&sxsrf=ALiCzsabuw2xwVunnSsHDIrO-nT4bcrIjw:1660119858872&source=lnms&tbm=isch&sa=X&ved=2ahUKEwit0eOz7Lv5AhU_2HMBHWGIAUEQ_AUoAXoECAEQAw&biw=1423&bih=721&dpr=2#imgrc=ZuRQECQETuddFM")!, options: .highPriority, context: nil)
//                                .resizable()
//                                .frame(width:120, height: 135)
//                                .cornerRadius(20)
