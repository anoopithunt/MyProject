//
//  PDFKitViews.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/03/23.
//

import SwiftUI

struct PDFKitView: View {
    @State private var selectedItem: SheetItem?
    @State private var isAnimating = false
    @State var isOpenThumbnail: Bool = false
    @State var currentPage: Int = 1
    @State var searchView: Bool = false
    @State private var showSheet = false
    @StateObject var list = PreviewBooksViewModel()

    var body: some View {
        ZStack{
            NavigationView{
                VStack {
                    
                    ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
                        VStack{
                            HStack{
                                Button(action: {
                                    
                                }, label: {
                                    
                                    Image(systemName: "chevron.left").font(.system(size: 28, weight: .bold)).foregroundColor(.gray)
                                })
                                Spacer()
                                
                                
                                Button(action: {
                                    self.searchView = true
                                }, label: {
                                    Image("magnifire_glass")//.resizable()//.frame(height: 25)
                                })
                                
                                Button(action: {
                                    
                                }, label: {
                                    Image("qr_scanalib")
                                        .resizable()
                                        .frame(width: 55,height:55)
                                })
                                Button(action: {
                                    self.isOpenThumbnail = true //.toggle()
                                }, label: {
                                    
                                    Image("thumb_")//.resizable().frame(height: 25)
                                                                        })
//                                })
                                
                                Button(action: {
                                    isAnimating.toggle()
                                }, label: {
                                    Image(isAnimating ? "zoomin" : "zoomout")//.resizable().frame(height: 25)
                                })
                                
                                
                            }.padding(.horizontal)
                           
                            
                            PDFViewWrapper(url: URL(string: "\(list.path)/\(currentPage).pdf")!, password: "alib_\(list.id)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        HStack(alignment: .center){
                            Button(action: {
                                
                                self.currentPage -= 1
                            }, label: {
                                Image("previous")
                                    .resizable()
                                    .frame(width: 25, height: 122, alignment: .leading)
                                
                            }
                            )
                            .disabled(self.currentPage == 1)
                            
                            
                            Spacer()
                            
                            
                            if self.currentPage != list.pdfs+1{
                                Button(action: {
                                    withAnimation(.linear(duration: 0.4)) {
                                        self.currentPage += 1
                                    }
                                }, label: {
                                    Image("next")
                                        .resizable()
                                        .frame(width: 25, height: 122, alignment: .leading)
                                    
                                })
                                .disabled(self.currentPage == list.pdfs)
                            }
                        }
                        .frame(alignment: .leading )
                        
                    }
                    HStack{
                        Text(list.bookName)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            showSheet.toggle()
                        }, label: {
//                        BlinkingImage(blinkImage: "menu_icon")
                            Image("menu_icon")
                                .resizable()
                                .frame(width: 45,height: 45)
                        })
                        
                        
                    }
                    .padding(.horizontal)
                    HStack{
                        Slider(value: Binding<Double>(
                            get: { Double(self.currentPage) },
                            set: {
                                self.currentPage = Int($0)
                                
                                // Disable the Next button when the slider reaches the maximum limit
                                if self.currentPage == list.pdfs {
                                    self.isAnimating = true
                                } else {
                                    self.isAnimating = false
                                }
                            }
                        ), in: 0...Double((self.list.pdfs) + 1), step: 1.0)
                        
                        Text("\(self.currentPage)-\(self.currentPage+1)/\(list.pdfs)")
                            .foregroundColor(.gray)
                        
                    }
                    .padding()
                }.onAppear{
                    list.getBookData()
                }.sheet(item: $selectedItem) { item in
                    switch item {
                    case .publisher:
                        NavigationView {
                            LatestMagazineView()
                        }
                    case .addStack:
                        EmptyView()
                    }
                }
                .sheet(isPresented: $showSheet) {
                    if #available(iOS 16.0, *) {
                        VStack(alignment: .leading){
                            Button(action: {
                                
                            }, label: {
                                HStack(spacing: 14){
                                    Image("qr_scanalib").resizable().frame(width: 35,height:35)
                                    
                                    Text("Add Stack")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                    Spacer()
                                }
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                HStack(spacing: 14){
                                    //                                BlinkingImage(blinkImage: "like")
                                    Image("like").resizable()
                                        .frame(width: 35,height: 35)
                                    Text("Like").foregroundColor(.black).font(.system(size: 24))
                                    Spacer()
                                    
                                }
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                HStack(spacing: 14){
                                    Image("bookre").resizable().frame(width: 35,height: 35)
                                    Text("Report")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                    Spacer()
                                }
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                HStack(spacing: 14){
                                    Image("qr_scanalib").resizable().frame(width: 35,height:35)
                                    Text("QR Code")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                    Spacer()
                                    
                                }
                            })
                            
                            Button(action: {
                                selectedItem = .publisher
                                self.showSheet = false
                            }, label: {
                                HStack(spacing: 14){
                                    Image("publisher_icon").resizable().frame(width: 35,height: 35)
                                    NavigationLink(destination: LatestMagazineView(), label: {
                                        Text("Publisher").foregroundColor(.black).font(.system(size: 24))
                                    })
                                   
                                    Spacer()
                                }
                            })
                            
                            
                        }.padding(.leading).presentationDetents([.fraction(0.35)])
                            .presentationDragIndicator(.hidden)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
                if self.searchView{
                    SearchContentView(closebtn: $searchView)
                }
            BookThumbnailView(isOpenThumbnail: self.$isOpenThumbnail, currentPage: self.$currentPage)
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.black.opacity(0.2))
                .offset(x: self.isOpenThumbnail ? 0 : 2*UIScreen.main.bounds.width)
                .animation(.linear(duration: 0.65))
            
        }

    }
}

struct PDFKitView_Previews: PreviewProvider {
    static var previews: some View {
        PDFKitView()
    }
}
