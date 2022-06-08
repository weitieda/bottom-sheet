//
//  ViewExtension.swift
//  BottomSheet
//
//  Created by Tieda Wei on 2020-04-25.
//  Copyright © 2020 Tieda Wei. All rights reserved.
//

import SwiftUI

#if !os(macOS)
public extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        height: CGFloat,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        contentBackgroundColor: Color = Color(.systemBackground),
        topBarBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool = true,
        animation: Animation = .interactiveSpring(),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            BottomSheet(isPresented: isPresented,
                        height: height,
                        topBarHeight: topBarHeight,
                        topBarCornerRadius: topBarCornerRadius,
                        topBarBackgroundColor: topBarBackgroundColor,
                        contentBackgroundColor: contentBackgroundColor,
                        showTopIndicator: showTopIndicator,
                        animation: animation,
                        content: content)
        }
    }

    func bottomSheet<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        height: CGFloat,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        contentBackgroundColor: Color = Color(.systemBackground),
        topBarBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool = true,
        animation: Animation = .interactiveSpring(),
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        let isPresented = Binding {
            item.wrappedValue != nil
        } set: { value in
            if !value {
                item.wrappedValue = nil
            }
        }
        
        return bottomSheet(
            isPresented: isPresented,
            height: height,
            topBarHeight: topBarHeight,
            topBarCornerRadius: topBarCornerRadius,
            contentBackgroundColor: contentBackgroundColor,
            topBarBackgroundColor: topBarBackgroundColor,
            showTopIndicator: showTopIndicator,
            animation: animation
        ) {
            if let unwrapedItem = item.wrappedValue {
                content(unwrapedItem)
            } else {
                EmptyView()
            }
        }
    }
}
#endif
