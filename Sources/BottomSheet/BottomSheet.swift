//
//  BottomSheet.swift
//  BottomSheet
//
//  Created by Tieda Wei on 2020-04-25.
//  Copyright © 2020 Tieda Wei. All rights reserved.
//

import SwiftUI

#if !os(macOS)
public struct BottomSheet<Content: View>: View {
    
    private var dragToDismissThreshold: CGFloat { height * 0.2 }
    private var grayBackgroundOpacity: Double { isPresented ? (0.4 - Double(draggedOffset)/600) : 0 }
    
    @State private var draggedOffset: CGFloat = 0
    @State private var previousDragValue: DragGesture.Value?

    @Binding var isPresented: Bool
    private let height: CGFloat
    private let topBarHeight: CGFloat
    private let topBarCornerRadius: CGFloat
    private let content: Content
    private let contentBackgroundColor: Color
    private let topBarBackgroundColor: Color
    private let showTopIndicator: Bool
    private let animation: Animation
    private let onDismiss: (() -> Void)?
    
    public init(
        isPresented: Binding<Bool>,
        height: CGFloat,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        topBarBackgroundColor: Color = Color(.systemBackground),
        contentBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool,
        animation: Animation = .easeInOut(duration: 0.3),
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.topBarBackgroundColor = topBarBackgroundColor
        self.contentBackgroundColor = contentBackgroundColor
        self._isPresented = isPresented
        self.height = height
        self.topBarHeight = topBarHeight
        if let topBarCornerRadius = topBarCornerRadius {
            self.topBarCornerRadius = topBarCornerRadius
        } else {
            self.topBarCornerRadius = topBarHeight / 3
        }
        self.showTopIndicator = showTopIndicator
        self.animation = animation
        self.onDismiss = onDismiss
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            if geometry.size != .zero {
                ZStack {
                    self.fullScreenLightGrayOverlay()
                    VStack(spacing: 0) {
                        self.topBar(geometry: geometry)
                        VStack(spacing: -8) {
                            Spacer()
                            self.content.padding(.bottom, geometry.safeAreaInsets.bottom)
                            Spacer()
                        }
                    }
                    .frame(height: sheetHeight(in: geometry) - min(self.draggedOffset*2, 0))
                    .background(self.contentBackgroundColor)
                    .cornerRadius(self.topBarCornerRadius, corners: [.topLeft, .topRight])
                    .animation(animation)
                    .offset(y: self.isPresented ? (geometry.size.height/2 - sheetHeight(in: geometry)/2 + geometry.safeAreaInsets.bottom + self.draggedOffset) : (geometry.size.height/2 + sheetHeight(in: geometry)/2 + geometry.safeAreaInsets.bottom))
                }
            } else {
                EmptyView()
            }
        }
    }
    
    fileprivate func sheetHeight(in geometry: GeometryProxy) -> CGFloat {
        return min(height, geometry.size.height)
    }
    
    fileprivate func fullScreenLightGrayOverlay() -> some View {
        Color
            .black
            .opacity(grayBackgroundOpacity)
            .edgesIgnoringSafeArea(.all)
            .animation(animation)
            .onTapGesture {
                self.isPresented = false
                onDismiss?()
            }
    }
    
    fileprivate func topBar(geometry: GeometryProxy) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.secondary)
                .frame(width: 40, height: 6)
                .opacity(showTopIndicator ? 1 : 0)
        }
        .frame(width: geometry.size.width, height: topBarHeight)
        .background(topBarBackgroundColor)
        .gesture(
            DragGesture()
                .onChanged({ (value) in
                    // ignore gestures while the sheet is hidden. Otherwise it could collide with the iOS-global "go to home screen"-gesture
                    guard isPresented else { return }

                    let offsetY = value.translation.height
                    self.draggedOffset = offsetY
                    
                    if let previousValue = self.previousDragValue {
                        let previousOffsetY = previousValue.translation.height
                        let timeDiff = Double(value.time.timeIntervalSince(previousValue.time))
                        let heightDiff = Double(offsetY - previousOffsetY)
                        let velocityY = heightDiff / timeDiff
                        if velocityY > 1400 {
                            self.isPresented = false
                            onDismiss?()
                            return
                        }
                    }
                    self.previousDragValue = value
                    
                })
                .onEnded({ (value) in
                    let offsetY = value.translation.height
                    if offsetY > self.dragToDismissThreshold {
                        self.isPresented = false
                        onDismiss?()
                    }
                    self.draggedOffset = 0
                })
        )
    }
}
#endif
