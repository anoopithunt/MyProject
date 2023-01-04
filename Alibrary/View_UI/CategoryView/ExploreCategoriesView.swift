//
//  ExploreCategoriesView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/10/22.
//

import SwiftUI

struct ExploreCategoriesView: View {
    @StateObject var list = CategoriesVM()
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
      }
    @State var isLinkActive = false
    var body: some View {
        
//      NavigationView {
           
                ZStack {
                    Image("u").resizable().frame(width: UIScreen.main.bounds.width).ignoresSafeArea()
               
                    VStack {
//                        Spacer(minLength: 32)
//                        HStack(spacing: 25){
//                            Image(systemName: "arrow.left").font(.system(size: 28))
//                            
//                            Text("Explore Category").font(.system(size: 28))
//                            Spacer()
//                        }.padding(.horizontal).frame(height: 75).background(Color("orange")).foregroundColor(.white)
                        ScrollView(.vertical,showsIndicators: false){
                            VStack {
                        HStack{
                            Image("c_a").resizable().frame(width: 90, height: 95).padding()
                            Text("All Categories").foregroundColor(Color("default_")).font(.largeTitle).fontWeight(.semibold).tint(.red)

                        }
                        Text("Here you will see all types of categories, within whivh things like sub categories are present, so that it is easier to find your things").font(.headline).foregroundColor(Color("default_")).multilineTextAlignment(.leading).lineLimit(3).padding(.horizontal, 30.0)
                        Image("c_b").resizable().frame(width: UIScreen.main.bounds.width*0.9,height: 200).padding()

                    }
                    Spacer()
                        LazyVGrid(columns: items, spacing: 10) {
                                ForEach(list.datas, id: \.id){ item in
                                    NavigationLink(destination: CategoriesView(sentid: "\(item.id)").navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)){
                                        AsyncImage(url: URL(string: item.url)){image in
                                            image
                                                .resizable().frame( height: 45).cornerRadius(10)
                                            
                                        }placeholder: {
//                                            Image("").resizable().frame(width: UIScreen.main.bounds.width/2.2, height: 45).cornerRadius(10)
                                        }
                                    }
                                    
                                }
                                

                            
                        } .padding(.horizontal)
                }
                    }
            
                }
//        }
     
        }
    }
    
  


class CategoriesVM: ObservableObject {
    @Published var datas = [Bookcategory]()
    let url = "https://alibrary.in/api/explore_categories"


    init() {
        getData(url: url)
    }
    
    func getData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(CategoryModel.self, from: data)
                    DispatchQueue.main.async {
                        self.datas = results.bookcategories
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}




struct ExploreCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCategoriesView()
    }
}

