//
//  StackBookListView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import SwiftUI
struct StackBookListView: View {
//    @Environment(\.dismiss) var dismiss
    @StateObject var list = StacksBooksListViewModel()
    let columns =  [GridItem(.flexible()), GridItem(.flexible()) ]
    @State private var isShareSheetShowing = false
    @State var id: Int
    @State var name: String
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("u").resizable()
                VStack(spacing: 0) {
                    HStack(spacing: 25){
                        Button(action: {
//                            dismiss()
                        },
                               label: {
                            
                            Image(systemName: "arrow.backward")
                            
                                .font(.system(size:22, weight:.heavy))
                            
                                .foregroundColor(.white)
                        })
                        Text(name)
                        
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        
                        Button(action: {
                            //                        self.shown = true
                        }, label: {
                            Image("stack_plus_n")
                                .resizable()
                                .frame(width: 30, height: 35)
                        })
                        Button(action: shareButton, label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 30)
                        })
                        
                    }.padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width, height: 65)
                        .background(Color("orange"))
                    Spacer()
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 12) {
                            
                            ForEach(list.datas, id: \.id){ item in
                                VStack(alignment: .leading){
                                    AsyncImage(url: URL(string: item.book_media.url)){image in
                                        
                                        NavigationLink(destination: {
                                            ShowBooksDetailsView( id: "\(item.stack_book.id)").navigationTitle("")
                                                .navigationBarHidden(true)
                                                .navigationBarBackButtonHidden(true)
                                        }, label: {
                                            image.resizable()
                                                .frame(maxHeight: 225)
                                        })
                                    }placeholder: {
                                        Image("logo_gray").resizable().frame(maxHeight: 225)
                                    }
                                    
                                    HStack{
                                        Text(item.stack_book.name).foregroundColor(Color("default_")).font(.system(size: 16)).lineLimit(2)
                                        Spacer()
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(Color("default_"))
                                    }
                                }.padding(12).background(Color.white).cornerRadius(8).shadow(color: .gray, radius: 0.8)
                            }
                        }
                    }
                }.onAppear{
                    list.getStackBooksListData(id: self.id)
                }
               
            }
           
        }
    }
    func shareButton() {
           
           isShareSheetShowing.toggle()
           
           let url = URL(string: "https://www.alibrary.in/show-book?id=3898")
           let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

       }
}

struct StackBookListView_Previews: PreviewProvider {
    static var previews: some View {
        StackBookListView(id: 790, name: "BooksName")
    }
}
