//
//  LatestMagazineView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/03/23.
//

import SwiftUI

struct LatestMagazineView: View {
    @Environment(\.dismiss) var dismiss
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    @StateObject var list = PublicProfilePublisherViewModel()
    @State private var isLoading: Bool = false
    let options = ["All", "Prime", "Free", "Paid"]
    @State var value = ""
    var placeholder = "All"
    @State var selectedIndex = 0
    @FocusState private var isTextFieldFocused: Bool
    @State  var searchText: String = ""
    var body: some View {
        ZStack{
            Image("u")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing:0){
                HStack(spacing: 25){
                    Button(action: {
                        dismiss()
                    },
                           label: {
                        
                        Image(systemName: "arrow.backward")
                            .font(.system(size:22, weight:.heavy))
                            .foregroundColor(.white)
                    })
                    Text(list.full_name)
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.white)
                    Spacer()
                    AsyncImage(url: URL(string: list.logo)){ img in
                        img.resizable()
                            .frame(width: 55, height: 55)
                            .cornerRadius(28)
                    }placeholder: {
                        Image("logo_gray").resizable()
                            .frame(width: 55, height: 55)
                            .cornerRadius(28)
                    }
                    
                    
                }.padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 90)
                    .background(Color("orange"))
                
                ScrollView{
                    VStack(spacing: 0){
                        
                        AsyncImage(url: URL(string: list.banner)){img in
                            img.resizable()
                                .frame(height: 225)
                            
                        }placeholder: {
                            Color.gray
                                .frame(height: 225)
                        }
                        HStack(spacing: 8){
                            Image("pdf_white")
                                .resizable()
                                .frame(width: 25, height: 28)
                            
                            Text("\(list.total)")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                            Button(action: {
                                
                            }, label: {
                                Text("Follow")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                                    .padding(6)
                                    .padding(.horizontal,8)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white, lineWidth: 1)
                                )
                                
                            })
                            Image("followers_white")
                                .resizable()
                                .frame(width: 13, height: 22)
                            Text("\(list.followers)")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                            Spacer()
                            
                            
                            Menu {
                                ForEach(options.indices, id: \.self) { index in
                                    Button(options[index]) {
                                        self.value = options[index]
                                        self.selectedIndex = index
                                        list.bookType = ["all", "prime", "free", "paid"][index]
                                        list.filterData = true
                                        list.currentPage = 1
                                        list.getBookData()
                                    }
                                }
                            } label: {
                                Text(options[selectedIndex])
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                            
                            
                        }.padding(.horizontal).frame(height: 65).background(Color("default_"))
                    LazyVGrid(columns: columns, spacing: 10, pinnedViews: [.sectionHeaders]){
                                Section(header:
                                            VStack{
                                    TextField("", text: $searchText).font(.title).accentColor(.clear)
                                        .padding(4).padding(.trailing,29)
                                        .padding(.leading,searchText.isEmpty ? 29 : 4)
                                        .foregroundColor(.white)
                                        .cornerRadius(8).focused($isTextFieldFocused)
                                        .showClearButtonOfSearchField($searchText)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 22)
                                                .stroke(Color.white, lineWidth: 1)
                                        ).overlay(alignment: .leading, content: {
                                            if searchText.isEmpty {
                                                Image("magnifying_glass_left" ).resizable().frame(width: 20, height: 20).padding(.leading,8)
                                            }
                                        })
                                        .overlay(alignment: .leading, content: {
                                            Text("Search books..").padding(.leading,32)
                                                .foregroundColor(.white)
                                                .font(.title)
                                                .opacity(searchText.isEmpty ? 1 : 0)
                                        } ).padding(0)
                                }.padding(.horizontal)
                                    .frame(height: 65).background(Color("default_")))
                                {
                                    ForEach(list.datas, id: \.id){item in
                                        VStack(alignment: .leading){
                                            AsyncImage(url: URL(string: item.book_media.url)){ img in
                                                img .resizable()
                                                    .frame(height: 255)
                                            }placeholder: {
                                                Image("logo_gray")
                                                    .resizable()
                                                    .frame(height: 255)
                                            }
                                            
                                            Text(item.title).lineLimit(2).font(.system(size: 22,weight: .regular))
                                            Text("Published: \(item.published)")
                                                .font(.system(size: 17,weight: .regular))
                                            Text("Like \("\(item.tot_likes ?? "0")")")
                                                .font(.system(size: 18,weight: .regular))
                                            HStack{
                                                Spacer()
                                                if item.is_free == 1
                                                {
                                                    Text("free").font(.system(size: 22,weight: .bold)).foregroundColor(.red)
                                                } else{
                                                    Text("paid").font(.system(size: 22,weight: .bold)).foregroundColor(.cyan)
                                                }
                                                
                                            }
                                        }.padding(8)
                                            .background(Color.white)
                                            .cornerRadius(4).shadow(radius: 1)
                                        
                                    }.padding(2)
                                    if list.currentPage < list.totalPage{
                                        
                                        CircleProgressView()
                                        
                                            .frame(alignment: .center)
                                        
                                            .onAppear{
                                               
                                                list.currentPage = list.currentPage + 1
                                                list.getBookData()
                                            }
                                        }
                                    
                                }
                            }
                        
                    }
                    
                }
            }.onAppear{
                list.getBookData()
            }
        }
    }
}

struct LatestMagazineView_Previews: PreviewProvider {
    static var previews: some View {
        LatestMagazineView()
    }
}
