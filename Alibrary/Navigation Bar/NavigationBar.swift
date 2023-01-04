////
////  NavigationBar.swift
////  Alibrary
////
////  Created by Sandeep Kesarwani on 04/07/22.
////
//
//import SwiftUI
//
//struct NavigationBar: View {
//    var body: some View {
//       // defaultNavView
//       
//            
//       
//        CustomNavBarContainerView {
//           
//            
//        }
//        
//    }
//}
//
//struct NavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationBar()
//    }
//}
//
//
//extension NavigationBar{
//    private var defaultNavView: some View {
//        NavigationView{
//            ZStack{
//                Color.yellow.ignoresSafeArea()
//                
//                NavigationLink(
//                    destination: Text("Destination")
//                    .navigationTitle("Title 2")
//                    .navigationBarBackButtonHidden(false),label: {
//                    Text("Navigation")
//                    })
//            }
//            
//        }
//    }
//}
