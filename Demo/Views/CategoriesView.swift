//
//  CategoriesView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 21/12/22.
//
//
import SwiftUI
import UIKit

import Foundation
//import Drawer



struct ExploreCategoryModel:Decodable{
    
    var subcategorycol: [SubCategoryModel]
    var categoryBooks: CategoryBookModel
}


struct CategoryBookModel:Decodable{
    var data: [CategoryDataModel]
    var last_page: Int
}

struct SubCategoryModel:Decodable{
    var id: Int
    var category_name: String
    
}



struct CategoryDataModel: Decodable{
    var id : Int
    var book_media: CategoryBookMediaModel
}

struct CategoryBookMediaModel: Decodable{
    var id: Int
    var url: String
    
}


struct CategoriesView: View {

@Environment(\.dismiss) var dismiss
@StateObject var list = CategoriesViewModel(_httpUtility: HttpUtility())
@State var pressed:Bool = true
@State var id:Int = 1
@State var subId:Int = 21
private var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var currentView: String = "view1"
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
            ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        if (list.bookName.capacity != 0){
                            Button(action: {
                                pressed = true
                                list.getData(id: self.id)
                             
                            }, label: {
                           
                                Text("All").foregroundColor(.white)
                                    .font(.system(size: 15))
                                    .foregroundColor(.white).padding().frame(height: 35).background(Color("default_")).cornerRadius(22)
                            })
                        }
                        ForEach(list.bookName,id: \.id){item in
                            Button(action: {
                                self.subId = item.id
                                list.getData(id: self.id, subId: item.id)
                                pressed = false
                                self.currentView = "view2"
                                
                            }, label: {
                                
                                Text(item.category_name).font(.system(size: 15)).foregroundColor(.white).padding().frame(height: 35).background(Color("default_")).cornerRadius(22)
                                
                            })
                            
                            
                        }
                    }.frame(height: 65).background(Color.white)
                    
                }
                
                
                
                if pressed{
                    AllCategoriesView()
                }
                else{
                     FilterCategoriesView(subId: subId)
                }
                
               
            }
            
        }.onAppear{
            list.getData(id: self.id)
        }
    }
    
}
    


struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
//        CategoriesView()
        ContentView1()
       

    }
}

class CategoriesViewModel: ObservableObject {

    @Published var datas = [CategoryDataModel]()
    @Published var bookName = [SubCategoryModel]()
    @Published var totalPage = Int()
    @Published var currentPage = 1
  
    private let httpUtility: HttpUtility

    init(_httpUtility: HttpUtility) {
            httpUtility = _httpUtility
       
        }

    func getData(id: Int)
        {
            let apiUrl = "https://alibrary.in/api/explore_categories/\(id)?page=\(self.currentPage)"
//            let apiUrl = ApiUtils.searchBooksCollectionApiurl!
            let params = "\(self.currentPage)"
            var request = URLRequest(url: URL(string: apiUrl)!)

            request.httpMethod = "GET"
            request.httpBody = params.data(using: .utf8)
            httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: ExploreCategoryModel.self) { (results) in
                DispatchQueue.main.async {
//                    self.datas = results.subcategorycol
                    self.bookName = results.subcategorycol
                    self.totalPage = results.categoryBooks.last_page
                    self.datas.append(contentsOf: results.categoryBooks.data)

                             
                }



            }
        }
    
    
    func getData(id:Int,subId:Int)
    {
        let apiUrl = "https://alibrary.in/api/explore_categories/\(id)/\(subId)?page=\(self.currentPage)"
//            let apiUrl = ApiUtils.searchBooksCollectionApiurl!
        let params = "\(self.currentPage)"
        var request = URLRequest(url: URL(string: apiUrl)!)

        request.httpMethod = "GET"
        request.httpBody = params.data(using: .utf8)
        httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: ExploreCategoryModel.self) { (results) in
            DispatchQueue.main.async {
//                    self.datas = results.subcategorycol
                self.bookName = results.subcategorycol
                self.totalPage = results.categoryBooks.last_page
                self.datas.append(contentsOf: results.categoryBooks.data)

                         
            }



        }
    }
    
    

}



struct AllCategoriesView: View{
    @StateObject var list = CategoriesViewModel(_httpUtility: HttpUtility())
    private var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var id: Int = 1
    
    
    var body: some View{
        
        
        VStack {
            ScrollView{
                
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(list.datas,id: \.id) {
                    item in
                    AsyncImage(url: URL(string: item.book_media.url)){ image in
                        image.resizable().cornerRadius(12).frame(maxHeight: 180).shadow(color: .gray, radius: 2,x: 2,y: 2)
                        
                    }placeholder: {
                        Image("logo_gray").resizable().frame(maxHeight: 180)
                    }
                }.padding(2)
                if list.currentPage < list.totalPage{
                    CircleProgressView().frame(alignment: .center).onAppear{
                            list.currentPage = list.currentPage + 1
                            print("\(list.currentPage)")
                        list.getData(id: self.id)
                        }
                    }
            }
              
            }
        }.onAppear{
            list.getData(id: self.id)
        }
    
    }
}




struct FilterCategoriesView: View{
    @StateObject var list = CategoriesViewModel(_httpUtility: HttpUtility())
    private var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var id:Int = 1
    @State var subId: Int
    init(subId: Int){
        self.subId = subId
    }
    var body: some View{
        
        
        VStack {
            ScrollView{
                
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(list.datas,id: \.id) {
                    item in
                    AsyncImage(url: URL(string: item.book_media.url)){ image in
                        image.resizable().cornerRadius(12).frame(maxHeight: 180).shadow(color: .gray, radius: 2,x: 2,y: 2)
                        
                    }placeholder: {
                        Image("logo_gray").resizable().frame(maxHeight: 180)
                    }
                }.padding(2)
                if list.currentPage < list.totalPage{
                    CircleProgressView().frame(alignment: .center).onAppear{
                            list.currentPage = list.currentPage + 1
                            print("\(list.currentPage)")
                            list.getData(id:self.id, subId:self.subId)
                        }
                    }
            }
              
            }
        }.onAppear{
            list.getData(id:self.id, subId:self.subId)
        }
    
    }
}








struct DetailView: View {
    let item: Item

    var body: some View {
        Text("Displaying item with ID: \(item.id)")
    }
}

struct Item: Identifiable {
    let id: Int
    let name: String
}

class CategoriesViewModel1: ObservableObject {

    @Published var datas = [CategoryDataModel]()
    @Published var bookName = [SubCategoryModel]()
    @Published var totalPage = Int()
    @Published var currentPage = 1
  
    private let httpUtility: HttpUtility

    init(_httpUtility: HttpUtility) {
            httpUtility = _httpUtility
       
        }

    
    
    
    func getData(subId:Int)
    {
        let apiUrl = "https://alibrary.in/api/explore_categories/1/\(subId)?page=\(self.currentPage)"
//            let apiUrl = ApiUtils.searchBooksCollectionApiurl!
        let params = "\(self.currentPage)"
        var request = URLRequest(url: URL(string: apiUrl)!)

        request.httpMethod = "GET"
        request.httpBody = params.data(using: .utf8)
        httpUtility.getApiData(requestUrl: URL(string: "\(request)")!, resultType: ExploreCategoryModel.self) { (results) in
            DispatchQueue.main.async {
//                    self.datas = results.subcategorycol
                self.bookName = results.subcategorycol
                self.totalPage = results.categoryBooks.last_page
                self.datas.append(contentsOf: results.categoryBooks.data)

                         
            }
           


        }
    }
    
    

}


struct FilterView: View {
    @ObservedObject var list = CategoriesViewModel1(_httpUtility: HttpUtility() )
    @State var id = 19
    var body: some View {
        VStack {
            ScrollView(.horizontal){
                HStack{
                    ForEach(list.bookName, id: \.id){
                        item in
                        Button(item.category_name) {
                            id = item.id
                        }
                    }
                }
            }
            FilterCategoriesView(subId: id)
            Spacer()
        }.onAppear{
            list.getData(subId: 19)
        }
    }
}

 
//@State private var offset: CGSize = .zero
//    var body: some View {
//        let drag = DragGesture()
//            .onChanged { value in
//                self.offset = value.translation
//            }
//        return ZStack {
//            Rectangle()
//                .fill(Color.gray)
//                .frame(width: 50, height: UIScreen.main.bounds.height)
//                .offset(x: self.offset.width)
//                .gesture(drag)
//            Text("Your main content here")
//        }
//    }

struct ContentView1: View {
    @State private var offset: CGSize = .zero
  @State private var showMenu: Bool = false
    @State private var currentPosition: CGSize = .zero
        @State private var newPosition: CGSize = .zero
 
    @State private var selection = 0
  var body: some View {
    NavigationView {
        ZStack {
            Color.red.opacity(0).ignoresSafeArea(.all, edges: .all)
            HStack{
                Rectangle()
                    .fill(Color.red.opacity(0.2))
                   .frame(width: 11)
                   .offset(x: self.offset.width)
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.currentPosition = CGSize(width: 0, height: 0)
                            self.showMenu = true
                        }   // 4.
                        .onEnded { value in
                            //                      self.showMenu = false
                        }
                    )
                Spacer()
            }
           
            VStack{
                HStack{
                    Button(action: {
                        self.showMenu.toggle()
                        
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title).frame(width: 40,height: 65)
                            .frame(alignment: .leading)
                            .foregroundColor(.white)
                        
                    })
                    Button(action: {
                        
                    }, label: {
                        ZStack {
                            HStack {
                                Image(systemName: "magnifyingglass").foregroundColor(.gray).font(.body).frame(width: 30,height: 35)
                                Text("search books..").foregroundColor(.gray)
                                Spacer()
                                
                            }.frame(width: UIScreen.main.bounds.width*0.5)
                                .padding(.leading, 7)
                        }
                        .frame(height: 40)
                        .background()
                        .cornerRadius(8)
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image("qr_c").resizable()
                            .frame(width: 30, height: 30)
                    })
                    //for 3 dot vertical point
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                            .font(.system(size: 33))
                            .rotationEffect(.degrees(-90))
                            .frame(width: 11, height: 55, alignment: .center)
                            .padding()
                        
                    })
                }.padding(.horizontal, 10)
                
                    .frame( width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*0.06)
                
                    .font(.headline)
                    .background(Color.orange)
                
           Spacer()
            }
           
            
            
            GeometryReader { _ in
                
                HStack {
                    
                    
                    //              SideMenuView(showMenu: self.showMenu, selected: $selected)
                    SideMenuV()
                        .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width)
                        .animation(.easeInOut(duration: 0.4), value: showMenu)
                    Spacer()
                }
                
            }
            .background(Color.gray.opacity(showMenu ? 0.9 : 0).ignoresSafeArea().onTapGesture {
                self.showMenu = false
            })
           
            }
        
    }
  }
}


struct SideMenuV: View {
@State var isRefreshing = false
  var body: some View {
    VStack {
      Text("Settings")
        .font(.title)
        .foregroundColor(.black)

      Divider()
        .frame(width: 200, height: 2)
        .background(Color.white)
        .padding(.horizontal, 16)

      // MARK: - Content

      Link(destination: URL(string: "https://apple.com")!) {
        Text("Apple")
      }
        Text("Settings")
          .font(.title)
          .foregroundColor(.black)

        Divider()
          .frame(width: 200, height: 2)
          .background(Color.white)
          .padding(.horizontal, 16)

        // MARK: - Content

        Link(destination: URL(string: "https://apple.com")!) {
          Text("Apple")
        }
        Text("Settings")
          .font(.title)
          .foregroundColor(.black)

        Divider()
          .frame(width: 200, height: 2)
          .background(Color.white)
          .padding(.horizontal, 16)

        // MARK: - Content

        Link(destination: URL(string: "https://apple.com")!) {
          Text("Apple")
        }
        
      .font(.title)
      .foregroundColor(.blue)

      Spacer()
    }
    .padding(32)
    .background(Color.white)
    .edgesIgnoringSafeArea(.bottom)
  }

}




