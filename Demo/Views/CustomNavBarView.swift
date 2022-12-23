//
//  CustomNavBarView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 05/12/22.
//

import SwiftUI

enum SelectedScreen {
    case home
    case screen1
    case screen2
    case alert
    case explorecategory
    case plans
}

struct CustomNavBarView: View {

//
//    @State private var showMenu: Bool = false
//
////    @State private var showMenu = false
//    @State private var selected: SelectedScreen = .home
//
//    enum SwipeHorizontalDirection: String {
//          case left, right, none
//      }
//
//      @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none { didSet { print(swipeHorizontalDirection) } }
//
    
    var body: some View {
        
        VStack {
            HStack{
                Button(action: {
                    
                    
                    
                    
                    
                }, label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title).frame(width: 40,height: 65)
                        .frame(alignment: .leading)
                        .foregroundColor(.white)
                        
                })
              
               
                
                Button(action: {
                    
                }, label: {
                
                
                ZStack {

                    HStack {
                     
                        Image(systemName: "magnifyingglass").foregroundColor(.gray).font(.body).frame(width: 30,height: 35)
                  
                        Text("search books..").foregroundColor(.gray)
                        Spacer()
                               
                    }.frame(width: UIScreen.main.bounds.width*0.5)
                            .padding(.leading, 7)
                        }
                            .frame(height: 40)
                            .background()
                            .cornerRadius(8)
                })
                Spacer()
                Button(action: {
                    
                    
                    
                    
                    
                }, label: {
                    Image("qr_c").resizable()
                        .frame(width: 30, height: 30)
                        
                })
                //for 3 dot vertical point
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .font(.system(size: 33))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 11, height: 55, alignment: .center)
                        .padding()
                        
                })
            }.padding(10)

            .frame( width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*0.06)
            
            .font(.headline)
        .background(Color.orange)
            
            Spacer()
        }
    }
}
extension CustomNavBarView {
   
    private var menuButton: some View {
        Button(action: {
            
            
//            self.showMenu = true
            
            
        }, label: {
            Image(systemName: "line.3.horizontal")
                .font(.title).frame(width: 40,height: 65)
                .frame(alignment: .leading)
                .foregroundColor(.white)
                
        })
    }
    
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarView()
    }
}
