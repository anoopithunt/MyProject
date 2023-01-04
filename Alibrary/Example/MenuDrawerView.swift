//
//  MenuDrawerView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 25/07/22.
//

import SwiftUI
struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let imageName: String
    let handler: () -> Void = {
        print("Tapped Item")
    }
}



struct MenuContents: View {

    let items: [MenuItem] = [
        MenuItem(text: "Home", imageName: "house"),
        MenuItem(text: "Profile", imageName: "person.circle"),
        MenuItem(text: "Activity", imageName: "bell"),
        MenuItem(text: "Flights", imageName: "airplane"),
        MenuItem(text: "settings", imageName: "gear"),
        MenuItem(text: "Share", imageName: "square.and.arrow.up"),
        MenuItem(text: "Donate Pdf", imageName: "pdf_gray"),
    
    ]
    var body: some View{
        ZStack {
            Color(UIColor(red: 43/255.0, green: 40/255.0, blue: 74/255.0, alpha: 1))
            
            VStack(alignment: .leading, spacing: 0){
                ForEach(items) { item in
                    HStack{
                        Image(systemName: item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32, alignment: .center)
                        
                        Text(item.text)
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 22))
                            .multilineTextAlignment(.leading)
                        Spacer()
                        
                    }
                    .onTapGesture {
                        
                    }
                    .padding()
                    Divider()
                    
                }
                Spacer()
            }
            .padding(.top, 25)
        }
    }
    
}



struct MenuDrawerView: View {
    @State var menuOpened = false
    var body: some View {
        ZStack {
            if !menuOpened {
                Button(action: {
                    self.menuOpened.toggle()
                    }, label: {
                    Text("Open Menu")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 255, height: 55, alignment: .center)
                        .background(Color(.systemBlue))
                        .cornerRadius(22)
                        .shadow(color: .orange, radius: 10, x: 10)
                        
                        
                        })
             
            }
            
            SliderMenu(width: 322, menuOpened: self.menuOpened, toggleMenu: self.toggleMenu)

        }
        .edgesIgnoringSafeArea(.all)
        
       
        }
    func toggleMenu() {
        menuOpened.toggle()
    
    }
}



struct SliderMenu: View {
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
   
    
    
    var body: some View{
        ZStack{
//            Spacer()
            
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.15))
//            .animation(Animation.easeIn(duration:0.30), value: 3)
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.30))
            .onTapGesture {
                self.toggleMenu()
            }
            
            HStack {
                MenuContents()
                    .frame(width: 230)
                    .offset(x: menuOpened ? 0 : -width)
                Spacer()
            }
            
        }
        .tabViewStyle(PageTabViewStyle())
        
    }
}


struct MenuDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        MenuDrawerView()
    }
}
