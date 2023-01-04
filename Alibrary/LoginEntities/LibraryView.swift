//
//  LibraryView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import SwiftUI

struct LibraryView: View {
    var totalUploads: String = ""
    var totalStacks: String = ""
    var titleHeader: String = ""
    var title: String = ""
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            
            VStack(spacing:22){
                NavigationView{
                    NavHeaderClosure(title: title, content: {
                        
                        VStack{
                            NavigationLink(destination: {
                                GuestUserUploadView()
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)
                            }, label: {
                                LibraryViewTile(total: totalUploads, title: "PDF Files", headTitle: "Total Uploads", icon: "t_upload")
                                
                            })
                            
                            NavigationLink(destination: {
                                
                                GuestUserStackView()
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)},
                                           label: {
                                LibraryViewTile(total: totalStacks, title: "Stack Files", headTitle: "Total Stacks", icon: "t_stack")
                           
                            })
                            
                            Spacer()
                            
                        }
                        
                    })
                    Spacer()
                }
            }
        }
    }
}




struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
