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
    @State var shouldShow = true
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color.secondary
                    Text("Hi")
                }.navigationBarItems(trailing:
                    Button(action: { self.shouldShow = true }) {
                        Text("Show")
                    }
                ).navigationBarTitle("Bottom Sheet")
            }
            BottomSheet(shouldShow: $shouldShow, maxHeight: 500) {
//                Text("Hello")
                        List(0..<20) { Text("\($0)") }

            }
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
