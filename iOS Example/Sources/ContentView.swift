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
    @State var isPresented = true
    
    var body: some View {
        NavigationView {
            List(0..<20) {
                Text("\($0)")
            }
            .bottomSheet(isPresented: self.$isPresented, maxHeight: 300) {
                List(20..<40) { Text("\($0)") }
            }
            .navigationBarTitle("Bottom Sheet")
            .navigationBarItems(
                trailing: Button(action: { self.isPresented = true }) { Text("Show") }
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
