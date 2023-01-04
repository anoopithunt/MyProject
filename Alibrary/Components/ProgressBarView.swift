//
//  ProgressBarView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 21/07/22.
//

import SwiftUI

struct ProgressBarView: View {
   
    @State private var isLoading = false
 
    var body: some View {
        ZStack {

 
  
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color("Color-2").opacity(0.6), lineWidth: 3)
                .frame(width: 65, height: 3)
                .offset(x: isLoading ? 110 : -110, y: 0)
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
        }
        
        .onAppear() {
            self.isLoading = true
        }
        
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
