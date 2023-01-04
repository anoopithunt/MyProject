//
//  RegistrationForm.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/06/22.
//

import SwiftUI
struct CardData{
    let id: Int
    let title: String
}

struct RegistrationForm: View {
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var re_password = ""
    @State var referral = ""
    var body: some View {
        
        
        ScrollView(.vertical){
            VStack{
                //paste the Poster  image
                HStack(alignment: .center){
                Image("logo_horizantal")
                
                    .resizable()
                    
                    .aspectRatio(contentMode: .fill)

                    .background(Color.white)
                    .opacity(1.4)
                    

                }
                
                .aspectRatio(contentMode: .fit)
                Text("Sign Up")
                    .font(.body)
                    .fontWeight(.heavy)
               
                    .tracking(2)
                    .foregroundColor(Color.black)
//                        .padding()
               
                    
                
                VStack{
                    
                        
                    
                    
                
                    //Full Name Section
                    
                    
                    HStack {
                        Image(systemName: "person.crop.square.fill")
                            .foregroundColor(Color.black)
                            .padding(.leading, 25.0)
                        
                        
                        
                        TextField("Full Name",text: $name)
                        
                            .foregroundColor(Color.black)
                            .padding(.horizontal, 16.0)
                        
                        
                        //Increasing Font size and changing text color
                            .font(.custom("AmericanTypewriter", fixedSize: 22))
                            .accessibilityLabel("Label")
                            .accessibilityValue("Email Id And Password")
                        
                        
                    }.padding(.top)
                    
                    Rectangle()
                        .padding(.horizontal, 21.0)
                        .frame(height:1)
                        .foregroundColor(.gray)
                        
                    //Full name Section End
                    
                    
                    Divider()
                        
                    
                    // Email id/ Mobile Number Section start
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color.gray)
                            .padding(.leading, 25.0)
                            
                            
                
                        TextField("Email/Mobile Number",text: $email)
                        
                            .foregroundColor(Color.gray)
                            .padding(.horizontal, 21.0)

                   
                        //Increasing Font size and changing text color
                            .font(.custom("AmericanTypewriter", fixedSize: 22))
                        
            
                       
                    }
                    .padding(.top)
                    Rectangle()
                        .frame(height:1)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 21.0)
                    // Email id/ Mobile Number Section End

                    
                    // Password Section Start
                    
                    
                    
            
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color.gray)
                            .padding(.leading, 25.0)
                            
                            
                      
                        secureTextField( text: $password)
                            .foregroundColor(Color.black)
                           
                            .font(.custom("AmericanTypewriter", fixedSize: 22))
                            .padding(.horizontal, 25.0)
                            
                            
                    }.padding(.top)
                    
                     Rectangle()
                        .frame(height:1)
                        .foregroundColor(.gray)
                        .padding(.horizontal,16)
                    
                    //password Section End
                    
    //password Re enter section Start
                    
                    
                    
                    HStack (alignment: .center, spacing: 12){
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color.gray)
                            .padding(.leading, 25)
                          
                            
                      
                        secureTextField( text: $re_password)
                            .foregroundColor(Color.black)
                            .accessibilityLabel("Re Enter Password")
                            .font(.custom("AmericanTypewriter", fixedSize: 22))
                            .padding(.horizontal, 23.0)
                            
                            
                            
                    }.padding(.top)
                    
                     Rectangle()
                        .frame(height:1)
                        .foregroundColor(.gray)
                        .padding(.horizontal,16)
                    
                    
                    
                    //Password re enter Section End
    
        
             
                }
                //.background(C
                .imageScale(.large)
                .frame(width:UIScreen.main.bounds.width-44, height:UIScreen.main.bounds.height*0.5)
                .scaledToFit()
              
              ///  .padding()
               
                
                
                Text("Referral Code?")
                    .foregroundColor(Color.orange)
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment: .trailing)
            
                    .padding()
                
                
                //Referral Code Starrt
                HStack {
                    Image(systemName: "pencil")
                        .foregroundColor(Color.gray)
                        .padding(.leading, 34.0)
                        .imageScale(.large)
                        
                        
            
                    TextField("Referral Code ",text: $referral)
                        
                    
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 25.0)
                    
                    
                    //Increasing Font size and changing text color
                        .font(.custom("AmericanTypewriter", fixedSize: 20))
                        .accessibilityLabel("Label")
                    
        
                   
                }
                
                Rectangle()
                    .padding(.horizontal, 33.0)
                    .frame(height:1)
                    .foregroundColor(.gray)
                    
                
                
            }
        }
                           .foregroundColor(Color.blue)
                           .background(Image("u")
                            .resizable()
                            .ignoresSafeArea()
                            )
    }
    
    
}

struct RegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationForm()
    }
}
