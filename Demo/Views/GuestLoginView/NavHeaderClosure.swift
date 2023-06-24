//
//  NavHeaderClosure.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 06/04/23.
//

import SwiftUI

//struct NavHeaderClosure<Content: View>: View {
//    @Environment(\.dismiss) var dismiss
//    @State var title: String = ""
//    let content: () -> Content
//
//    var body: some View {
//
//            VStack(spacing: 0) {
//                HStack(spacing: 25) {
//                    Button(action: {
//                        dismiss()
//                    }, label: {
//                        Image(systemName: "arrow.backward")
//                            .font(.system(size: 22, weight: .heavy))
//                            .foregroundColor(.white)
//                    })
//
//                    Text(title)
//                        .font(.system(size: 24, weight: .semibold))
//                        .foregroundColor(.white)
//
//                    Spacer()
//                }
//                .padding(.horizontal)
//                .frame(width: UIScreen.main.bounds.width, height: 65)
//                .background(Color("orange"))
//
//
//                // Call the content closure to add the dynamic content
//                content()
//
//                Spacer()
//            }
//
//    }
//}


struct NavHeaderClosure<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    let content: () -> Content
   
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                // Use navigationBarBackButtonHidden modifier to hide default back button
                NavigationLink(destination: EmptyView().navigationBarTitle(""), isActive: .constant(false)) {
                    EmptyView()
                }
                .frame(width: 0, height: 0)
                .disabled(true)
                .hidden()
                
                HStack(spacing: 25) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.white)
                    })
                    
                    Text(title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width, height: 65)
                .background(Color("orange"))
                
                // Call the content closure to add the dynamic content
                content()
                
                Spacer()
            }.edgesIgnoringSafeArea(.bottom)
            // Use navigationBarBackButtonHidden modifier to show custom back button
            .navigationBarBackButtonHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}




//struct NavHeaderClosure_Previews: PreviewProvider {
//    static var previews: some View {
//        NavHeaderClosure(, content: <#() -> _#>)
//    }
//}
