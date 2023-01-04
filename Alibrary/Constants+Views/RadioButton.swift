//
//  RadioButton.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import Foundation
import SwiftUI


struct RadioButton: View {
    @Binding var selected: Int
    let index: Int
    let label: String

    var body: some View {
        HStack {
            Text(label)
            
            Image(systemName: selected == index ? "largecircle.fill.circle" : "circle")
                .foregroundColor(.black)
            Spacer()
        }
        .onTapGesture {
            self.selected = self.index
        }
    }
}

struct RadioButtonGroup: View {
    @State private var selected = 0
    @State  var labels = ["Public", "Private"]
    @State var pressed: Bool = false
    
    init( labels: [String]  = ["Public", "Private"]) {

        self.labels = labels

    }
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 2) {
                ForEach(0..<labels.count) { index in
                    RadioButton(selected: self.$selected, index: index, label: self.labels[index])
                }
            }.padding()
            if selected == 1 {
                HStack{
                    Button(action: {
                        pressed.toggle()
                    }, label: {
                        Image(systemName: !pressed ? "square" : "checkmark.square.fill").font(.system(size: 28)).foregroundColor(.black)
                        
                    })
                    Text("I Agree").bold()
                }.padding(.leading,4)
                Text("Views and their content in SwiftUI depend on the value of state properties quite often. Images views are no exception, so we’ll introduce a new state property here that we’ll use in order to determine the image to display.").padding(.leading, 35)

            }
        }
    }
}
