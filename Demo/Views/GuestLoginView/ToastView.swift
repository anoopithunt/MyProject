//
//  ToastView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 04/04/23.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        VStack {
            Spacer()
           HStack{
               Image("ic_launcher")
                   .resizable()
                   .frame(width: 35, height: 35)
                   .cornerRadius(8)
               Text(message).font(.system(size: 18, weight: .medium)).lineLimit(2)
                    .foregroundColor(.black)
           }.padding(8)
                .background(Color.white).cornerRadius(10)
            
        }.shadow(color: .gray, radius: 0.3).padding(.horizontal)

    }
}


struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastViewExample()
    }
}


extension View {
    func toast<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                content()
                    .transition(.opacity)
                    .onAppear {
                                         
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isPresented.wrappedValue = false
                            
                        }
                        
                    }
            }
        }
    }
}



struct ToastViewExample: View {
    @State private var showToast = false
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            
            
            Button("Show Toast") {
                showToast = true
            }
        }
        .toast(isPresented: $showToast) {
            ToastView(message: "This is a toast message.....")
                
        }
    }
}
