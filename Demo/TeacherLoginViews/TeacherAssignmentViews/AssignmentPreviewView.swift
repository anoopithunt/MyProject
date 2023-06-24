//
//  AssignmentPreviewView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 02/11/23.
//

import SwiftUI

struct AssignmentPreviewView: View {
    @State var title: String?
    @State var date: String
    @State var description: String
    @State var isZoom: Bool = true
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack{
            
//            Image("u")
//            .resizable()
//            .ignoresSafeArea()
            VStack(alignment: .leading,spacing:6){
                if isZoom{
                    HStack(spacing: 12){
                        Button(action: {
                            dismiss()
                        }, label: {
                            
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 22, weight: .bold))
                        })
                        Text(self.title ?? "")
                            .font(.system(size: 28, weight: .bold))
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .frame(height: 75)
                    .background(Color("orange"))
                }
                
                VStack(alignment: .leading){
                    
                    HStack(spacing:16){
                        
                        Text("Homework \nDate  \(self.date)")
                            .font(.system(size: 22, weight: .regular))
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            
                            Image("downlod_icon")
                                .resizable()
                                .frame(width: 45, height: 45)
                        })
                        
                        Button(action: {
                            self.isZoom.toggle()
                        }, label: {
                            
                            Image(isZoom ? "zoomin" : "zoomout")
                                .resizable()
                                .frame(width: 45, height: 45)
                        })
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading,spacing: 12){
                        
                        Text("Homework description")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color("default_"))
                        
                        Text(self.description)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                }.padding(6)
                
            }
            
        }
        
    }
}

struct AssignmentPreviewView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AssignmentPreviewView(title: "Physics", date: "14/11/2023", description: "Memory man")
    }
    
}

