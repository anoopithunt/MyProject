//
//  GuestUserUploadView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import SwiftUI

struct GuestUserUploadView: View {
    @StateObject var list = GuestUserUploadViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavHeaderClosure(title: "Public Upload PDFs"){
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(list.datas, id: \.id){ item in
                            
                            
                            
                            VStack(alignment: .leading){
                                AsyncImage(url: URL(string: item.book_media.url)){ img in
                                    img.resizable().frame(height: 235)
                                        .cornerRadius(6)
                                    
                                }placeholder: {
                                    Image("logo_gray").resizable().frame(height: 235).cornerRadius(6)
                                }
                                Text(item.name).foregroundColor(Color("default_"))
                                Text("By: \(item.author_name)").foregroundColor(Color("maroon"))
                                Text("Published: \(item.published)").foregroundColor(Color("default_"))
                                Spacer()
                            }.padding(10)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                            
                        }
                        
                    }
                    
                }.refreshable(action: {
                  //Refresh Action for recall the API
                })
            }.onAppear{
                list.getGuestUserUploadBookData()
            }
        }
    }
}

struct GuestUserUploadView_Previews: PreviewProvider {
    static var previews: some View {
        GuestUserUploadView()
    }
}
