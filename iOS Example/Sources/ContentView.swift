//
//  ContentView.swift
//  iOS Example
//
//  Created by Tieda Wei on 2020-04-26.
//  Copyright © 2020 Tieda Wei. All rights reserved.
//

import SwiftUI
import BottomSheet

struct ContentView: View {
    @State var showList = false
    @State var showMapSetting = true
    
    var body: some View {
        NavigationView {
            List(0..<20) {
                Text("\($0)")
            }.listStyle(PlainListStyle())
            .bottomSheet(isPresented: $showList, height: 500) {
                List(20..<40) { Text("\($0)") }.listStyle(PlainListStyle())
            }
            .bottomSheet(
                isPresented: $showMapSetting,
                height: 370,
                topBarHeight: 16,
                topBarCornerRadius: 16,
                showTopIndicator: false
            ) {
                MapSettingView{ self.showMapSetting = false }
            }
            .navigationBarTitle("Bottom Sheet")
            .navigationBarItems(
                leading: Button(action: { self.showMapSetting = true }) { Text("Setting") },
                trailing: Button(action: { self.showList = true }) { Text("List") }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .environment(\.colorScheme, .dark)
        }
    }
}
