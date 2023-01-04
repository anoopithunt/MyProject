//
//  LibrariesView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import SwiftUI

struct LibrariesView: View {
    @State private var isPublicLinkClicked = true
       @State private var isSelfLinkClicked = false
    @StateObject var list = GuestLibraryViewModel()
    var body: some View {
        ZStack{
           
                
            NavigationView{
                NavHeaderClosure(title: "Libraries"){
                    ZStack{
                        Image("u").resizable().ignoresSafeArea()
                        VStack{
                            HStack(spacing: 10){
                                NavigationLink(destination: {
                                
                                LibraryView(totalUploads: "\(list.guestPDFCount)", totalStacks: "\(list.guestStackCount)", title: "Public Library")
                                        .navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                            }, label: {
                               
                                    LibrariesViewTile(title: "Public", image: "public_stack", stackCount: "\(list.guestStackCount)", pdfCount: "\(list.guestPDFCount)")
                                                               
                            })
                                
                                NavigationLink(
                                    destination: {
                                    
                                        SelfLibraryView(totalUploads: "\(list.ownPDFCount)", totalStacks: "\(list.ownStackCount)")
                                            .navigationTitle("")
                                            .navigationBarHidden(true)
                                            .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    
                                    LibrariesViewTile(title: "Self", image: "self_stk", stackCount: "\(list.ownStackCount)", pdfCount: "\(list.ownPDFCount)")
                                }).accentColor(.green)
                            }.padding(.top)
                            Spacer()
                        }
                    }
                }.onAppear{
                    list.getLibraryData()
                }
                
            }
        }
     
    }
}

struct LibrariesView_Previews: PreviewProvider {
    static var previews: some View {
        LibrariesView()
    }
}
