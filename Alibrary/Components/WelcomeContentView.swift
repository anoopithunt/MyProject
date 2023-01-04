//
//  WelcomeContentView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 02/12/22.
//

import Foundation
import SwiftUI


struct WelcomeContentView: View {
    @StateObject var monitor = Monitor()
//     @EnvironmentObject var monitor: Monitor
    var body: some View {
//        Text(monitor.status.rawValue)
        if monitor.status == .connected{
            ContentView().navigationTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
        else if monitor.status == .disconnected{
            WelcomeView()
        } else{
            Text("Please Check internet Speed.......").bold()
        }
    }
}
