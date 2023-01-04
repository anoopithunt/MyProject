//
//  GuestUploadListView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/03/23.
//

import SwiftUI

struct GuestUploadListView: View {
    @StateObject var list = GuestUploadListDashboardViewModel()
    
    @Environment(\.dismiss) var dismiss
  
    var body: some View {
        
        NavigationView{
            ZStack{
                Image("u").resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 8){
                    HStack{
                        Button(action: {
                            dismiss()
                        },
                               label: {
                            
                            Image(systemName: "arrow.backward")
                            
                                .font(.system(size:24, weight:.heavy))
                            
                                .foregroundColor(.white).padding(.leading)
                        })
                        Text("Upload List")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                        Spacer()
                        Image("cloud_screen").resizable().frame(width: 30, height: 25).padding(.trailing)
                        
                    } .frame(width: UIScreen.main.bounds.width, height: 65)
                        .background(Color("orange"))
                    
                  
                        HStack{
                            NavigationLink(destination: {
                               // GuestPublishedView().navigationTitle("")
//                                    .navigationBarHidden(true)
//                                    .navigationBarBackButtonHidden(true)
                            }, label: {
                                GuestUploadListTileView(uploadData: $list.publishPDFs, uploadIcon: "pdf_gray", uploadImage: "published", uploadType: "Published PDF")
                            })

                            NavigationLink(destination: {
                                //GuestUnPublishedView().navigationTitle("")
//                                    .navigationBarHidden(true)
//                                    .navigationBarBackButtonHidden(true)
                            }, label: {
                                GuestUploadListTileView(uploadData: $list.unPublishPDFs, uploadIcon: "pdf_gray", uploadImage: "unpublished", uploadType: "Unpublished PDF")

                            })
                        }
                        
                        
                        HStack{
                            NavigationLink(destination: {
                              //  GuestDraftView().navigationTitle("")
                                    //.navigationBarHidden(true)
                                    //.navigationBarBackButtonHidden(true)
                            }, label: {

                                GuestUploadListTileView(uploadData: $list.draftPdfs, uploadIcon: "pdf_gray", uploadImage: "draft", uploadType: "Draft PDF")

                            })



                            NavigationLink(destination: {
                                //GuestDeleteListView().navigationTitle("")
                                    //.navigationBarHidden(true)
                                    //.navigationBarBackButtonHidden(true)
                            }, label: {

                                GuestUploadListTileView(uploadData: $list.deletePdfs, uploadIcon: "delete_gray_new", uploadImage: "delete_uploads", uploadType: "Delete PDF")
                            })


                        }
                    
                  
                    Spacer()
                    
                }.onAppear{
                    list.getUploadListDashboardData()
                }
            }
        }
        
    }
}

struct GuestUploadListView_Previews: PreviewProvider {
    static var previews: some View {
        GuestUploadListView()
    }
}
