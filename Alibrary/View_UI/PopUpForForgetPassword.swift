//
//  PopUpForForgetPassword.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 01/07/22.
//

import SwiftUI

struct PopUpForForgetPassword: View {
    @State  var showingModal: Bool = false
    @State var c_email = ""
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {
              
                
                Button(action: {
                    self.showingModal = true
                }) {
                    Text("Forgot Password ?")
                    
                }
                
                
                    
            }
            
            
            // The Custom Popup is on top of the screen
            if $showingModal.wrappedValue {
                // But it will not show unless this variable is true
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.vertical)
//                    // This VStack is the popup
                    VStack(spacing: 20) {

                   
                        
                        
                        HStack{
                        Image("ic_launcher_foreground")
                                .resizable()
                                .frame(width: 77, height: 80, alignment: .center)
                        Text("Forgot Password?")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color.white)
                        }
                        .background(Color.orange)
                        Spacer()
                        TextField("Register", text: $c_email)

                            .foregroundColor(Color.purple)
                            .padding(.horizontal, 20.0)


                        //Increasing Font size and changing text color
                            .font(.caption)
                            .accessibilityLabel("Label")
                            .padding(.bottom)
                        Rectangle()
                            .frame(height:1)
                            .foregroundColor(.gray)
                            .padding(.horizontal,25)
                        
                        Spacer()
                        HStack(alignment: .center){
                        Button(action: {
                            self.showingModal = false
                        }) {
                            Text("Cancel")
                                .font(.headline)
                                .frame(width: 100,height: 44)
                                .background(Color(hue: 0.714, saturation: 0.8, brightness: 0.94))
                                .cornerRadius(25)


                        }.padding()

                        Button(action: {
                            self.showingModal = false
                        }) {
                            Text("Send")
                                .font(.headline)
                                .frame(width: 100,height: 44)
                                .background(Color(hue: 0.714, saturation: 0.8, brightness: 0.94))
                                .cornerRadius(25)


                        }.padding()
                    }
                    }
                    .frame(width: 350, height: 360)
                    .background(Color.white)
                    .foregroundColor(.white)
                    .cornerRadius(5).shadow(radius: 20)
                    }
                }
            }
        }
    }
   


struct PopUpForForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PopUpForForgetPassword()
            Spacer()
        }
    }
}
