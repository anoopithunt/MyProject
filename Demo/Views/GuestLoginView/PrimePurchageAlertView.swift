//
//  PrimePurchageAlertView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 28/12/22.
//

import SwiftUI

struct PrimePurchageView: View {
    @Binding var isShown: Bool
    @State private var isLoading = true
    let screenSize = UIScreen.main.bounds
  @State var list = String()
    var body: some View {
        
        ZStack {
            Color(.black).opacity(0.3).ignoresSafeArea()
            VStack{
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(26)
                Text("Guest Prime Packeges").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding()
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width*0.94, height: 80).background(Color("orange"))
//            Spacer()
//            ScrollView{
                VStack {
                    if isLoading {
                       
                        CircleProgressView().padding()
                                                   
                                         
                    } else {
                        Text(html: list).padding()
                    }
                    HStack{
                        Spacer()
                        Button(action: {
                                            self.isShown = false
                            
                        }){
                            Text("**Cancel**").font(.system(size: 22))
                                .frame(width: 122, height: 50, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }.padding(23)
                    }
                    
                }
                .onAppear{
//                    fetchApi()
                }
//            }
            
            
        }
            .frame(width: screenSize.width * 0.9, height: .infinity)
                .background(Color.white.opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
                                        .animation(.spring(), value: isShown)

        }
            
            
        
       
    }
}

struct PrimePurchageAlertView_Previews: PreviewProvider {
    static var previews: some View {
        PrimePurchageAlertView()
    }
}



struct PrimePurchageAlertView: View {
    @State var shown = false

    var body: some View {
        ZStack {
                VStack {
                    Image("1")
                        .resizable().frame(width: 300, height: 300).cornerRadius(200)
                   
                        Button("About Us ") {
                            shown.toggle()
                        }
                    
                    Spacer()
                }

            
            if shown {
                PrimePurchageView(isShown: $shown)
            }
            
        }
    }
    
}


