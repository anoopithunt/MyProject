//
//  GuestStackBookListView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import SwiftUI

struct GuestStackBookListView: View {
    @StateObject var list = GuestStackBookListViewModel()
    @State var searchText: String = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @FocusState private var isTextFieldFocused: Bool
  @State var id: Int// = 891
    @State var title: String = ""
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea(.keyboard)
            NavHeaderClosure(title: title){
                
                ScrollView{
                    VStack{
                        TextField("search stacks", text: $searchText).font(.title)
                            .padding(4).padding(.trailing,26).foregroundColor(.gray)
                            .cornerRadius(8).focused($isTextFieldFocused)
                            .showClearButton($searchText)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 0.6)
                            ).frame(height: 55)
                        
                        
                        
                        
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(list.datas, id: \.id){ item in
                                VStack(alignment: .leading){
                                    AsyncImage(url: URL(string: item.book_media.url)){
                                        img in
                                        img.resizable().frame(height: 275)
                                    }placeholder: {
                                        Image("logo_gray").resizable().frame(height: 275)
                                    }
                                    Text("\(item.stack_book.title)").foregroundColor(Color("default_"))
                                }.padding(6).background(Color.white).cornerRadius(8).shadow(radius: 1)
                            }
                            
                            
                        }
                    }.onAppear{
                        list.getStackBookListData(id: id)
                    }
                }
            } .overlay(starOverlay, alignment: .topTrailing)
        }
        
    }
    private var starOverlay: some View {
        HStack(spacing:14){
            Button(action: {
                
            }, label: {
                
                Text("Copy").font(.system(size:22))
                    .padding(.horizontal).padding(.vertical,4)
                    .foregroundColor(.white)
                    .background(Color.cyan)
                    .cornerRadius(12).overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 1.0).shadow(radius:0.8)
                    )
            })
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(.white).font(.system(size: 22,weight: .bold))
                
        }.padding([.top, .trailing])
    }
}

struct GuestStackBookListView_Previews: PreviewProvider {
    static var previews: some View {
        GuestStackBookListView( id: 890)
    }
}
