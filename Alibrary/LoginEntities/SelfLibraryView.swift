//
//  SelfLibraryView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import SwiftUI

struct SelfLibraryView: View {
    var totalUploads: String = ""
    var totalStacks: String = ""
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            
            VStack(spacing:22){
                NavigationView{
                    NavHeaderClosure(title: "Self Library", content: {
                        
                        VStack{
                            
                            NavigationLink(destination: {
//                                UploadListView().navigationTitle("")
//                                    .navigationBarHidden(true)
//                                    .navigationBarBackButtonHidden(true)
                            }, label: {
                                LibraryViewTile(total: totalUploads, title: "PDF Files", headTitle: "Total Uploads", icon: "t_upload")
                            }
                                           )
                           NavigationLink(destination: {
                               StacksView().navigationTitle("")
                                   .navigationBarHidden(true)
                                   .navigationBarBackButtonHidden(true)
                           }, label: {
                               LibraryViewTile(total: totalStacks, title: "Stack Files", headTitle: "Total Stacks", icon: "t_stack")
                           })
                            
                            
                            
                        }
                    })
                    Spacer()
                }.navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

struct SelfLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        SelfLibraryView()
    }
}
