//
//  ExView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 10/08/22.
//

import SwiftUI

struct ExView: View {
    @State var full_name: String?
    @State var totalBookViews: String?
    @State  var totalfollowers: String?
    @State var totalBooks: String?
    @State var name: String?
    @State var url: String = "InCompleted"
    @State private var templateColor: Color =  Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)).opacity(0.5)

    var body: some View {
        VStack {

         
            VStack {
                HStack(alignment: .top , spacing: 6) {
                    Image(systemName: "eye")
                        .padding(.leading,2)
                    Text(totalBookViews ?? "23")
                        .padding(.leading,3)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.bottom)
             
                Image(systemName: "externaldrive.badge.wifi")
                    .resizable()
                    .frame( height: 96, alignment:.center)
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(.all,8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))

                Text(full_name ?? "Alibrary")
                    .font(.system(size: 16))
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.vertical,6)
                
                HStack {
                    Image(systemName: "plus.rectangle.on.folder")
                        .padding(.leading)
                    Text(totalBooks ?? "3433")
                    Spacer()
                    Text(name ?? "")
                        .font(.system(size: 12))
                    Spacer()
                }
                .background(Color.white)
                
                HStack(spacing: 3){
                   Text("Follow")
                    
                        .frame(width: 112,height: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(22)

                     
                        .overlay(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color.white, lineWidth: 1)
                                
                                )
//                     .padding(.leading)
                    
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .padding(.leading,5)
                    Text(totalfollowers ?? "2.13k")
                        .foregroundColor(.white)
                        .padding(.trailing,1)
                        .font(.system(size: 12))
//                    Text(email ?? "")
//                        .foregroundColor(.white)
//                        .padding(.leading)
                       
                }
                .padding(.vertical,12)
               
             
            }
            .padding(.vertical)
        
            .frame(width:UIScreen.main.bounds.width/2.2)
            .background(templateColor)
            .cornerRadius(13)
          
       
        }
//        .padding(.vertical)

    }
}

struct ExView_Previews: PreviewProvider {
    static var previews: some View {
        ExView()
    }
}
