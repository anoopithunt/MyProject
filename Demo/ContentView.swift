//
//  ContentView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 05/08/22.
//

import Foundation
import SwiftUI
import Combine
import PagerTabStripView

struct AddContact: View {
    @State var id = 999
    
    @State var first_name: String = ""
    @State var last_name: String = ""
    @State var phone_number: String = ""
    @State var address: String = ""
    
    @State var birthday = Date()
    @State var birthdayString: String = ""
    @State var create_date = Date()
    @State var create_dateString: String = ""
    @State var updated_date = Date()
    @State var updated_dateString: String = ""
    
    @State var manager = DataPost()
    
    var body: some View {
        if manager.formCompleted {
            Text("Done").font(.headline)
        }
        VStack {
            NavigationView {
                Form {
                    Section() {
                        TextField("First Name", text: $first_name)
                        TextField("Last Name", text: $last_name)
                    }
                    Section() {
                        TextField("Phone Number", text: $phone_number)
                        TextField("Address", text: $address)
                    }
                    Section() {
                        DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                    }
                    Section() {
                        Button(action: {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .short
                            
                            birthdayString = dateFormatter.string(from: birthday)
                            create_dateString = dateFormatter.string(from: create_date)
                            updated_dateString = dateFormatter.string(from: updated_date)
                            
                            print("Clicked")
                            
                            self.manager.checkDetails(id: self.id, first_name: self.first_name, last_name: self.last_name, phone_number: self.phone_number, address: self.address, birthday: self.birthdayString, create_date: self.create_dateString, updated_date: self.updated_dateString)
                            
                        }, label: {
                            Text("Add Contact")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                        })
                    }.disabled(first_name.isEmpty || last_name.isEmpty || phone_number.isEmpty || address.isEmpty)
                }
            }.navigationTitle("New Contact")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

class DataPost: ObservableObject {
    var didChange = PassthroughSubject<DataPost, Never>()
    var formCompleted = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func checkDetails(id: Int, first_name: String, last_name: String, phone_number: String, address: String, birthday: String, create_date: String, updated_date: String) {
        
        let body: [String: Any] = ["data": ["id": id, "first_name": first_name, "last_name": last_name, "birthday": birthday, "phone_number": phone_number, "create_date": create_date, "updated_date": updated_date, "address": address]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        //  "https://flaskcontact-list-app.herokuapp.com/contacts"
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("-----> data: \(String(describing: data))")
            print("-----> error: \(String(describing: error) )")
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print("-----1> responseJSON: \(String(describing: responseJSON))")
            if let responseJSON = responseJSON as? [String: Any] {
                print("-----2> responseJSON: \(responseJSON)")
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    var body: some View {
        AddContact()
    }
}






struct MyPagerView: View {
    var body: some View {
        VStack{
        PagerTabStripView() {
            AccountView()
                .frame(width: UIScreen.main.bounds.width)
                .pagerTabItem {
                    TitleNavBarItem(title: "ACCOUNT", systomIcon: "character.bubble.fill")
                       
                }
               
            UserAccountProfileView()
                .frame(width: UIScreen.main.bounds.width)
                .pagerTabItem {
                    TitleNavBarItem(title: "PROFILE", systomIcon: "person.circle.fill")
                }
         
            UserAccountPasswordView()
                .frame(width: UIScreen.main.bounds.width)
                    .pagerTabItem {
                        TitleNavBarItem(title: "PASSWORD", systomIcon: "lock.fill")
                    }
            
        }
        .pagerTabStripViewStyle(.barButton(placedInToolbar: false, tabItemSpacing: 0, tabItemHeight: 80,indicatorViewHeight: 3, indicatorView: {
            Color.black
        })).padding(-2)
  
        .foregroundColor(.white)
            
        }
    }
}


struct TitleNavBarItem: View {
    let title: String
    let systomIcon: String
    var body: some View {
        VStack {
            Image(systemName: systomIcon)
             .foregroundColor( .white)
             .font(.title)
    
             Text( title)
                .font(.system(size: 22))
//                .bold()
//                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("orange"))
    }
}





struct AccountView: View{
    @State  var email: String = ""
    @State  var fName: String = ""
    @State  var lName: String = ""
    @State  var mobile: String = "8299544315"
    @State  var pinCode: String = "211001"
    @State  var address: String = "Prayagraj"
    @State  var state: String = "Uttar Pradesh"
    
    @State  var city: String = "Prayagraj"
       
    var body: some View{
        ZStack{
            Image("u").resizable()
            
            VStack{
                
                
                ScrollView(showsIndicators: true){
                    
                    CustomFloatingTextField(placeHolder: "Email", leadingImage: "person.crop.rectangle.fill", text: $email).padding()
                    CustomFloatingTextField(placeHolder: "First Name", leadingImage: "person.crop.rectangle.fill", text: $fName).padding()
                    CustomFloatingTextField(placeHolder: "Last Name", leadingImage: "person.crop.rectangle.fill", text: $lName).padding()
                    //                CustomFloatingTextField(placeHolder: "Date of Birth", rightImage: "calendar", text: $dob).padding()
                    HStack{
                        Text("**Address Details**").font(.system(size: 26)).frame(alignment: .leading).foregroundColor(.black)
                        Spacer()
                    }.padding()
                    CustomFloatingTextField(placeHolder: "Pincode", leadingImage: "magazine", text: $pinCode).padding().keyboardType(.numberPad)
                    CustomFloatingTextField(placeHolder: "Mobile no.", leadingImage: "phone.fill", text: $mobile).padding()
                    
                    CustomFloatingTextField(placeHolder: "Address", leadingImage: "location.fill", text: $address).padding()

                    
                    DropdownSelector(placeholder: city)
                                            .padding()
                    
                    Group{
                        
                        HStack{
                            Text("**City Name:\(address)**").font(.system(size: 26)).frame(alignment: .leading).foregroundColor(.black)
                            Spacer()
                        }.padding()
                        HStack{
                            Text("**State Name:\(state)**").font(.system(size: 26)).frame(alignment: .leading).foregroundColor(.black)
                            Spacer()
                        }.padding()
                                            HStack{
                                                Spacer()
                                                Text("**Update Account**").padding()
                                                    .font(.system(size: 26)).frame(alignment: .leading).foregroundColor(.white).background(Color.black).cornerRadius(28)
                                            }.padding()
                        
                    }
                }
            }
}
    }
}





struct UserAccountPasswordView: View{
    @State var isInSecureField = false
    @State var email: String = ""
    @State var oldPass: String = ""
    @State var newPass: String = ""
    @State var comfirmPass: String = ""
    var body: some View{
        
        ZStack{
            Image("u").resizable().background(Color.white)
            VStack{
                CustomFloatingTextField(placeHolder: "Email", leadingImage: "person.crop.rectangle.fill", text: $email).padding()
                CustomFloatingTextField(placeHolder: "Old Password", leadingImage: "lock.fill", text: $oldPass).overlay(alignment: .trailing, content: {
                    Image(systemName: "eye").foregroundColor(.black).padding(.trailing,28)
                }).padding()
                
                
                CustomFloatingTextField(placeHolder: "New Password", leadingImage: "lock.fill", text: $newPass).overlay(alignment: .trailing, content: {
                    Image(systemName: "eye").foregroundColor(.black).padding(.trailing,28)
                }).padding()
                CustomFloatingTextField(placeHolder: "Comfirm Password", leadingImage: "lock.fill", text: $comfirmPass).padding()
//                SecureField("enter your password", text: Binding<String>(
//                               get: { self.email },
//                               set: { self.email = $0
//                                   print("editing a SecureField")
//                                   self.isInSecureField = true
//                                  }
//                )).overlay(alignment: .trailing, content: {
//                    Image(systemName: "lock.fill")
//                }).padding()
                Spacer()
                
//                HStack{
                
                    Text("**Update Password**").padding()
                    .font(.system(size: 22)).frame(width: UIScreen.main.bounds.width*0.9).foregroundColor(.white).background(Color.black).cornerRadius(28)
//                }.padding()
                
                
            }.padding(.top)
        }
    }
}





struct CustomFloatingPasswordField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @State var rightImage: String
    @State var isTapped: Bool = true
    @Binding var text: String
    @State private var isEditing = false
    public init(placeHolder: String, rightImage: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
        self.rightImage = rightImage
 
    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    
    
    var body: some View {
        ZStack(alignment: .leading) {

            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = true
            }) .overlay(alignment: .trailing, content: {
               
                    Image(systemName: isTapped ? "eye" : "eye.slash")
                    .foregroundColor(.black).onTapGesture {
                        
                        isEditing.toggle()
                    }
               
        })

                    
            .padding(.leading,40)
            .padding(.trailing,35)
            .foregroundColor(Color.gray)
            .accentColor(Color.orange)
            .font(.system(size: 22))
            .animation(.easeInOut(duration: 1.2), value:  true)
           
            ///Floating Placeholder
                Text(placeHolderText)
                .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
            .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 0, leading:12  , bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:43, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
            
            .animation(.easeInOut, value: 91)
            .overlay(alignment: .leading){
                Image(systemName: rightImage)
                    .foregroundColor(.gray)
                    .font(.system(size: 24)).padding(.trailing)
            }
                                
        }
        .underlineTextField()
        .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
        .frame( height: 50)

    }
}








import SwiftUI
import AVKit

struct ProView: View {
    
    @State private var scrollText = false
    
    var body: some View {
        
        ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    ScrollViewReader { value in
                        
                        HStack(spacing: 5) {
                            
                            ForEach(0 ..< 100) { i in
                                
                                HStack {
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                              
                                    
                                }
                                .id(i)
                            }
                            
                        }
                        .offset(x: scrollText ? -1000 : 20)
                        .animation(Animation.linear(duration: 12).repeatForever(autoreverses: false))
                        .onAppear() {
                            value.scrollTo(23, anchor: .trailing)
                            scrollText.toggle()
                        }
                    }
                }
                
                Spacer()
            }
            
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ProView()
        AccountSettingView()
    }
}
