//
//  FigmaDemoView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 06/12/23.
//

import SwiftUI

struct FigmaDemoView: View {
    var body: some View {
        
        VStack(alignment: .center){
                    
                HStack( spacing: 10) {
                    Spacer()
                    Image("Ellipse 5").resizable()
                        .frame(width: 24, height: 24)
                    .background(Color(red: 0.1, green: 0.12, blue: 0.14)).cornerRadius(12)
                    .overlay{
                        Image("icon-chevron-left").resizable()
                            .frame(width: 12, height: 12)
                            .background(Color(red: 0.1, green: 0.12, blue: 0.14))
                    }
                    
                    Text("JUN 1, 2023")
                        .font(
                            Font.custom("Agency FB", size: 28)
                                .weight(.heavy)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.White)
                    
                    Image("Ellipse 5").resizable()
                        .frame(width: 24, height: 24)
                    .background(Color(red: 0.1, green: 0.12, blue: 0.14)).cornerRadius(12)
                    .overlay{
                        Image("icon-chevron-right").resizable()
                            .frame(width: 12, height: 12).background(Color(red: 0.1, green: 0.12, blue: 0.14))
                    }
                    
                    Spacer()
                    
            }.frame(width: 393, height: 50).background(Color(red: 0.75, green: 0.58, blue: 0.05))
            
            VStack(alignment: .leading){
                HStack(spacing: 6){
                    Text("ACTIVATION")
                        .font(
                            Font.custom("Agency FB", size: 24)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                        .padding(.vertical, 9)
                    
                        Image("icon-chevron-down").resizable()
                            .frame(width: 12, height: 12)
                }
                
                    ScrollView(showsIndicators: false){
                        VStack(spacing: 55){
                            FigmaTileView()
                            FigmaTileView()
                            FigmaSubView2()
                    }
                }
                
            }

                   
                    
                    Spacer()
            
            HStack{
                Image("icon-arrow-left")
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
                Spacer()
                Image("icon-file-text (1)")
                .frame(width: 24, height: 24)
                Text("REPORT")
                  .font(
                    Font.custom("Agency FB", size: 18)
                      .weight(.bold)
                  )
                  .foregroundColor(Constants.White)
                  .frame( alignment: .topLeading)
                
                Spacer()
            }
            .padding(0)
                
            }
        }
    }
 

struct FigmaDemoView_Previews: PreviewProvider {
    static var previews: some View {
        
        ResponsiveView().previewDevice("iPhone 12")
            .preferredColorScheme(.light)
        
    }
}


struct Constants {
    static let White: Color = .white
    
}


struct FigmaTileView: View{
    var body: some View{
        ZStack{
            VStack(spacing: 12){
                HStack(alignment: .center){
                    
                    Text("Ground mobility 1").font(.system(size: 19, weight: .bold)).foregroundColor(Color(red: 0.75, green: 0.58, blue: 0.05)).padding(.top)
                    
                }
                .padding(.vertical, 12)
                    .frame( alignment: .center)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 6){
                            FigmaSubTileView().frame(maxWidth: .infinity)
                            FigmaSubTileView()
                            FigmaSubTileView()
                        }
                        
                     
                }
                ZStack {
                    HStack {
                        Image("icon-clock")
                            .frame(width: 15, height: 15)
                        Text("4:00 / set")
                          .font(Font.custom("Agency FB", size: 12))
                          .foregroundColor(Constants.White)
                          .frame(width: 57, alignment: .topLeading)
                        Spacer()
                        
                        Text("Set 1/3")
                            .font(
                                Font.custom("Agency FB", size: 14)
                                    .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                        .frame(alignment: .topLeading)
                        
                        Image("slider dots")
                        .frame(width: 32, height: 10)
                    }
                    .padding(0)
                    
                }
                .frame(width: 307, height: 25)
                
                Spacer()
            }
        }.padding(6).frame(width: 349, height: 243)
            .background(Color(red: 0.1, green: 0.12, blue: 0.14))
            .cornerRadius(8).overlay(alignment: .bottom){
                Image("Frame 1203")
                    .frame(width: 60, height: 60).padding(.bottom, -29)
            }
    }
}



struct FigmaSubTileView: View{
    var body: some View{
        
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                HStack{
                    Text("Movements")
                        .font(
                            Font.custom("Agency FB", size: 14)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                        .frame(width: 150, alignment: .topLeading)
                    Spacer()
                    Text("Reps")
                        .font(
                            Font.custom("Agency FB", size: 14)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                    
                    Text("Weight")
                        .font(
                            Font.custom("Agency FB", size: 14)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                }.padding(4)
                
            }
            .frame(width: 327, height: 40)
            .overlay(
                Rectangle()
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.26, green: 0.27, blue: 0.3), lineWidth: 1)
                
            )
            ZStack{
                HStack{
                    Text("Clean")
                        .font(
                            Font.custom("Agency FB", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Color(red: 0, green: 0.51, blue: 0.95))
                    
                        .frame(width: 150, alignment: .topLeading)
                    Spacer()
                    
                    Image("information-button 1")
                        .frame(width: 12, height: 12.02526)
                    
                    Spacer()
                    Text("5")
                        .font(
                            Font.custom("Agency FB", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                    Spacer()
                    
                    Text("180")
                        .font(
                            Font.custom("Agency FB", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                    
                }.padding(4)
            }.frame(maxWidth: .infinity, minHeight: 19, maxHeight: 19)
            
            ZStack{
                HStack{
                    Text("StrechLat")
                        .font(
                            Font.custom("Agency FB", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Color(red: 0, green: 0.51, blue: 0.95))
                    
                        .frame(width: 150, alignment: .topLeading)
                    Spacer()
                    
                    Image("information-button 1")
                        .frame(width: 12, height: 12.02526)
                    
                    Spacer()
                    Text("5")
                        .font(
                            Font.custom("Agency FB", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                    Spacer()
                    
                    Text("180")
                        .font(
                            Font.custom("Agency FB", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                    
                }.padding(4)
            }.frame(maxWidth: .infinity, minHeight: 19, maxHeight: 19)
            
            ZStack{
                HStack{
                    Text("Push")
                        .font(
                            Font.custom("Agency", size: 16)
                                .weight(.heavy)
                        )
                        .foregroundColor(Color(red: 0, green: 0.51, blue: 0.95))
                    
                        .frame(width: 150, alignment: .topLeading)
                    Spacer()
                    
                    Image("information-button 1")
                        .frame(width: 12, height: 12.02526)
                    
                    Spacer()
                    Text("5")
                        .font(
                            Font.custom("Agency FB", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                    Spacer()
                    
                    Text("180")
                        .font(
                            Font.custom("Agency FB", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.White)
                    
                }.padding(4)
            }.frame(maxWidth: .infinity, minHeight: 19, maxHeight: 19)
            
        }.padding(.horizontal, 0)
            .padding(.top, 0)
            .padding(.bottom, 6)
            .frame(width: 327, alignment: .topLeading)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.16, green: 0.18, blue: 0.21), lineWidth: 1)
                
            )

        
        
    }
}


struct FigmaSubView2: View{
    var body: some View{
        
        ZStack{
            VStack(spacing: 12){
                HStack(alignment: .center){
                    
                    Text("Ground mobility 1").font(.system(size: 19, weight: .bold)).foregroundColor(Color(red: 0.75, green: 0.58, blue: 0.05)).padding(.top)
                    
                }
                VStack(alignment: .leading, spacing: 16) {
                    ZStack {
                        HStack{
                            Text("Movements")
                                .font(
                                    Font.custom("Agency FB", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                                .frame(width: 150, alignment: .topLeading)
                            Spacer()
                            Text("Reps")
                                .font(
                                    Font.custom("Agency FB", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                            
                            Text("Weight")
                                .font(
                                    Font.custom("Agency FB", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                        }.padding(4)
                        
                    }
                    .frame(width: 327, height: 40)
                    .overlay(
                        Rectangle()
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.26, green: 0.27, blue: 0.3), lineWidth: 1)
                        
                    )
                    ZStack{
                        HStack{
                            Text("Clean")
                                .font(
                                    Font.custom("Agency FB", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color(red: 0, green: 0.51, blue: 0.95))
                            
                                .frame(width: 150, alignment: .topLeading)
                            Spacer()
                            
                            Image("information-button 1")
                                .frame(width: 12, height: 12.02526)
                            
                            Spacer()
                            Text("5")
                                .font(
                                    Font.custom("Agency FB", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                            Spacer()
                            
                            Text("180")
                                .font(
                                    Font.custom("Agency FB", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                            
                        }.padding(4)
                    }.frame(maxWidth: .infinity, minHeight: 19, maxHeight: 19)
                    
                    ZStack{
                        HStack{
                            Text("StrechLat")
                                .font(
                                    Font.custom("Agency FB", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color(red: 0, green: 0.51, blue: 0.95))
                            
                                .frame(width: 150, alignment: .topLeading)
                            Spacer()
                            
                            Image("information-button 1")
                                .frame(width: 12, height: 12.02526)
                            
                            Spacer()
                            Text("5")
                                .font(
                                    Font.custom("Agency FB", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                            Spacer()
                            
                            Text("180")
                                .font(
                                    Font.custom("Agency FB", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                            
                        }.padding(4)
                    }.frame(maxWidth: .infinity, minHeight: 19, maxHeight: 19)
                    
                    ZStack{
                        HStack{
                            Text("Push")
                                .font(
                                    Font.custom("Agency", size: 16)
                                        .weight(.heavy)
                                )
                                .foregroundColor(Color(red: 0, green: 0.51, blue: 0.95))
                            
                                .frame(width: 150, alignment: .topLeading)
                            Spacer()
                            
                            Image("information-button 1")
                                .frame(width: 12, height: 12.02526)
                            
                            Spacer()
                            Text("5")
                                .font(
                                    Font.custom("Agency FB", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                            Spacer()
                            
                            Text("180")
                                .font(
                                    Font.custom("Agency FB", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Constants.White)
                            
                        }.padding(4)
                    }.frame(maxWidth: .infinity, minHeight: 19, maxHeight: 19)
                }
                }.padding(.horizontal, 0)
                    .padding(.vertical, 6)
                    .padding(.bottom, 6)
                    .frame(width: 327, alignment: .topLeading)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.16, green: 0.18, blue: 0.21), lineWidth: 1)
                        
                    )
             
        }
        

    }
}


struct FigmaDemoHorizontal:View{
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var text = ""
    let labels = ["Username", "Email", "Password"]
    
    var body: some View {
        if horizontalSizeClass == .compact {
            HStack {
                VStack(alignment: .leading) {
                    ForEach(labels, id: \.self) { label in
                        Text(label)
                            .frame(maxHeight: .infinity)
                            .padding(.bottom, 4)
                    }
                }
                VStack {
                    ForEach(labels, id: \.self) { label in
                        TextField(label, text: self.$text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.leading)
            }
            .padding(.horizontal)
            .fixedSize(horizontal: false, vertical: true)
            
        } else {
            if #available(iOS 16.0, *) {
                Grid {
                    ForEach(labels, id: \.self) { label in
                        GridRow {
                            Text(label)
                            TextField(label, text: .constant(""))
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
                
            }
        }
    }
}



struct StringModel: Identifiable {
    let id = UUID()
    var value: String
    var isSelected = false
    var count: Int = 0
}

struct StringListView: View {
    @State var images: [StringModel] = [
        StringModel(value: "course"), StringModel(value: "croud_funding"),
        StringModel(value: "home_work_color"), StringModel(value: "HomeworkStudent"),
        StringModel(value: "image"), StringModel(value: "course"),
        StringModel(value: "center"), StringModel(value: "department"),
        StringModel(value: "hindalko_logo"), StringModel(value: "ic_launcher"),
        StringModel(value: "trainee")
    ]
    
    @State private var image: Image?
    @State private var isImagePickerPresented = false
    @State var tempImages: [StringModel] = []
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Text("Camera View")
                        .foregroundColor(.red)
                        .font(.system(size: 25, weight: .bold))
                    
                    Button(action: {
                        isImagePickerPresented.toggle()
                    }, label: {
                        Image(systemName: "camera").font(.system(size: 32, weight: .bold))
                    })
                    
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                        
                        ForEach(images) { img in
                            Image(img.value)
                                .resizable()
                                .frame(width: .infinity, height: 235)
                                .overlay {
                                    if img.isSelected {
                                        Text("\(img.count)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .bold))
                                            .padding(6)
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .offset(x: 10, y: -10)
                                    }
                                }
                                .onTapGesture {
                                    toggleSelection(for: img)
                                    updateTempImages()
                                }
                        }
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(tempImages) { image in
                            Image(image.value).resizable()
                                .frame(width:105, height: 135, alignment: .center)
                                .cornerRadius(8).overlay(alignment: .topTrailing){
                                    
                                    Image(systemName: "multiply")
                                        .font(.system(size: 32, weight: .bold)).onTapGesture {
                                            toggleSelection(for: image)
                                            updateTempImages()
                                        }
                                }
                        }
                    }
                }
            }
        }.sheet(isPresented: $isImagePickerPresented) {
            ImagePickerView(isPresented: $isImagePickerPresented, image: $image)
        }
    }
    
    private func toggleSelection(for string: StringModel) {
        if let index = images.firstIndex(where: { $0.id == string.id }) {
                    images[index].isSelected.toggle()
                    if images[index].isSelected {
                        images[index].count += 1
                    } else {
                        if images[index].count > 0 {
                            images[index].count -= 1
                        }
                    }
                }
    }
    
    private func updateTempImages() {
        tempImages = images.filter { $0.isSelected }
    }
    
    private var selectedImageCount: Int {
           tempImages.count
       }
    
}



struct CameraView: View {
    @State private var image: Image?
    @State private var isImagePickerPresented = false

    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Button("Take Photo") {
                    isImagePickerPresented.toggle()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePickerView(isPresented: $isImagePickerPresented, image: $image)
                }
            }
        }
    }
}
 

struct ImagePickerView: View {
    @Binding var isPresented: Bool
    @Binding var image: Image?
    var body: some View {
        ImagePickerCoordinator(isPresented: $isPresented, image: $image)
            .ignoresSafeArea()
        }
}

struct ImagePickerCoordinator: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var image: Image?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePickerCoordinator

        init(parent: ImagePickerCoordinator) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
            }
            parent.isPresented = true
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}


 

 
 
extension View {
    func detectOrientation(_ orientation: Binding<UIDeviceOrientation>) -> some View{
        modifier(DetectOrientation(orientation: orientation))
    }
}


struct DetectOrientation: ViewModifier {
    @Binding var orientation: UIDeviceOrientation
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){
                _ in
                orientation = UIDevice.current.orientation
            }
    }
}
// Core Data Add file
 

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title: String, body: String) {
        var trigger: UNNotificationTrigger?
        
        // Create a trigger (either from date or time based)
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        // Customise the content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        // Create the request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}



struct NotificationView: View {
    @State var selectedDate = Date()
    let notify = NotificationHandler()
    
    @State var presentSideMenu = false
    var body: some View {
        
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                VStack(spacing: 20) {
                    Spacer()
                    Button("Send notification in 5 seconds") {
                        notify.sendNotification(
                            date: Date(),type: "time",timeInterval: 5,title: "5 second notification",body: "You can write more in here!")
                    }
                    DatePicker("Pick a date:", selection: $selectedDate, in: Date()...)
                    Button("Schedule notification") {
                        notify.sendNotification(
                            date:selectedDate,
                            type: "date",
                            title: "Date based notification",
                            body: "This notification is a reminder that you added a date. Tap on the notification to see more.")
                    }.tint(.orange)
                    Spacer()
                    Text("Not working?")
                        .foregroundColor(.gray)
                        .italic()
                    Button("Request permissions") {
                        notify.askPermission()
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    HStack {
                        Button {
                            presentSideMenu.toggle()
                        } label: {
                            Image(systemName: "circle.fill")
                                .resizable().foregroundColor(.red)
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 24, height: 24)
                        .padding(.leading, 30)
                        
                        Spacer()
                    }
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.yellow)
                    .zIndex(2)
                    .shadow(radius: 0.3)
                , alignment: .top)
            .background(Color.gray.opacity(0.8))
            
            SideMenu()
        }
        
        .frame(maxWidth: .infinity)
        
    }
    
    
    @ViewBuilder
    private func SideMenu() -> some View {
        SideView(isShowing: $presentSideMenu, direction: .leading) {
            SideMenuViewContents(presentSideMenu: $presentSideMenu)
                .frame(width: 300)
        }
    }
}
 

struct SideView<RenderView: View>: View {
    @Binding var isShowing: Bool
    var direction: Edge
    @ViewBuilder  var content: RenderView
    
    var body: some View {
        ZStack(alignment: .leading) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(.move(edge: direction))
                    .background(
                        Color.yellow
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}


struct SideMenuViewContents: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 0) {
                SideMenuTopView()
                VStack {
                    Text("Side Menu")
                        .foregroundColor(.white)
                }.frame( maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background(.gray)
        }
    }
    
    func SideMenuTopView() -> some View {
        VStack {
            HStack {
                Button(action: {
                    presentSideMenu.toggle()
                }, label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                })
                .frame(width: 34, height: 34)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 40)
        .padding(.top, 40)
        .padding(.bottom, 30)
    }
}


struct ResponsiveView: View {
    
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        
        if heightSizeClass == .regular {
            Text("Portrait!").foregroundColor(.green)
                .padding()
        }
        else if heightSizeClass == .compact {
            Text("Landscape").foregroundColor(.red)
        }
        else {
            Text("Unknown")
        }
    }
}
