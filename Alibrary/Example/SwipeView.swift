//
//  SwipeView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/07/22.
//

import SwiftUI

struct SwipeView: View {
    
    private var numberofImages = 5

    @State  var currentPage = 0
    func skip(){
        withAnimation{
                    currentPage = totalPages
        }
    }
        func next(){
            
            withAnimation{
               
                        if currentPage <= totalPages-1{
                            currentPage += 1
                            
                        }

                    }

            }
            
        

    
    var controls: some View{
        HStack{
            if currentPage != 5{
            Button{
                skip()
            } label: {
                Text("SKIP")
            }
            }
            Spacer()
               PageIndicator(numPages: 6, currentPage: $currentPage)
            Spacer()
            Button{
                next()
            } label: {
                Text("NEXT")
            }

        }
    }
    
    
    
    
    var SplashScreens: [ScreenView] = [ScreenView(image: "my_school_a", title: "My School", detail: "If you are a studnt you can explore School Library, stacks, activitis and notification."),ScreenView(image: "alibrary_prime", title: "Alibrary Prime", detail: "Explore huge book collection magazine, stories & news with just one subscription."), ScreenView(image: "connect", title: "Connection with publisher & Author.", detail: "Explore the gallery of publisher& author and find the issue you need."),ScreenView(image: "my_collection", title: "My Collection", detail: "Categorise your collection in your library. stacks, Bookmark Purchase Annotations."),ScreenView(image: "premium_stories", title: "Premium Stories", detail: "Create premium stories and share your great experience."),ScreenView(image: "our_digital_product", title: "Our Digital Product", detail: "118 categories reach to people Books, magazine,news and stories")]
   
    
    var body: some View {
        GeometryReader{  proxy in
            VStack{
                TabView(selection: $currentPage){
                    ForEach(0..<6){  num in

                        SplashScreens[num]

                    }
                    
                } .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                 .padding()

                Divider()
                    .frame(height:2)
                    .background(Color.black)
                   
//                controls
//                    .padding()
                
                
                
                HStack{
                   
                    
                    if currentPage != 5{
                        
                        Button(action: {
                           
                            withAnimation{
                                currentPage = 6
                            }
                        }, label: {
                            Text("SKIP")
                                .fontWeight(.bold)
                                .kerning(1.2)
                        })
                    }
                    Spacer()
                    Button(action: {
                        //Changing Views....
                        withAnimation{
                            //Checking
                            if currentPage <= totalPages-1{
                                currentPage += 1
                                
                            }
                         
                        }
                    },label: {
                    Text("NEXT")
                    }
                )}
                .padding()
                .overlay(content: {
                    PageIndicator(numPages: totalPages, currentPage: $currentPage)
                })
                
                
                
            }
            
            
            
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
    
}
