//
//  SideMenuView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 23/08/22.
//

import SwiftUI

struct SideMenuViews: View {
    
    
    var body: some View {
        Home()
      }
      
    }

struct SideMenuViews_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuViews()
    }
}


struct HomePageView: View{
    
    @Binding var x: CGFloat
    
    var body: some View{
        VStack {
            HStack {
                Button(action: {
                    
                    withAnimation{
                        x = 0
                    }
                    
                    
                }){
            Image(systemName: "line.3.horizontal")
                        .font(.system(size: 24))
                    .foregroundColor(.white)
                }
                Spacer(minLength: 0)
                Text("Alibrary")
                Spacer(minLength: 0)
            }
            .padding()
            .background(Color.orange)
            .shadow(color: Color.red.opacity(0.2), radius: 3, x: 0, y: 3)
   
//     GridLayoutView()
      
             
                  Spacer()
           
        }
        .padding(.top)
        .contentShape(Rectangle())
        .background(Color.white)
     
        
        
        
    }
}


struct Home : View {
    
    @State var width = UIScreen.main.bounds.width-105
    @State var x = -UIScreen.main.bounds.width+105
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            HomePageView(x: $x)
//            Spacer()
            SlideMenu()
                .shadow(color: Color.yellow.opacity(x != 0 ?0 : 0.1), radius: 5, x: 5, y: 0)
                .offset(x: x)
                .background(Color.gray.opacity(x == 0 ? 0.1: 0).ignoresSafeArea(.all, edges: .vertical).onTapGesture {
                    withAnimation{
                        x = -width
                    }
                })
//
        }
        .gesture(DragGesture().onChanged({(value) in
            withAnimation{
              
                
                if value.translation.width > 0{
                    if x < 0 {
                    x = -width+value.translation.width
                }
                }
                else{
                    x = value.translation.width
                }
               
            }
        }).onEnded({(value) in
            
            withAnimation{
                if -x < width/2{
                    x = 0
                }else{
                    x = -width
                }
                
            }
            
        }))
    }
}






struct SlideMenu : View {
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var show = true
    var body: some View{
        
        
        
        
        HStack{
            VStack(alignment: .leading){
                Image("Anoop")
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
                          Image("Anoop")
                          .resizable()
                          .frame(width: 24, height: 24)
                        }
                        
                        Spacer(minLength: 0)
                        Button(action: {
                            
                        })
                  {
                          Image("Anoop")
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


struct FollowView : View {
    
    var count: Int = 0
    var title: String = ""
    var body: some View{
       
        HStack{
            Text("\(count)")
            Text("\(title)")
        }
        }
}

var menuButtons = ["Profile","Lists","Topics", "Bookmarks","Moments"]
struct MenuButton: View{
    var title: String
    var body: some View{
        HStack(spacing: 15){
        Image("Anoop").resizable().frame(width: 34, height: 34)
        Text(title)
                .fontWeight(.bold)
            .foregroundColor(.black)
        }
        .padding(.vertical,12)
    }
}
