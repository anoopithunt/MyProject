//
//  ReadCreditsView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/11/22.
//

import SwiftUI
import RichText

struct ReadCreditsView: View {
    @StateObject var list = ReadCreditsViewModel()
    var body: some View {
        
        
        
        VStack {
            
            Spacer().frame(height: 110)
            VStack(spacing: 0){
                VStack(spacing:0) {
                    HStack(spacing: 0 ) {
                        
                        Text("**Read Credits**").frame(width: 134, height:50).border(.cyan,width: 1.1)
                        
                        Text("**Qty**").frame(width: 130, height:50).border(.cyan,width: 1.1)
                        Text("**₹ Price**").frame(width: 110, height:50).border(.cyan,width: 1.1)
                        
                    }.border(.cyan,width: 0.6).background(Color.cyan.opacity(0.6))
                    //                            Spacer()
                    ForEach(list.rcDatas, id: \.id){ item in
                        HStack(spacing: 0 ) {
                            
                            RichText(html: item.name).placeholder(content: {
                                Text("Loading...")
                            }).frame(width: 134, height:50).border(.cyan,width: 1.1)
                            
                            Text("\(item.rc_from) to \(item.rc_to)").frame(width: 130, height:50).border(.cyan,width: 1.1)
                            let p = item.price/10
                            Text("\(item.price/100).\(p%10) ₹").frame(width: 110, height:50).border(.cyan,width: 1.1)
                            
                        }.border(.cyan,width: 1.0)
                    }
                    //                            Spacer()
                }.frame( height: 200).border(.cyan,width: 2)
                Text("**Read credit**\nRead Credit is a great book reading option by which multiple paidbooks can also be read easily by doanting read credit points and the read credit purchased by the user is provide with a life time validity. ").padding([.top, .leading, .bottom]).foregroundColor(.black.opacity(0.7))
                
                
                
                Button(action: {
                    
                    
                }, label: {
                    Text("**Purchase Point**").font(.system(size: 26)).foregroundColor(.white).frame(width: UIScreen.main.bounds.width*0.8, height: 66).background(Color("green")).cornerRadius(28)
                    //                                .padding()
                }).overlay(
                    RoundedRectangle(cornerRadius: 38)
                        .stroke(Color.white, lineWidth: 3)
                )
                
                
            }
            Spacer(minLength: 30)
            
            
            
            
        }
    }
}
    

struct ReadCreditsView_Previews: PreviewProvider {
    static var previews: some View {
        ReadCreditsView()
    }
}
