//
//  MapSettingView.swift
//  iOS Example
//
//  Created by tieda on 2020-09-20.
//  Copyright © 2020 Tieda Wei. All rights reserved.
//

import SwiftUI

struct MapSettingView: View {
    var body: some View {
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
}

struct MapSettingView_Previews: PreviewProvider {
    static var previews: some View {
        MapSettingView()
    }
}
