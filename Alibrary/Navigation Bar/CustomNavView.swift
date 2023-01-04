////
////  CustomNavView.swift
////  Alibrary
////
////  Created by Sandeep Kesarwani on 04/07/22.
////
//
//import SwiftUI
//
//struct CustomNavView<Content: View>: View {
//    let content: Content
//
//    init(@ViewBuilder content: () -> Content){
//        self.content = content()
//    }
//
//
//    var body: some View {
//        NavigationView {
////            CustomNavBarContainerView {
////                Color.green.ignoresSafeArea()
////            }
//           // .navigationBarHidden(true)
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//
//    }
//}
//
//struct CustomNavView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomNavView{
//            Color.red.ignoresSafeArea()
//        }
//    }
//}
