//
//  CategoriesView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/10/22.
//

import SwiftUI

struct CategoriesView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var datalist = ExploreCategoriesViewModel(id: 2)
    @State var datas = String()
    @State var descBy = String()
    @State var subdatas = String()
    @State var bannerdatas = String()
    @State var allbtn = String("All")
    @State var bookurl = [ListBookDetails]()
    @State var imgdatas = [ExploreBookDetail]()
    @State var btns = [Subcategorycol]()
    @State var isTapped: Bool = false
    var id: String
    @State var subId: Int?
   @State var pressedBtn: Bool = false
    
    
    
    var apiurl = "https://alibrary.in/api/explore_categories/"
    @State var offset: CGFloat = 0
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(sentid: String) {
        
//        apiurl = "https://alibrary.in/api/explore_categories/\(sentid)"
       
          UIScrollView.appearance().bounces = false

        self.id = sentid
        getExploreData(url: apiurl+id)

       }
    var body: some View {
        NavigationView{
            VStack {
                
                HStack(spacing: 25){
                    
                    Button(action: {
                        dismiss()
                        
                    }, label: {
                        Image(systemName: "arrow.left").font(.system(size: 25))
                    })
                       
                 
                    Text("All").font(.system(size: 25))
                    Spacer()
                }.padding(.horizontal).frame(height: 75).background(Color("orange")).foregroundColor(.white)
                ScrollView(.vertical, showsIndicators: false) {
                    // Header Section Start
                    LazyVStack(alignment: .leading,spacing: 2,pinnedViews: .sectionHeaders, content: {
//                        GeometryReader{ reader in
                            
                            ZStack {
                                VStack {
                                    VStack {
                                        Text(datas).foregroundColor(.white).font(.largeTitle).bold()
                                        Text(subdatas).foregroundColor(.white).bold()
                                        Text(descBy).foregroundColor(.white)
                                        
                                    }.frame(width: UIScreen.main.bounds.width, height: 162)
                                        .background(Color.black.opacity(0.2))
                                    Spacer()
                                    
                                    ScrollView(.horizontal,showsIndicators: false){
                                        HStack{
                                            
                                            ForEach(imgdatas, id: \.id){ item in
                                                AsyncImage(url: URL(string: item.book_media.url)){image in
                                                    image.resizable().frame(maxWidth: 125, maxHeight: 160).cornerRadius(7)
                                                    
                                                }placeholder: {
                                                    Image("logo_gray").resizable().frame(width: 125,height: 160).cornerRadius(7).padding(.horizontal)
                                                }
                                            }
                                            
                                            
                                            
                                        }
                                        
                                    }
                                }
                                HStack{
                                Spacer()
                                    Image(systemName: "ellipsis").foregroundColor(.white).font(.system(size: 30)).frame(width: 42, height: 42)
                                        .background(Color.gray).cornerRadius(22).opacity(0.8)
                                        .rotationEffect(Angle(degrees: isTapped ? 90 : 0)).padding(.top,-95)
                                        .onTapGesture {
                                                isTapped.toggle()
                                                    print("Tapped")
                                            }
                                        .overlay (
                                            
                                            VStack(alignment: .center, spacing: 7) {
                                                
                                                if isTapped {
                                                    
                                                    Spacer(minLength: 38)
                                                    
                                                    Image("whatup_").resizable().frame(width: 45, height: 45).opacity(0.8)
                                                    Image("insta_").resizable().frame(width: 45, height: 45).opacity(0.8)
                                                    Image("twiter_").resizable().frame(width: 45, height: 45).opacity(0.8)
                                                    Image("insta_").resizable().frame(width: 45, height: 45).opacity(0.8)
                                                    Image("youtube_").resizable().frame(width: 45, height: 45).opacity(0.8)
                                                    
                                                }
                                                
                                            }.padding(.trailing).padding(.top,-90), alignment: .topLeading
                                            
                                        )
                                        
                                }.padding(.trailing)
                                }.background(AsyncImage(url: URL(string:  "\(bannerdatas)")){
                                                        image in
                                                        image.resizable()
                                                    }placeholder: {
                                                        Color.orange.opacity(0.5)
                                                }).frame(height:435)
                            
                            
                            


//                        }.frame(height: 435)
                        
                        //Banner Header Section End
                        
                        //Sticky header Section Start
                        
                        Section(header:  HStack(spacing: 10){
                            ScrollView(.horizontal, showsIndicators: false){
                                
                                HStack {
                                    if btns.capacity != 0{
                                        Button(action: {
                                            print(id)
                                            
                                            //                                        id = id
                                            self.pressedBtn = true
//                                            getExploreData(url: apiurl)
//                                            getExploreData(url: apiurl+self.id)
                                            
                                        }, label: {
                                            Text(allbtn).font(.system(size: 15)).foregroundColor(.white).padding().frame(height: 35).background(Color("default_")).cornerRadius(22)
                                        })
                                    }
                                    ForEach(btns,id: \.self){item in
                                        Button(action: {
                                            
                                            
                                            self.pressedBtn = true
                                            self.subId = item.id
                                            print(self.subId!)
                                            
                                        }, label: {
                                            
                                            Text(item.category_name).font(.system(size: 15)).foregroundColor(.white).padding().frame(height: 35).background(Color("default_")).cornerRadius(22)
                                            
                                        })
                                        
                                       
                                    }
                                }.frame(height: 65).background(Color.white)
                               
                            }
                        }
                                    , content: {
                            if pressedBtn == true{

                                AllFilterExploreCategoryBooks(id: Int(id)!)
                               
                            }
                            else{
                                FilterCategoryView(id: Int(self.id) ?? 1, subId: self.subId ?? 21)
                           
                            }
                        })
                        
                    })
                } .navigationBarBackButtonHidden(true)
                .overlay(Color.white.frame(height: UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }?.safeAreaInsets.bottom).ignoresSafeArea(.all, edges: .top).opacity(offset > 235 ? 1 : 0),alignment: .top)
                    .padding(.top,-12)
            }.onAppear{
//                self.pressedBtn = false
                print(apiurl+id)
                getExploreData(url: apiurl+self.id)
            }
        }
        }
    
    func getExploreData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(ExploreModel.self, from: data)
                    DispatchQueue.main.async {
                        self.datas = results.bookcategory.category_name
                        self.subdatas = results.bookcategory.description
                        self.descBy = results.bookcategory.desc_by
                        self.bannerdatas = results.bookcategory.banner
                        self.imgdatas = results.bookDetails
                        self.btns = results.subcategorycol
                        self.allbtn = results.subCategoryname
                        self.bookurl = results.categoryBooks.data
//                        print(self.bookurl)
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
    
  
    
    
    }

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(sentid: "1")
    }
}
