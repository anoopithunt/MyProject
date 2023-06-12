//
//  CustomAlertView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 14/01/23.
//

import SwiftUI

struct CustomAlertView: View {
    @State var showDatePicker: Bool = false
    @State var date: Date = Date()
    @State private var dateString: String = "11/11/2022"
      var dateFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateStyle = .short
          return formatter
      }
    var body: some View {
        ZStack{
            VStack {
                Text(dateFormatter.string(from: date))
                    .onTapGesture {
                        self.showDatePicker = true
                    }
            }
            if showDatePicker {
                DatePicker("", selection: $date, displayedComponents: .date).datePickerStyle(GraphicalDatePickerStyle())//.frame(width: 245, height: 345).background(Color.white)
                    .onReceive([self.date].publisher.first()) { (newDate) in
                        self.dateString = self.dateFormatter.string(from: newDate)
                    }
            }
        }.background(Color.gray)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
//        DateView()
        CustomAlertView()
    }
}



struct DateView: View {
    
    @State var showDatePicker: Bool = false
    @State var date: Date? = nil
    @State var today: String = "11-11-2022"
    @State var dateformat = DateFormatter()
   
    var body: some View {
        ZStack {
            
            VStack(spacing: 12) {
                HStack{
                    Text("Date of birth").padding(.leading)
                    Spacer()
                }
               
               
                HStack {
                    //
                    Image(systemName: "calendar").resizable().foregroundColor(.gray).frame(width: 35, height: 30)
                    Button(action: {
                        showDatePicker.toggle()
                    }, label: {
                        Text(date ?? Date.now, style: .date).foregroundColor(.black).font(.system(size: 24,weight: .bold)).padding(.leading)
                        Spacer()
                    })
                Spacer()
                }
            }.padding(.top, -28).underlineTextField()
//            Text(date?.formatted(), style: .dateTime)

            if showDatePicker {
                DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $date, selectedDate: date ?? Date())
                    .animation(.linear, value: 2)
                    .transition(.opacity)
            }
        }
        
    }
}

struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                DatePicker("Date of birth", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Divider()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("OK".uppercased()).foregroundColor(.red)
                            .bold()
                    })
                    
                }
                .padding()

            }
            .padding(12).frame(width:385, height: 435)
            .background(
                Color.yellow
                    .cornerRadius(30)
            )

            
        }

    }
}
