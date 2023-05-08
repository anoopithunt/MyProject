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
        CategoriesView2()
    }
}

class ExploreCategoriesViewModel1: ObservableObject{
    @Published var datas = [CategoriesBookDetail]()
    @Published var books = [CategoriesDatum]()
    @Published var bookDetails:CategoriesBookcategory? //= CategoriesBookcategory()
    @Published var buttons:[CategoriesSubcategorycol] = [CategoriesSubcategorycol]()
    @Published var totalPage = Int()
    @Published var currentPage = 1
    private let httpUtility: HttpUtility
    init(_httpUtility: HttpUtility) {
            httpUtility = _httpUtility
        }
    func getData(id: Int, subId: String){
        let apiUrl = "https://www.alibrary.in/api/explore_categories/\(id)/\(subId)?page=\(currentPage)"
        let params = "\(self.currentPage)"
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "GET"
        request.httpBody = params.data(using: .utf8)
        httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: CategoriesModel.self) { (results) in
            DispatchQueue.main.async {
                self.datas = results.bookDetails
                self.bookDetails = results.bookcategory
                self.buttons = results.subcategorycol
                print(self.buttons)
                self.totalPage = results.categoryBooks.last_page
                if self.currentPage == 1 {
                    self.books = results.categoryBooks.data
                               
                } else {
                    self.books.append(contentsOf: results.categoryBooks.data)
                    
                }

            }
        }

    }
    
    func loadNextPage() {
            guard currentPage < totalPage else { return }
            currentPage += 1
        getData(id: 2, subId: "\(currentPage)")
        }
     
}
    
    
    
    
    
    



struct CategoriesView1: View {
    @Environment(\.dismiss) var dismiss
    @State var isTapped: Bool = false
    @State var Id: Int = 1
    @StateObject var list = ExploreCategoriesViewModel1(_httpUtility: HttpUtility())
    private var column = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
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
                        GeometryReader{ reader in
                            
                            ZStack {
                                VStack(spacing:0) {
                                    VStack(spacing:0) {
                                        Text(list.bookDetails?.category_name ?? "").foregroundColor(.white).font(.largeTitle).bold()
                                        Text(list.bookDetails?.description ?? "").foregroundColor(.white).bold()
                                        Text(list.bookDetails?.desc_by ?? "").foregroundColor(.white)
                                        
                                    }.frame(width: UIScreen.main.bounds.width, height: 162)
                                        .background(Color.black.opacity(0.2))
                                    
                                    Spacer()
                                    ScrollView(.horizontal,showsIndicators: false){
                                        HStack{
                                            ForEach(list.books, id: \.id){ item in
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
                            }
                            .background( AsyncImage(url: URL(string: list.bookDetails?.banner ?? "")){img in
                                img.resizable().frame(height:435)
                            }placeholder: {
                                Color.orange.opacity(0.4)
                            }).frame(height:435)
                            
                            
                            
                            
                            
                        }.frame(height: 435)
                        
                        //Banner Header Section End
                        
                        //Sticky header Section Start
                        
                        Section(header:  HStack(spacing: 10){
                            
                            //Filter button Design
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack {
                                    if list.buttons.capacity != 0{
                                        Button(action: {
//                                            list.getData(subId: 21, page: 2)
                                            
                                        }, label: {
                                            Text("All").font(.system(size: 15, weight: .bold)).foregroundColor(.white)
                                                .padding(.horizontal).padding()
                                                .frame(height: 45).background(Color("default_")).cornerRadius(22)
                                        })
                                    }
                                    ForEach(list.buttons,id: \.id){item in
                                        Button(action: {
                                            
                                            list.getData(id: item.parent_cat_id, subId: "\(item.id)")
                                        }, label: {
                                            
                                            Text(item.category_name).font(.system(size: 15, weight: .bold))
                                                .foregroundColor(.white)
                                                .padding().frame(height: 45).background(Color("default_")).cornerRadius(22)
                                            
                                        })
                                        
                                        
                                    }
                                }.frame(height: 65).background(Color.white)
                                
                            }
                        }, content: {
                            LazyVGrid(columns: column, spacing: 10)  {
                                ForEach(list.datas,id:\.id){ item in
                                    AsyncImage(url: URL(string: item.book_media.url)){
                                        img in
                                        img.resizable().frame(height:185)
                                            .cornerRadius(12)
                                    }placeholder: {
                                        Color.yellow.opacity(0.3)
                                            .frame(height:185).cornerRadius(12)
                                    }
                                }
                                if list.currentPage < list.totalPage {
                                    GeometryReader { proxy in
                                      ProgressView()
                                            .onAppear {
                                                     
//                                                let yOffset = proxy.frame(in: .global).maxY
//
//                                                let contentHeight = UIScreen.main.bounds.height
//
//                                                let height = UIScreen.main.bounds.height
//
//                                                let threshold = contentHeight - height
//
//                                                if yOffset > threshold {
                                                        
                                                    list.loadNextPage()
                                                      
//                                                }
                                                
                                            }
                                          
                                    }
                                     
                                }
                            }
                            
                        })
                        
                    })
                } .navigationBarBackButtonHidden(true)
            }.onAppear{
                list.getData(id: 2, subId: "2")
            }
        }
    }
}

import Foundation

// MARK: - Welcome
public struct  CategoriesModel:Decodable {
    public let bookcategory: CategoriesBookcategory
    public let bookDetails: [CategoriesBookDetail]
    public let subcategorycol: [CategoriesSubcategorycol]
//    public let subCategoryname: String
    public let categoryBooks: CategoriesBooks

}

// MARK: - BookDetail
public struct CategoriesBookDetail:Decodable {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let tot_pages: Int
    public let meta_keyword: String
    public let author_name: String
//    public let isbn_no: String
//    public let validity_date: String
//    public let published: String
    public let book_media: CategoriesBookDetailBookMedia


}

// MARK: - BookDetailBookMedia
public struct CategoriesBookDetailBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let url: String

}

// MARK: - Bookcategory
public struct CategoriesBookcategory:Decodable {
    public let id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String

}

// MARK: - CategoryBooks
public struct CategoriesBooks:Decodable {
    public let current_page: Int
    public let data: [CategoriesDatum]
    public let last_page: Int

}

// MARK: - Datum
public struct CategoriesDatum:Decodable {
    public let id: Int
    public let name: String
    public let tot_pages: Int
    public let author_name: String
    public let isbn_no: String?
//    public let size: String
    public let validity_date: String
    public let published: String
    public let book_media: CategoriesDatumBookMedia

}

// MARK: - DatumBookMedia
public struct CategoriesDatumBookMedia:Decodable {
    public let id: Int
    public let url: String

}

// MARK: - Subcategorycol
public struct CategoriesSubcategorycol:Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String?

}





class ExploreCategoriesViewModel2: ObservableObject{
    @Published var books = [CategoriesDatum]()
    @Published var buttons = [CategoriesSubcategorycol]()
    @Published var totalPage = Int()
    @Published var currentPage = 1
    private let httpUtility: HttpUtility
    init(_httpUtility: HttpUtility) {
            httpUtility = _httpUtility
        }
    func getData(currentPage: Int) {
        let apiUrl = "https://www.alibrary.in/api/explore_categories/1?page=\(currentPage)"
        httpUtility.getApiData(requestUrl: URL(string: apiUrl)!, resultType: CategoriesModel.self) { (results) in
            DispatchQueue.main.async {
                if self.currentPage == 1 {
                    self.books = results.categoryBooks.data
                } else {
                    self.books.append(contentsOf: results.categoryBooks.data)
                }
                self.buttons = results.subcategorycol
                self.totalPage = results.categoryBooks.last_page
                print(self.totalPage)
            }
        }
    }
    
    func loadNextPage( currentPage: Int) {
        guard currentPage < self.totalPage else { return }
       
        getData(currentPage: currentPage)
//        loadNextPage(currentPage: currentPage + 1)
    }
     
}

struct CategoriesView2: View {
    @Environment(\.dismiss) var dismiss
    @State var Id: Int = 2
    @StateObject var list = ExploreCategoriesViewModel2(_httpUtility: HttpUtility())
    private var column = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                HStack(spacing: 25){
                    
                    Button(action: {
                        dismiss()
                        
                    }, label: {
                        Image(systemName: "arrow.left").font(.system(size: 25))
                    })
                    
                    
                    Text("All").font(.system(size: 25))
                    Spacer()
                }.padding(.horizontal).frame(height: 75)
                    .background(Color("orange"))
                    .foregroundColor(.white)
                ScrollView(.vertical, showsIndicators: false) {
                    // Header Section Start
                    
                    //Filter button Design
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack {
                            if list.buttons.capacity != 0{
                                Button(action: {
                                    list.getData(currentPage: 1)
                                }, label: {
                                    Text("All").font(.system(size: 15, weight: .bold)).foregroundColor(.white)
                                        .padding(.horizontal).padding()
                                        .frame(height: 45).background(Color("default_")).cornerRadius(22)
                                })
                            }
                            ForEach(list.buttons,id: \.id){item in
                                Button(action: {
                                    
                                    //                                            list.getData(subId: "/\(item.id)")
                                }, label: {
                                    
                                    Text(item.category_name).font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding().frame(height: 45).background(Color("default_")).cornerRadius(22)
                                    
                                })
                                
                                
                            }
                        }.frame(height: 65).background(Color.white)
                        
                    }
                    
                    LazyVGrid(columns: column,spacing: 12)  {
                        ForEach(list.books,id:\.id){ item in
                            AsyncImage(url: URL(string: item.book_media.url)){
                                img in
                                img.resizable().frame(height:185)
                                    .cornerRadius(12)
                            }placeholder: {
                                Image("logo_gray").resizable()
                                    .frame(height:185).cornerRadius(12)
                            }
                        }
                        if list.currentPage < list.totalPage {
                            ProgressView()
                                .onAppear {
                                    list.currentPage += 1
                                    list.loadNextPage(currentPage: list.currentPage)
                                    
                                }
                        }
                    }
                }
            } .onAppear {
                list.getData(currentPage: 1)
            }
        }
    }
    
}
