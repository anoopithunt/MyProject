//
//  CustomNavBarConatiner.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 04/07/22.
//

//import SwiftUI
//
//struct CustomNavBarContainerView< Content: View>: View {
//    let content: Content
//
//    init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
//
//    var body: some View {
//        VStack(spacing: 0){
//            CustomNavBarView()
//                .frame( maxWidth: .infinity , maxHeight: .infinity)
//            Spacer()
//
//
//        }
//    }
//}
//
//struct CustomNavBarContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomNavBarContainerView {
//            ZStack {
//                Color.yellow.ignoresSafeArea()
//                Text("Hello Youtube")
//                    .foregroundColor(.green)
//                    .font(.largeTitle)
//            }
//        }
//    }
//}
