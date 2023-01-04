//
//  GuestUserStackView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import SwiftUI
import Combine


struct GuestUserStackView: View {
    @State var rotate: [Int] = [-10, 10, 0]
//    @State var index: Int = -1
    @State var searchText: String = ""
    @StateObject var list = GuestUserStackViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea(.keyboard)
            
            VStack{
                NavigationView{
                NavHeaderClosure(title: "Public Stacks"){
                   
                        
                        
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
                               ForEach(list.datas, id:\.id){ item in
                                        VStack(){
                                            NavigationLink(destination: {
                                                GuestStackBookListView( id: item.id,title: "\(item.name)")
                                                    .navigationTitle("")
                                                
                                                    .navigationBarHidden(true)
                                                
                                                    .navigationBarBackButtonHidden(true)
                                            }, label: {
                                                ZStack(alignment: .center){
                                                    ForEach(0..<min(item.stack_book_links.count, 3), id: \.self) { index in
                                                        AsyncImage(url: URL(string: item.stack_book_links[index].url)){ img in
                                                            img.resizable()
                                                                .frame(width: 125, height: 155)
                                                                .rotationEffect(Angle(degrees: Double(rotate[index % rotate.count])))
                                                                .shadow(radius: 5)
                                                            
                                                            
                                                            
                                                        }placeholder: {
                                                            Image("logo_gray").resizable()
                                                                .frame(width: 145, height: 155)
                                                        }
                                                        
                                                        
                                                    }
                                                }
                                            })
                                            VStack(alignment: .leading){
                                                Text(item.name)
                                                    .foregroundColor(Color("default_"))
                                                Text("By: \(item.createdBy)")
                                                    .foregroundColor(Color("maroon"))
                                                HStack{
                                                    Text("\(item.stack_book_links_count)")
                                                        .foregroundColor(Color("default_"))
                                                    Image("stack_blue")
                                                        .resizable()
                                                        .frame(width: 18, height: 22)
                                                    Spacer()
                                                    Button(action: {
                                                        
                                                    }, label: {
                                                        
                                                        Text("Copy").font(.system(size:18))
                                                            .padding(.horizontal).padding(.vertical,4)
                                                            .foregroundColor(.white)
                                                            .background(Color.cyan)
                                                            .cornerRadius(12).overlay(
                                                                RoundedRectangle(cornerRadius: 15)
                                                                    .stroke(Color.white, lineWidth: 1.0).shadow(radius:0.8)
                                                            )
                                                    })
                                                    
                                                    
                                                }
                                                
                                            }.padding(2)
                                            
                                        }.padding(20)
                                            .background(Color.white)
                                            .cornerRadius(12)
                                            .shadow(radius: 2)
                                        
                                        
                                    }
                                    if list.currentPage < list.totalPage{
                                        ProgressView()
                                            .frame(alignment: .center)
                                            .onAppear{
                                                list.currentPage = list.currentPage + 1
                                                list.getUserStackBookData()
                                            }
                                    }
                                    
                                    Spacer()
                                    
                                }
                            }
                        }.refreshable(action: {
                            //Refresh Action for recall the API
                        })
                    }
                }.onAppear{
                    list.getUserStackBookData()
                }
                
            }
        }
    }
    
}


struct GuestUserStackView_Previews: PreviewProvider {
    static var previews: some View {
        GuestUserStackView()
    }
}
