//
//  SelfLibraryView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 07/04/23.
//

import SwiftUI

struct SelfLibraryView: View {
    var totalUploads: String = ""
    var totalStacks: String = ""
    var body: some View { 
        NavHeaderClosure(title: "Self Library"){
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                
                VStack{
                    
                    NavigationLink(destination: {
                        UploadListView().navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
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
                    
                    Spacer()
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}



struct SelfLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        SelfLibraryView()
    }
}
