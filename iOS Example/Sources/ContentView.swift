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
    @State var showMap = true
    
    var body: some View {
        NavigationView {
            List(0..<20) {
                Text("\($0)")
            }
            .bottomSheet(isPresented: self.$showList, height: 500) {
                List(20..<40) { Text("\($0)") }
            }
            .bottomSheet(isPresented: self.$showMap, height: 370, showTopIndicator: false) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Map Settings").font(.title).bold()
                        Spacer()
                        Image(systemName: "xmark.circle.fill").foregroundColor(.gray).font(.system(size: 26))
                    }.padding(.horizontal)
                    Picker(selection: .constant(0), label: Text("")) {
                        Text("Map").tag(0)
                        Text("Transit").tag(1)
                        Text("Satellite").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    Divider()
                    Toggle(isOn: .constant(true)) {
                        Text("Traffic").font(.body)
                    }.padding(.horizontal)
                    Rectangle().frame(height: 8).foregroundColor(Color(UIColor.systemGray5))
                    VStack {
                        HStack {
                            Button(action: { }) {
                                Text("Mark My Location").font(.system(size: 16))
                            }
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Button(action: { }) {
                                Text("Add a Missing Place").font(.system(size: 16))
                            }
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Button(action: { }) {
                                Text("Report an Issue").font(.system(size: 16))
                            }
                            Spacer()
                        }
                    }.padding(.horizontal)
                    Rectangle().frame(height: 8).foregroundColor(Color(UIColor.systemGray5))
                    VStack(alignment: .leading) {
                        Text("TomTom").font(.system(size: 14)).bold()
                        Text("© OpenStreetMap and other data providers").font(.caption)
                    }.padding(.horizontal)
                    Spacer()
                }
            }
            .navigationBarTitle("Bottom Sheet")
            .navigationBarItems(
                leading: Button(action: { self.showMap = true }) { Text("Setting") },
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
