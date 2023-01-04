//
//  SlideMenuViews.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 26/08/22.
//

import SwiftUI

struct SlideMenuViews: View {
    
    
    var body: some View {
        ContentView()
//        Home()
      }
      
    }

struct SideMenuViews_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuViews()
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
                    .foregroundColor(.orange)
                }
                Spacer(minLength: 0)
                Text("Alibrary")
                Spacer(minLength: 0)
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.red.opacity(0.2), radius: 3, x: 0, y: 3)
            Spacer()
                .frame( height: 23)
            ScrollView{
            CorouserView()
//     GridLayoutView()
            }
           
        }
        .padding(.top)
        .contentShape(Rectangle())
        .background(Color.white)
 
//
        
    }
}


struct Home : View {
    
    @State var width = UIScreen.main.bounds.width-105
    @State var x = -UIScreen.main.bounds.width+105
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            HomePageView(x: $x)
            Spacer()
            SlideMenu()
                .shadow(color: Color.yellow.opacity(x != 0 ?0 : 0.1), radius: 5, x: 5, y: 0)
                .offset(x: x, y:0)
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
//                else{
//                    x = value.translation.width
//                }
               
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
