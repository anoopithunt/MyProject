//
//  SlideMenu.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 26/08/22.
//

import SwiftUI

struct SlideMenu : View {
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var show = true
    var body: some View{
        
        
        
        
        HStack{
            VStack(alignment: .leading){
                Image("2")
                    .resizable().frame(width: 60, height: 60).clipShape(Circle())
                HStack(alignment: .top, spacing: 12){
                    VStack(alignment: .leading, spacing: 12){
                        Text("Anoop Mishra").font(.title3).fontWeight(.bold).foregroundColor(.orange)
                        Text("@Anoop_Mishra").foregroundColor(.gray)
                        HStack(spacing: 21){
                            FollowView(count: 8, title: "following").onTapGesture {
                               
                            }
                            
                            FollowView(count: 18, title: "followers").onTapGesture {
                               
                            }
                            
                        }.padding(.top,10)
                        Divider()
                            .padding(.top,10)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                        withAnimation{
                            show.toggle()
                        }
                        
                        
                    }, label: {
                        Image(systemName: show ? "chevron.down" : "chevron.up").foregroundColor(.orange)
                    })
                }
                VStack(alignment: .leading, spacing: 12){
                    
                    
                    
                    
                }
                
                VStack(alignment: .leading){
                    ForEach(menuButtons, id: \.self){ menu in
                        
                        
                        Button(action: {
                            
                        })
                  {
                            MenuButton(title: menu)
                        }
                       
                        
                    }
                    Divider()
                        .padding(.top)
                    
                    Button(action: {
                        
                    })
              {
                        MenuButton(title: "Twitter ads")
                    }
                    Divider()
                    
                    
                    Button(action: {
                        
                    })
              {
                       Text("Setting and Privacy")
                    }
                        .padding(.top)
                   
                    Button(action: {
                        
                    })
              {
                       Text("Help Center")
                    }
                    
                   
                        .padding(.top,20)
                   Spacer(minLength: 0)
                    Divider()
                        .padding(.bottom)
                    
                    HStack {
                        Button(action: {
                            
                        })
                  {
                          Image("2")
                          .resizable()
                          .frame(width: 24, height: 24)
                        }
                        
                        Spacer(minLength: 0)
                        Button(action: {
                            
                        })
                  {
                          Image("1")
                          .resizable()
                          .frame(width: 24, height: 24)
                        }
                    }
                   
                    
                }
                .opacity(show ? 1: 0)
                .frame( height:  show ? nil : 0)
                VStack(alignment: .leading){
                    Button(action: {
                        
                    }){
                        Text("Create New Account")
                    }
                    
                    
                    
                    Button(action: {
                        
                    }){
                        Text("Add a Existing Account")
                    }
                    Spacer(minLength: 0)
                    
                }
                .opacity(show ? 0: 1)
                .frame( height:  show ? 0 : nil)
                
       //Hiding this view of clicking button
                
            }
            .padding(.horizontal,20)
            .padding(.top, edges!.top == 0 ? 15: edges?.top)
            .padding(.bottom, edges!.top == 0 ? 15: edges?.bottom)
            .frame(width: UIScreen.main.bounds.width-105).background(Color.white).ignoresSafeArea(.all, edges: .vertical)
            Spacer(minLength: 0)
            
        }.frame(width: UIScreen.main.bounds.width)
        .background(Color.yellow.opacity(0)).ignoresSafeArea(.all, edges: .vertical)
    }
}

struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenu()
    }
}
