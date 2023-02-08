//
//  ShareView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 13/02/23.
//

import SwiftUI

struct ShareView: View {
    @State private var isShareSheetShowing = false
        
    var body: some View {
        Button(action: shareButton) {
            Image(systemName: "square.and.arrow.up")
                .font(.title)
                .foregroundColor(.black)
        }
    }
    func shareButton() {
           
           isShareSheetShowing.toggle()
           
           let url = URL(string: "https://www.alibrary.in/show-book?id=3898")
           let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

       }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
