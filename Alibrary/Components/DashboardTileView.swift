//
//  Dashboardview.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/07/22.
//

import SwiftUI

struct DashboardTileView: View {
    let tileName: String
    let tileCount: String
   @State var  iconTileImage: String?
    let mainTileImage: String
    
    var body: some View {
        VStack(spacing:6){
            HStack {
                Spacer()
                Image(iconTileImage ?? "")
                    .resizable()
                    .frame(width: 20, height: 27, alignment: .center)
                    .padding(.leading,35)
                Spacer()
                    .frame(width: 14)
                Text(tileCount)
                    .bold()
                    .font(.custom("_", size: 23))
                    .foregroundColor(Color.black.opacity(0.8))
                
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical,6)
            HStack {
            Image(mainTileImage)
                    .resizable()
                    .frame(width: 90, height: 84, alignment: .leading)
                    .padding(.leading,5)
                    .padding(.bottom)
                    .padding(.top,-25)
                
            Spacer()
                
            }.padding(.horizontal)
            ZStack(alignment: .center){
                Rectangle()
                .size( width: 442, height: 2)
                .foregroundColor(.black)
                Text(tileName)
                    .font(.custom("Title", size: 18))
                    .foregroundColor(.white)
                
            }.padding(.bottom,6)
            .background(Color.gray.opacity(0.9))
            
        }
        .background(Color(hue: 1.0, saturation: 0.016, brightness: 0.83))
        .frame(width: UIScreen.main.bounds.width*0.43, height: UIScreen.main.bounds.height*0.18, alignment: .center)
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 5)
        
    }
}

struct DashboardTileView_Previews: PreviewProvider {
    static var previews: some View {
//        VStack {
            DashboardTileView(tileName: "Stack" , tileCount: "1", iconTileImage: "stack_gray", mainTileImage: "stack_prime")

//        }
    }
}
