//
//  SearchBooksView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 02/12/22.
//
import SwiftUI
//import SDWebImageSwiftUI
//import AdvancedList

struct SearchBooksView: View {
    @Environment(\.dismiss) var dismiss
    @State var text: String = ""
    @StateObject var list = SearchBookViewModel()
    
    var columns: [GridItem] {
      [GridItem(.adaptive(minimum: 170))]
    }
    
    var body: some View {
  
            ZStack {
                Image("u").resizable().ignoresSafeArea()
                VStack(spacing: 0){
                    HStack{
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.left").foregroundColor(.white).font(.system(size: 35)).padding(.leading)
                        })
                        
                        Text("Book Collection").foregroundColor(.white).font(.system(size: 24)).bold().padding(.leading,12)
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width, height: 70).background(Color("orange").opacity(0.85))
                    Divider().shadow(color: .gray, radius: 1).offset(y: -2).background(Color("orange").opacity(0.85))
                    
                    ZStack{
                        TextField( "Search Books", text: $text).font(.title).padding().frame(width: UIScreen.main.bounds.width*0.98, height: 50).background(Color.white).cornerRadius(16)
                        HStack{
                            Spacer()
                            Image(systemName: "magnifyingglass").font(.largeTitle)
                            
                        }.font(.title).foregroundColor(.gray).padding(.trailing)
                        
                    }.frame(width: UIScreen.main.bounds.width, height: 70).background(Color("orange"))
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(list.datas1, id: \.id){ item in
                                Text(item.name).padding(10).foregroundColor(.white).background(Color.cyan).cornerRadius(18)
                            }
                        }
                    }.padding(12)
                    ScrollView(showsIndicators: false){
                        if list.isLoading {
                           Spacer()
                            HStack{
    //                                    Spacer()
                                CircleProgressView().frame(width: 45,height: 45)
                            }.frame(width:UIScreen.main.bounds.width,alignment: .center)
                        }else{
                        LazyVGrid(columns: columns, spacing: 22) {
                            
                                ForEach(list.datas, id: \.id){ item in
                                    SearchBooksTemplateView(img:item.url, author: item.name, publication: item.publisherName, published: item.published, like: item.totalLikes).padding(.horizontal)
                                }
                            }
                        }
                   
                    }
                    Spacer()
            }
            
         
                
                }
           
     
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
//        SearchBooksTemplateView()
    }
}
