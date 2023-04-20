//
//  PagerTabStripView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 11/04/23.
//

import SwiftUI
import WebKit

struct PagerTabStripView1: View {
    @State private var selectedTab = 0
    @State var show: Bool = true
    let views: [AnyView] = [AnyView(LoginPageView()), AnyView(SubscribeView()), AnyView(Stacks())]
    let tabItems = ["First", "Second", "Third"]
       var body: some View {
           VStack(spacing:0) {
               Spacer()
               HStack(spacing: 0) {
                   Button(action: { self.selectedTab = 0 }) {
                       Text("First")
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.orange)
                   }
                   .overlay(
                       selectedTab == 0 ?
                       Rectangle()
                           .frame(height: 3)
                           .foregroundColor(.black)
                           .animation(.linear(duration: 1))
                           .padding(.top, 52) : nil
                   )
                   Button(action: { self.selectedTab = 1 }) {
                       Text("Second")
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.orange)
                   }
                   .overlay(
                       selectedTab == 1 ?
                       Rectangle()
                           .frame(height: 3)
                           .foregroundColor(.black)
                           .animation(.linear(duration: 1))
                           .padding(.top, 52) : nil
                   )
                   Button(action: { self.selectedTab = 2 }) {
                       Text("Third")
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.orange)
                   }
                   .overlay(
                       selectedTab == 2 ?
                       Rectangle()
                           .frame(height: 3)
                           .foregroundColor(.black)
                           .animation(.linear(duration: 1))
                           .padding(.top, 52) : nil
                   )
               }.foregroundColor(.white).font(.system(size: 22, weight: .bold))



               // TabView with content
               TabView(selection: $selectedTab) {

                       LoginPageView()


                       .tag(0)
                   StackBookListView(id: 891, name: "hello feh ")
                       .tag(1)
                   Stacks()
                       .tag(2)
               }
               .tabViewStyle(.page(indexDisplayMode: .never))
           }
          
           }
       }





struct PagerTabStripView_Previews: PreviewProvider {
    static var previews: some View {
        PagerTabStripView1()
       
    }
}

struct HTMLView: UIViewRepresentable {
    let htmlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}


struct PagerTabStripView<Content: View>: View {
    let views: [Content]
    let tabItemNames: [String]
    @State private var selectedTab = 0
    
    init(views: [Content], tabItemNames: [String]) {
        self.views = views
        self.tabItemNames = tabItemNames
    }
    
    var body: some View {
        VStack(spacing:0) {

            HStack(spacing: 0) {
                ForEach(0..<tabItemNames.count) { index in
                    Button(action: { self.selectedTab = index }) {
                        Text(tabItemNames[index])
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                    }
                    .overlay(
                        selectedTab == index ?
                            Rectangle()
                                .frame(height: 4)
                                .foregroundColor(.black)
                                .animation(.linear(duration: 1))
                                .padding(.top, 52) : nil
                    )
                }
            }.foregroundColor(.white).font(.system(size: 22, weight: .bold))
            
            TabView(selection: $selectedTab) {
                ForEach(0..<views.count, id: \.self) { index in
                    views[index].tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}



struct CircularProgressBar: View {
    @State private var progress: Double = 0.0
    
    var progressColor: Color = .green
    var backgroundColor: Color = .gray.opacity(0.7)
    var lineWidth: CGFloat = 7
    var rotationDuration: Double = 2.0
    
    private var progressAngle: Double {
        min(progress, 1.0) * 360.0
    }
    
    private var rotationAngle: Angle {
        .degrees(progressAngle - 90)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.bar, lineWidth: 2)
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)
            Circle()
                .trim(from: 0.0, to: CGFloat(progressAngle / 360.0))
                .stroke(progressColor, lineWidth: lineWidth)
                .rotationEffect(rotationAngle)
                .animation(Animation.linear(duration: rotationDuration).repeatForever(autoreverses: false), value: progressAngle)
                .onAppear {
                    withAnimation(.linear(duration: 1.5)) {
                        self.progress = 1.0
                    }
                }
                .onAnimationCompleted(for: progress) {
                    withAnimation(.linear(duration: 1.9)) {
                        self.progress = 0.2
                        self.progress = 1.0
                    }
                }
        }
    }
}



struct OnAnimationCompletedModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    var value: Value
    var callback: () -> Void

    init(_ value: Value, callback: @escaping () -> Void) {
        self.value = value
        self.callback = callback
    }

    var animatableData: Value {
        get { value }
        set {
            value = newValue
            if value == .zero {
                
                    callback()
           
            }
        }
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func onAnimationCompleted<Value>(for value: Value, perform action: @escaping () -> Void) -> some View where Value: VectorArithmetic {
        modifier(OnAnimationCompletedModifier(value, callback: action))
    }
}




struct CustomAlert: View {
    @Binding var isShowing: Bool
    let message: String
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.9)
            
            VStack {
                HStack(spacing:24){
                    Image("soft").resizable().frame(width: 65,height: 65).cornerRadius(35)
                   
                    Text("Alibrary High Result")
                        .font(.headline)
                        .padding(.bottom, 10)
                    Spacer()
                }.frame(maxWidth: .infinity).background(Color.orange)
                Text(message)
                    .padding(.bottom, 30)
                
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    Text("Dismiss")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(5)
                })
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
