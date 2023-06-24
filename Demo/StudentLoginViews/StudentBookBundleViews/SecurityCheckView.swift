//
//  SecurityCheckView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 28/06/23.
//

import SwiftUI

struct  SecurityCheckView: View {
    @Binding var isShowing: Bool
    var body: some View {
        ZStack{
            Color(.black).opacity(0.5).ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
                    Image("ic_launcher").resizable().frame(width: 65, height: 65).cornerRadius(12)
                    Text("DRM Security Alert").font(.system(size: 26, weight: .regular)).foregroundColor(.white)
                    Spacer()
                    Image(systemName: "lock.fill").font(.system(size: 26, weight: .bold)).foregroundColor(.white)
                    
                }
                .padding(8)
                .background(Color.orange)
                
                Text("You cannot read this book from this device! Please use the device from where this book was purchased ! you can unlock 2 devices other than one from which you have purchased this book for free. After that you will have to pay 30% of the book price. The moment you unlock this device, you cannot read this book in any of the old device. Do you want to enable this device ?")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.horizontal)
                
                HStack{
                    Spacer()
                    VStack{
                        ZStack{
                            Image("dvice").resizable()
                                .frame(width: 45, height: 90)

                            Text("1").font(.system(size: 24, weight: .bold)).foregroundColor(.gray)
                        }
                        
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.red).font(.system(size: 32, weight: .bold))
                    }
                    VStack{
                        ZStack{
                            Image("dvice").resizable().frame(width: 45, height: 90)

                            Text("2").font(.system(size: 24, weight: .bold)).foregroundColor(.gray)
                        }
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.teal).font(.system(size: 32, weight: .bold))
                    }
                    VStack{
                        ZStack{
                        Image("dvice").resizable().frame(width: 45, height: 90)

                            Text("3").font(.system(size: 24, weight: .bold)).foregroundColor(.gray)
                    }
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.teal).font(.system(size: 32, weight: .bold))
                    }
                  
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                        
                    }, label: {
                        Text("No").foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.horizontal,22).padding(.vertical, 8)
                            .background(Color("default_")).cornerRadius(29)
                    })
                    Button(action: {
                        
                    }, label: {
                        Text("Yes").foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.horizontal,22).padding(.vertical, 8)
                            .background(Color("default_")).cornerRadius(28)
                    })
                    
                }.padding(8)
                
            }
            .frame(width: UIScreen.main.bounds.width*0.91)
                .background(Color.white)
                .cornerRadius(8)
        }
        
    }
}

struct SecurityCheckView_Previews: PreviewProvider {
    static var previews: some View {
        StudentBookBundleDetailViews(bundle_id: 556)
         
    }
}
