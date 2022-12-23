//
//  StacksView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 05/12/22.
//

import SwiftUI

struct StacksView: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                Image("u").resizable()
                
                VStack {
                    HStack(spacing: 25){
                        Button(action: {
//                            dissmiss()
                        }, label: {
                            Image(systemName: "arrow.backward").font(.system(size:22, weight:.heavy)).foregroundColor(.white)
                        })
                        Text("Stacks").font(.system(size: 22, weight: .heavy)).foregroundColor(.white)
                        Spacer()
                        Image("stack_add_blue_").resizable().frame(width: 45, height: 55)
                       
                    }.padding().frame(width: UIScreen.main.bounds.width, height: 65).background(Color("orange"))
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 12).fill(Color.white)
                            Image("add_stack").resizable().frame(width: 245, height: 255)
                        }.background(Color.white).frame(width: UIScreen.main.bounds.width/2.1, height: UIScreen.main.bounds.height/3.1)
                            .cornerRadius(12).shadow(color: .gray.opacity(0.5),radius: 1)
                        Spacer()
                    }.padding()
                    Spacer()
                }
            }
        }
    }
}

struct StacksView_Previews: PreviewProvider {
    static var previews: some View {
        StacksView()
    }
}


