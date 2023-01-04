//
//  TermsAndConditionView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 01/11/22.
//


import SwiftUI

import RichText



struct TermConditionAlertView: View {
    @State var shown = false
    var body: some View {
        ZStack {
                VStack {
                    Image("11")
                        .resizable().frame(width: 300, height: 300)
                    VStack {
                        Button("Terms & Condition Alert Button") {
                            shown.toggle()
                        }
                    }
                    Spacer()
                }.blur(radius: shown ? 30 : 0)
            
            if shown {
               TermsAndConditionView(isShown: $shown)
            }
            
        }
    }
    
}



struct TermsAndConditionView: View {
    @State private var scaleGesture: CGFloat = 1
       @State private var scale: CGFloat = 0.25
    let screenSize = UIScreen.main.bounds
    @State var list = String()
       @Binding var isShown: Bool
    @State private var isLoading = true
    var body: some View {
        
        
        
        ZStack {
            
            Color.gray.opacity(0.4).frame(height: screenSize.height).ignoresSafeArea()
            
            
            VStack{
                    
                    HStack{
                        Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(4)
                        Text("Terms & Conditions(v: 1.0.34)").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                        Spacer()
                    }.padding()
                        .padding(.leading,12)
                        .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
                    
                    ScrollView(.vertical,showsIndicators: true) {
                        
                        VStack {
                            
                            
                            if isLoading {


                                HStack(alignment: .center) {
                                    CircleProgressView()
                                        .padding()
                                        .onAppear{
                                        fetchApi()
                                            
                                        }
                                }


                            }
                            else{
//                                Text(html: list).padding()
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
                                    }

                                }.padding(12)
                            }
                         }
                        
                    }
                
            }
           
            .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.9)
            .background(Color("white").opacity(1))
            .clipShape(RoundedRectangle(cornerRadius: 4.0, style: .continuous))
                                    .offset(y: isShown ? 0 : screenSize.height)
                                    .animation(.spring(), value: isShown)
                               
        }
        
    }
    func fetchApi(){
        let url = URL(string: "https://alibrary.in/api/terms-conditions")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
              if let results = try? JSONDecoder().decode(TermsAndConditionModel.self, from: data){
                  DispatchQueue.main.async {
                      self.list = results.termcondition.description
                      self.isLoading = false    //for loading View shown
                  }
                  
              }
               
            }
            
            
        }.resume()
    }
    
    
}

struct TermsAndConditionView_Previews: PreviewProvider {
   
    static var previews: some View {
        TermConditionAlertView()
    }
}

// Model of Terms And Conditions
public struct TermsAndConditionModel:Decodable {
    public var termcondition: Termcondition


}

public struct Termcondition: Decodable {

    public let description: String


}



