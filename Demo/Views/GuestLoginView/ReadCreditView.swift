//
//  ReadCreditView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 12/12/22.
//

import SwiftUI

struct ReadCreditView: View {
    @State var shown = true
    var body: some View {
        NavigationView {
            ZStack {
                Image("u").resizable()

                ZStack {

                    VStack {
                        HStack(spacing: 25){
                            
                            Button(action: {
    //                            dissmiss()
                            }, label: {
                                Image(systemName: "arrow.backward").font(.system(size:22, weight:.bold)).foregroundColor(.white)
                            })
                            
                            Text("**Read Credit(RC)...**").font(.system(size: 25, weight: .semibold)).foregroundColor(.white)
                            Spacer()
                            Text("30 RC").font(.system(size: 24, weight: .bold)).foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                self.shown = true
                            }, label: {
                                Image(systemName: "plus").font(.system(size: 22, weight: .bold)).foregroundColor(.white)
                            })
                            
                           
                        }.padding().frame(width: UIScreen.main.bounds.width, height: 65).background(Color("orange"))

                        Spacer()
                    }
                    
                    
                    if shown {
                        BuyReadCreaditAlert(rcShow: $shown)
                    }
                }
            }
        }
    }
}

struct ReadCreditView_Previews: PreviewProvider {
    static var previews: some View {
        ReadCreditView()
    }
}
struct BuyReadCreaditAlert: View{
    @Binding var rcShow: Bool
    @State private var isLoading = true
    let screenSize = UIScreen.main.bounds
    @State var text: String = ""
    @State var rupee: String = ""
    var body: some View{
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(12)
                Text("Buy Read Credit").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding()
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
           
                VStack {

                    FloatingTextField(placeHolder: "Read Credit (Minimum 300)", text: $text).padding()
                    FloatingTextField(placeHolder: "Total Cost (Rupee)", text: $rupee).padding()
 

                    HStack{
                        Spacer()
                        Button(action: {
                                            self.rcShow = false
                            
                        }){
                            Text("Cancel").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }.padding(12)
                        Button(action: {
                                           
                            
                        }){
                            Text("Buy Now").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(Color("green"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }.padding(23)
                    }
                    
           
               
            }
            
            
        }
            .frame(width: screenSize.width * 0.9, height: .infinity)
                .background(Color.white.opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                        .animation(.spring(), value: rcShow)

        }
            
        
       
    }
    }
