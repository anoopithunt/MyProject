//
//  StacksView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import SwiftUI

struct StacksView: View {
    @Environment(\.dismiss) var dismiss
    @State var rotate: [Int] = [0, 10, -10]
    @State var index: Int = -1
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    @StateObject var list = StacksViewModel()
    @State var shown = false
    var body: some View {
        NavigationView {
            ZStack {
                Image("u").resizable()
                VStack(spacing: 6) {
                    HStack(spacing: 25){
                        Button(action: {
                            dismiss()
                        },
                               label: {
                            
                            Image(systemName: "arrow.backward")
                            
                                .font(.system(size:22, weight:.heavy))
                            
                                .foregroundColor(.white)
                        })
                        Text("Stacks")
                        
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.white)
                        
                        Spacer()
                        Button(action: {
                            self.shown = true
                        }, label: {
                            Image("stack_add_blue_")
                                .resizable()
                                .frame(width: 45, height: 55)
                        })
                        
                    }.padding(9)
                      .frame(width: UIScreen.main.bounds.width, height: 65)
                        .background(Color("orange"))
                    
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(list.datas, id: \.id){ item in
                                VStack(alignment: .center, spacing: 8){
                                    NavigationLink(destination: StackBookListView(id: item.stack_detail.id, name: item.stack_detail.name).navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true), label: {
                                      ZStack{
                                          ForEach(item.stack_book_link.indices.reversed(), id: \.self) { index in
                                             
                                              AsyncImage(url: URL(string: item.stack_book_link[index].book_url)){ img in
                                                  img.resizable().frame(width: 125, height: 155)
                                                      .rotationEffect(Angle(degrees: Double(rotate[ index])))
                                                      .shadow(radius: 5)
                                              }placeholder: {
                                                  Image("add_stack").resizable().frame(width: 145, height: 155)//.rotationEffect(Angle(degrees: Double(rotate[ index])))
                                                      //.shadow(radius: 0.3)
                                              }

                                          }
                                      }.frame(width: 140,height: 165,alignment: .center) .padding(12)
                                  })
                                   
                      
                                    HStack{
                                        Text(item.stack_detail.name).font(.system(size: 22)).padding(.leading,4).foregroundColor(Color("default_"))
                                        Spacer()
                                    }
                                    
                                    HStack(spacing: 6){
                                        Text("\(item.stack_book_link_count)").foregroundColor(.gray).font(.system(size: 16))
                                        Image("stack_blue").resizable().frame(width: 25, height: 20)
                                        Image(systemName: "eye.slash.fill").resizable().frame(width: 25, height: 20).foregroundColor(.gray)
                                        Spacer()
                                        Menu {
                                            Button {
                                                
                                            } label: {
                                                Label("Edit", systemImage: "square.and.pencil").foregroundColor(.green).font(.system(size: 22))
                                            }
                                            Button {
                                                
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }

                                        } label: {
                                            Image(systemName: "ellipsis")
                                                .font(.system(size: 22, weight: .bold)).foregroundColor(Color("default_")).rotationEffect(.degrees(90)).padding(.trailing)
                                        }
                                    }.padding(.bottom).padding(.leading,4)
                                   
                                }.background(Color("gray")).cornerRadius(12).frame(width: UIScreen.main.bounds.width/2.2).shadow(color: .gray.opacity(0.5),radius: 1).padding(.horizontal)
                            }

                        }.onAppear{
                            list.getStacksData()
                        }
                    }
                   
                    Spacer()
                }
                if shown{
                    StacksViewAlertView(rcShow: $shown)
                }
            }
           
        }
    }
}

struct StacksView_Previews: PreviewProvider {
    static var previews: some View {
        StacksView()
    }
}
