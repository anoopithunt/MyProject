//
//  CircularProgressView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 01/11/22.
//

import SwiftUI
import Marquee

struct CircularProgressView: View {
    @State private var isLoaderVisible: Bool = false
  
    var body: some View {
        ZStack {

            Circle()
                .stroke(lineWidth: 6.0)
                .foregroundColor(Color.green)
                    .frame(width: 20, height: 20)
                    .padding(10)
            LoaderView(showLoader: isLoaderVisible)

        }  .frame(width: 20, height: 20)
            .padding(10)
            .onAppear {
                isLoaderVisible.toggle()
            }
    }
  
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CircularProgressView().frame(width: 90,height: 92).border(.yellow)
            CircleProgressView().frame(width: 90,height: 82).border(.red)
              LinearProgressView().frame(width: 150,height: 22).border(.pink)
        }
          
    }
}

public struct LoaderView: View {
    var showLoader: Bool = false

    public var body: some View {

            ZStack {
                Circle()
                    .stroke(lineWidth: 6.0)
                    .opacity(0.3)
                    .foregroundColor(Color.green)
                
                Circle()
                    .trim(from: 0.0, to: 0.1)
                    .stroke(.green,style: StrokeStyle(lineWidth: 6.0, lineCap: .round))
                    .rotationEffect(.degrees(showLoader ? 360 : 0))
                    .animation(Animation.linear(duration: showLoader ? 0.8 : 1).repeatForever(autoreverses: false), value: showLoader)
            }
    }

    public init(showLoader: Bool) {
        self.showLoader = showLoader
    }
}


struct CircleProgressView: View {
    @State private var isLoaderVisible: Bool = false

    var body: some View {

        CircleLoaderView(showLoader: isLoaderVisible).frame(width: 40, height: 40)

            .onAppear {
                isLoaderVisible.toggle()
            }
        
        
    }
  
}


public struct CircleLoaderView: View {

    var showLoader: Bool = false

    public var body: some View {
        GeometryReader { reader in
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.8)
                    .stroke(.black,style: StrokeStyle(lineWidth: 5.0, lineCap: .round))
                    .rotationEffect(.degrees(showLoader ? 360 : 0))
                    .animation(Animation.linear(duration: showLoader ? 0.6 : 0).repeatForever(autoreverses: false), value: showLoader)
            }
        }
    }

    public init(showLoader: Bool) {
        self.showLoader = showLoader
    }
}



public struct LinearProgressView: View {

    public var body: some View {

        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("green").opacity(0.3))
                Marquee{
                    Rectangle()
                        .foregroundColor(Color("green").opacity(0.8))
                        .frame(width: 32 ,height: 3)
                }.marqueeDirection(.left2right).marqueeDuration(0.7)
            }.frame(width: 122, height: 3)  
        }.frame(width: 122, height: 3)
    }

}





struct ProgressBar: View {

      @State private var isLoading:Bool = false
      
      var body: some View {
          ZStack {
            
              RoundedRectangle(cornerRadius: 3)
                  .stroke(Color("green").opacity(0.3), lineWidth: 3)
                  .frame(width: 250, height: 3)
              
              RoundedRectangle(cornerRadius: 3)
                  .stroke(Color("green"), lineWidth: 3)
                  .frame(width: 55, height: 3)
                  .offset(x: (isLoading ? 110 : -110), y: 0)
                  .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
          }.onAppear {
              DispatchQueue.main.async {
                              self.isLoading = true
                          }
          }
      }
      

   
}
