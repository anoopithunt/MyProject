//
//  HomePage.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 04/07/22.
//

import SwiftUI

struct HomePage: View {
    
    
    var body: some View {
        
//        VStack{
//            CustomNavBarView()
    
        ZStack {
            Image("u").resizable().ignoresSafeArea()
//            NavigationView{
                VStack {
                    //
                    ScrollView{
                        VStack{
                            
                            MainBannerView().frame( height: 220)
                            
                           
                            CorouserView()
                                .frame( height: 300)
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 580)
                        .background(Color.black.opacity(0.8))
                        
                        //COROUSEL Section END
//                        Spacer()
                        Group {
                            Text("Online\nLibrary")
                                .font(.system(size:58))
                                .tracking(2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentColor"))
                                .multilineTextAlignment(.leading)
                                .padding(2)
                                .position(x: 110, y: 62)
                            
                            
                            
                            //Spacer()
                            Text("If you are a book lover then we provide you these digital features which will help you to find your favorite content and provide you reading facility. You can read a lot of magazine newspapers, novels, book articles and other interesting stories with the convenience of our online library .")
                                .foregroundColor(Color("AccentColor"))
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            Image("onlineLib")
                                .resizable()
                                .frame(width: 333, height: 255, alignment: .center)
                            
                            
                            
                            //                    AsyncImage(url: URL(string: "https://storage.googleapis.com/pdffilesalib/images/onlineLib.png")){ image in
                            //                        image
                            //                            .resizable()
                            //                            .frame(width: 333, height: 255, alignment: .center)
                            //                    }
                            
                            
                            
                            ButtonView(btnName: "Get Started")
                            
                            
                            // second section
                            
                            Text("FREE STARTUP \n MAGAZINE BUSINESS")
                                .font(.system(size:24))
                                .fontWeight(.bold)
                                .underline()
                            
                            
                                .padding(.leading,-97)
                                .foregroundColor(Color("AccentColor"))
                            // .multilineTextAlignment(.leading,12)
                            
                                .padding()
                            Text("Free launching Give your magazine business a new startup. Please join us immediately and allow your content to appear on alibrary.in so that we can better reach this digital edition of you. We appreciate your criticisms.")
                                .foregroundColor(Color("AccentColor"))
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            Image("freestartmag1")
                                .resizable()
                                .frame(width: 333, height: 255, alignment: .center)
                            
                            
                            //End second Section
                            
                            //start third section
                            
                            Image("freestartmagcircle")
                                .resizable()
                                .frame(width: 333, height: 255, alignment: .center)
                            
                            
                            ButtonView(btnName: "Now Start")
                                .padding()
                            
                        }
                        //End Third Section
                        MagazineBannerView()
                        
                        HStack{
                            Text("**Prime Books**")
                            Spacer()
                            
                            NavigationLink(destination: SearchBooksCollectionView().navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)){
                                    Image(systemName: "arrow.right").font(.system(size: 18, weight: .heavy)).foregroundColor(Color("AccentColor"))
                                }
                            
                        }
                        .foregroundColor(Color("AccentColor"))
                        .padding()
                        
                        //                        CorouserView()
                        
                        PrimeBooksView()
                            .padding(.leading)
                        Group{
                            Text("Advertise\nPRESS")
                                .font(.system(size:25))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("AccentColor"))
                                .position(x: 72, y: 32)
                            Text("PUBLICATIONN MAGZINE")
                                .font(.system(size:24))
                                .fontWeight(.bold)
                                .underline()
                                .foregroundColor(Color("AccentColor"))
                                .position(x: 163, y: 12)
                            Image("advertisement")
                                .resizable()
                                .frame(width: 333, height: 255, alignment: .center)
                            Text("If you want to recive your fresh publication ads through our front banner or slider,then follow the instruction given. Make your business grough faster and successed in it. For which there is no need to upload a separate content page, after through analysis by the administrator , the advertisement will be automaticaly ensured.")
                                .foregroundColor(Color("AccentColor"))
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding()
                            Text("School Admin")
                                .font(.system(size:28))
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(Color("AccentColor"))
                                .position(x: 92, y: 32)
                            Image("CombindSchoolad")
                                .resizable()
                                .frame(width: 333, height: 255, alignment: .center)
                            
                            Text("If you want to recive your fresh publication ads through our front banner or slider,then follow the instruction given. Make your business grough faster and successed in it. For which there is no need to upload a separate content page, after through analysis by the administrator , the advertisement will be automaticaly ensured.")
                                .foregroundColor(Color("AccentColor"))
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            Image("AdminControl")
                                .resizable()
                                .frame(width: 333, height: 255, alignment: .center)
                            Text("Admin Control")
                                .font(.system(size:28))
                                .fontWeight(.semibold)
                                .underline()
                                .padding(.leading)
                                .foregroundColor(Color("AccentColor"))
                                .position(x: 97, y: 32)
                            
                            
                            Text("Now gain full control over your admin dashboard, you can activate or block your users' IDs at any time and sell books purchased by publishers to users themselves, whose functions will only be digital. This process is completely stress free and you have complete control over your things. Your things cannot be seen through any unauthorized person and upon entering any particular angel action, permission of Honor is mandatory.")
                                .foregroundColor(Color("AccentColor"))
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            
                        }
                        
                        Group{
                            Text("If you want to join us, then you go into detail about our online library facilities.")
                                .font(.system(size:14))
                            ButtonView(btnName: "Get Demo")
                            Text("Students")
                                .font(.system(size:28))
                                .fontWeight(.semibold)
                                .underline()
                                .padding(.leading)
                                .foregroundColor(Color("AccentColor"))
                                .position(x: 67, y: 32)
                            Image("student")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/1.7, height: 280, alignment: .center)
                                .padding()
                            
                            Text("Now you can visit more than one library at once and you can make your own stack which Makes your experience even better.")
                                .foregroundColor(Color("AccentColor"))
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding()
                            //                            CorouserView()
                            PublisherBannersView()
                            
                            HStack{
                                Text("Popular Books")
                                Spacer()
                                NavigationLink(destination: SearchBooksCollectionView().navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)){
                                    Image(systemName: "arrow.right").font(.system(size: 18, weight: .heavy)).foregroundColor(Color("AccentColor"))
                                }
                            }
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size:22))
                            .padding()
                            
                            PopularBooksView().frame(height:250)
                            
                            
                            HStack{
                                Text("Fresh Publications")
                                Spacer()
                                NavigationLink(destination: SearchBooksCollectionView().navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)){
                                    Image(systemName: "arrow.right").font(.system(size: 18, weight: .heavy)).foregroundColor(Color("AccentColor"))
                                }
                                
                            }
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size:22))
                            .padding()
                            
                            FreshPublicationsView().frame(height:250)
                        }
                        
                        
                        HStack{
                            Text("**Publisher List**")
                            Spacer()
                            NavigationLink(destination: SearchBooksCollectionView().navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)){
                                Image(systemName: "arrow.right").font(.system(size: 18, weight: .heavy)).foregroundColor(Color("AccentColor"))
                            }
                            
                        }
                        .foregroundColor(Color("AccentColor"))
                        .font(.system(size:22))
                        .padding()
                        // Here We Add the PublisherList View from API Calling
                        //                           PopularBooksView()
                        HomePublisher()
                            .frame(height:220)
                        VStack{
                            Text("Get Connected with us ")
                                .foregroundColor(Color("AccentColor"))
                                .font(.system(size:25))
                                .bold()
                                .padding()
                            
                            
                            HStack(alignment: .center, spacing: 12){
                                
                                Image("what_up_blue")
                                
                                Image("fb_blue")
                                Image("insta_blue")
                                Image("twt_blue")
                                Image("you_tube_blue")
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    //            }
                    Spacer()
                }
                
//            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        
                HomePage()
    
                
            }
}


