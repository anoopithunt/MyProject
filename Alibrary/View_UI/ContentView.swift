//
//  ContentView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 28/06/22.
//

import SwiftUI

struct ContentView: View {
   @AppStorage("currentPage") var currentPage = 0
    @State private var isActiveSplashScreen = false
    var body: some View {

    if currentPage >= totalPages {
                            if isActiveSplashScreen {
                                
                                MainHomePageView().ignoresSafeArea()
                            }
                else{
                  
                        VStack {
                            WelcomeView()
                            Spacer()
                        }.onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                                    withAnimation{
                                        self.isActiveSplashScreen = true
                                    }
                                
                            }
                    }
                }
            }
            else{
                
                WalkthroughScreen()
                
                
            }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

            ContentView()

            
    }
}






// splash Screen design






//Walkthrough Screen....
struct WalkthroughScreen: View{
    
    @AppStorage("currentPage") var currentPage = 0
    
    var SplashScreens: [ScreenView] = [ScreenView(image: "my_school_a", title: "My School", detail: "If you are a studnt you can explore School Library, stacks, activitis and notification."),ScreenView(image: "alibrary_prime", title: "Alibrary Prime", detail: "Explore huge book collection magazine, stories & news with just one subscription."), ScreenView(image: "connect", title: "Connection with publisher & Author.", detail: "Explore the gallery of publisher& author and find the issue you need."),ScreenView(image: "my_collection", title: "My Collection", detail: "Categorise your collection in your library. stacks, Bookmark Purchase Annotations."),ScreenView(image: "premium_stories", title: "Premium Stories", detail: "Create premium stories and share your great experience."),ScreenView(image: "our_digital_product", title: "Our Digital Product", detail: "118 categories reach to people Books, magazine,news and stories")]
    
   
    
    var body: some View{
        
       
        GeometryReader{  proxy in

            VStack{
                TabView(selection: $currentPage){

            
                    //Changing Betweeen Views......
            ForEach(0..<6){ num in
                SplashScreens[num]

            }

    }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))


           
                
                
                Rectangle()
                    .frame( height: 1)
                    .padding(.top)
                    Spacer()
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
//
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



struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
//    var bgColor: Color
   private let dotAppearance =  UIPageControl.appearance()
    
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
          
            ZStack(alignment: .leading){
            Image(image)
                .resizable()
                .ignoresSafeArea()
 
                .frame(width: UIScreen.main.bounds.width)
               


        VStack(alignment: .center, spacing: 6){
           
            Spacer()
                .frame(height: 402)
            
            
            Text(title)
                .font(.title)
                
                .fontWeight(.heavy)
//                .padding(.bottom)
                .multilineTextAlignment(.center)
                .padding(.horizontal,43)
                
//                Spacer()
            Text(detail)
                .font(.custom("Regular", size: 17))
                .fontWeight(.thin)
                .bold()
               .multilineTextAlignment(.center)
               .padding(.horizontal,65)
               .padding()
//                Spacer()

//            Spacer(minLength: 50)
        }
        }
        
            .background(Color.white.cornerRadius(10).ignoresSafeArea())
        }
    }
}
// Total Pages
var totalPages = 6

