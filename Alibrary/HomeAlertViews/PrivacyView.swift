//
//  PrivacyView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 01/11/22.

import Foundation
import SwiftUI
import WebKit
import RichText

struct PrivacyAlertView: View {
    @State var shown = false
    var body: some View {
        ZStack {
                VStack {
                    Image("11")
                        .resizable().frame(width: 300, height: 300)
                    VStack {
                        Button("Privacy Alert Button") {
                            shown.toggle()
                        }
                    }
                    Spacer()
                }.blur(radius: shown ? 30 : 0)
            
            if shown {
               PrivacyView(isShown: $shown)
            }
            
        }
    }
    
}
    
  
struct PrivacyView: View {
    @Binding var isShown: Bool
    let screenSize = UIScreen.main.bounds
  @State var list = String()
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).frame(height: screenSize.height).ignoresSafeArea()
            
            
            VStack{
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(4)
                Text("Privacy Policy (v: 1.0.34)").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding()
                .padding(.leading,12)
                .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
            
            ScrollView(.vertical) {
                VStack {
                    if isLoading{
                        HStack(alignment: .center){
                            CircleProgressView()
                        }
                        
                    }else{
//                        Text(html: list).padding()
                        RichText(html: list).padding()
                        HStack{
                            Spacer()
                            Button(action: {
                                self.isShown = false
                                
                            }){
                                Text("Okay").font(.headline)
                                    .frame(width: 116, height: 45, alignment: .center)
                                    .background(Color("default_"))
                                    .foregroundColor(.white)
                                    .cornerRadius(33)
                            }.padding(23)
                        }
                    }
                    
                    
                    
                  
                    
                }
                .onAppear{
                    fetchApi()
                }
            }
            
            
        }
                .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.9)
                .background(Color("white").opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 4.0, style: .continuous))
                                        .offset(y: isShown ? 0 : screenSize.height)
                                    .animation(.spring(), value: isShown)
        }
//            .shadow(color: .gray, radius: 50, x: 9, y: 9)
            
            
        
       
    }
    
    func fetchApi(){
        let url = URL(string: "https://www.alibrary.in/api/privacy-policy")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
              if let results = try? JSONDecoder().decode(PrivacyPolicyModel.self, from: data){
                  DispatchQueue.main.async {
                    self.list = results.pravaciPolicy.description
                      self.isLoading = false
                      
                                     }
                }
               
            }
            
            
        }.resume()
    }
    
    
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyAlertView()
    }
    
    
}

public struct PrivacyPolicyModel:Decodable {
    public var pravaciPolicy: PrivacyPolicy


}

public struct PrivacyPolicy: Decodable {

    public let description: String


}



