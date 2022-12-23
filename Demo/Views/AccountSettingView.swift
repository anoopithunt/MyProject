//
//  AccountSettingView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 03/12/22.
//

import SwiftUI

struct AccountSettingView: View{
    var body: some View{
        VStack(spacing:0){
            HStack(spacing:35){
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrow.backward").foregroundColor(.white).font(.system(size: 22, weight: .heavy)).padding(.leading)
                })
                
             
                Text("**Account Settings**").foregroundColor(.white).font(.system(size: 22))
                
                Spacer()
            }.frame(height: 85).background(Color("orange"))
            MyPagerView()
        }
    }
}


struct AccountSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingView()
//        ActivityTabView()
      
    }
}




struct ActivityTabView: View {
    
    @State var tabIndex = 0
    
    var body: some View {
        VStack{
            CustomTopTabBar(tabIndex: $tabIndex)
            if tabIndex == 0 {

                ActivitiesView()
            }
            else {
                NotificationTestView()
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
//        .padding(.horizontal, 12)
    }
}




struct CustomTopTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 10) {
            TabBarButton(text: "Activities", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            TabBarButton(text: "Test", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            Spacer()
        }.padding(.leading)
        

        .frame(width: UIScreen.main.bounds.width, height: 80).background(Color("orange"))
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text).foregroundColor(.white)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 22))
//            .padding(.bottom,10)
//            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black)
    }
}





//
//struct EdgeBorder1: Shape {
//
//    var width: CGFloat
//    var edges: [Edge]
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        for edge in edges {
//            var x: CGFloat {
//                switch edge {
//                case .top, .bottom, .leading: return rect.minX
//                case .trailing: return rect.maxX - width
//                }
//            }
//
//            var y: CGFloat {
//                switch edge {
//                case .top, .leading, .trailing: return rect.minY
//                case .bottom: return rect.maxY - width
//                }
//            }
//
//            var w: CGFloat {
//                switch edge {
//                case .top, .bottom: return rect.width
//                case .leading, .trailing: return self.width
//                }
//            }
//
//            var h: CGFloat {
//                switch edge {
//                case .top, .bottom: return self.width
//                case .leading, .trailing: return rect.height
//                }
//            }
//            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
//        }
//        return path
//    }
//}

//extension View {
//    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
//        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
//    }
//}
