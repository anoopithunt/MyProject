//
//  SearchContentView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 20/03/23.
//

import SwiftUI

struct SearchContentView: View {
    @State var searchBook : String = ""
    @State var searchbtn : Bool = true
    @Binding var closebtn : Bool
    var body: some View {
        ZStack{
            Color.black.opacity(0.7).ignoresSafeArea()
            VStack{
                Spacer()
                
                SuperTextField(placeholder: Text("Type to Search Here")
                    .foregroundColor(.orange).font(.system(size: 22, weight: .bold)),
                            text: $searchBook)
                .underlineTextField()
                .foregroundColor(.white)
                .padding(.horizontal)
                
            Button(action: {
                
            }, label: {
                Text("Search")
                    .foregroundColor(.white)
                    .padding(8)
                    .padding(.horizontal)
                    .background(Color.gray)
                    .cornerRadius(12)
            })
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        self.closebtn = false
                    }, label: {
                        Image("close_")
                            .resizable()
                            .frame(width: 45, height: 45)
                        
                    })
                    
                }.padding()
            }
                .padding()
        }//.allowsHitTesting(false)
    }
}

struct SearchContentView_Previews: PreviewProvider {
    static var previews: some View {
        PDFKitViews(id: 17)
    }
}



struct SuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
        }
    }
    
}


struct BlinkingImage: View {
    @State private var isBlinking = false
        
        var body: some View {
            Image("close_")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .white, location: 0.4),
                            .init(color: .clear, location: 1)
                        ]),
                        startPoint: .leading,
                        endPoint: .center
                    ).cornerRadius(22)
                        .opacity(isBlinking ? 0.5 : 0)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true))
                    //.mask(Image("like"))
                )
                .onAppear {
                    isBlinking = true
                }
        }
}
