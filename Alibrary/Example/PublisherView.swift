//
//  PlansPageView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 23/07/22.
//

import SwiftUI

struct PublisherView: View {
//    @State var searchBox: String = ""
    
    @State var full_name: String?
    @State var totalBookViews: String?
    @State  var totalfollowers: String?
    @State var totalBooks: String?
    var color = ["#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0","#b9245c","#61be6d","#7789ff","#a453a0","#ea4951","#8557a0"]

    var body: some View {
        VStack {

        
            VStack (alignment: .center, spacing: -4){
//                Spacer().frame(height: 23)
                HStack(alignment: .top , spacing: 6) {
                    Image(systemName: "eye")
//                        .padding()
                    Text(totalBookViews ?? "")
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.all,12)
             
                Image("7")
                    .resizable()
                    .frame( height: 96, alignment:.center)
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(.all,8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
//Spacer()
                Text(full_name ?? "")
                    .font(.system(size: 16))
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.vertical)
                Text("-")
                    .font(.system(size: 16))
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                
                HStack(alignment: .top , spacing: 6) {
                    Image("pdf_gray").resizable()
                        .padding(.leading,5)
                        .frame(width: 25, height: 24)
                    Text(totalBooks ?? "122")
                    Spacer()
                }.padding(.leading,5)
                    .frame(height: 24)
                    .background(Color.white)
                
                HStack(spacing: 3){
                   Text("Follow")
                        .frame(width: 122,height: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                     
                        .overlay(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color.white, lineWidth: 1)
                                
                                )
                        .padding(.leading)
                    
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .padding(.leading)
                    Text(totalfollowers ?? "")
                        .foregroundColor(.white)
                        .padding(.leading)
                       
                }
                .padding()
                Spacer()
             
            }
           
           
            .frame(width: 180, height: 284)
            .background(.green)
        .cornerRadius(13)

       
        }
        
    }
}

struct PublisherView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherView(full_name: "Alibrary", totalBookViews: "0", totalfollowers: "0", totalBooks: "")
            .preferredColorScheme(.light)
    }
}
