//
//  BookQRCodeView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 05/04/23.
//

import SwiftUI

struct BookQRCodeView: View {
    @State var bookTitle: String = "Anoop Mishra Kamoli Veer Bhan Pur Kunda"
    @State var bookUrl: String = "https://www.alibrary.in/show-book?id=3898"
    @State private var isShareSheetShowing = false
    @Binding var open: Bool
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.2).ignoresSafeArea().onTapGesture {
                open = false
            }
            VStack(alignment: .center, spacing: 15){

                HStack{
                    
                    Button(action: {
                        shareButton()
                    }, label: {
                        Image(systemName: "bonjour")
                            .foregroundColor(.black)
                            .font(.system(size: 35))
                        
                        
                    })
                    
                    
                    Spacer()
                    
                }.padding()

                QRCodeView(text: bookUrl).frame(width: 245, height: 245)
                
                Text(bookTitle).foregroundColor(.black)
                    HStack(spacing: 12){
                        Spacer()
                       
                        Button(action: {
//                            open = false
                        }, label: {
                            Text("Download")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: UIScreen.main.bounds.width/2)
                                .padding(.vertical,20)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .cornerRadius(24)
                                
                                
                           
                        })
                        Spacer()
                    }.padding()
                    
                
            }.background(.white).frame(width: UIScreen.main.bounds.width-25)
                .cornerRadius(12).shadow(radius: 3)
              
        }
        
    }
    func shareButton() {
           
           isShareSheetShowing.toggle()
           
           let url = URL(string: "https://www.alibrary.in/show-book?id=3898")
//        let url = URL(string: "\(book)")
           let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

       }
    
}


struct BookQRCodeViewEx: View {
    @State var open: Bool = false
    var body: some View {
        ZStack{
            Button(action: {
                open = true
            }, label: {
                Text("Open QRCode for Book").foregroundColor(.black)
            })
            if open{
                BookQRCodeView( open: $open)
            }
        }
    }
}

struct BookQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        BookQRCodeViewEx()
    }
}






