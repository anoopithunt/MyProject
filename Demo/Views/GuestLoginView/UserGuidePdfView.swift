//
//  UserGuidePdfView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 14/04/23.
//

import SwiftUI

struct UserGuidePdfView: View {
    @State var title: String = "UserGuidePdfView"
    @State var pdfurl: String = "https://alibrary.in/public/userguide/1680129442.pdf"
    
    
    var body: some View {
        
            VStack{
                NavHeaderClosure(title: title){
                    ZStack{
                        Image("u").resizable().ignoresSafeArea()
                    VStack{
                        Spacer()
                        PDFViewWrapper(url: (URL(string: pdfurl))!, password: "").frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/1.2)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct UserGuidePdfView_Previews: PreviewProvider {
    static var previews: some View {
        UserGuidePdfView()
    }
}
