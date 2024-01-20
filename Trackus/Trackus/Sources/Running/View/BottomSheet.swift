//
//  BottomSheet.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/21.
//

import SwiftUI

/**
 러닝 상태를 보여주는 전용 sheet
 */
struct BottomSheet<Content: View>: View {
    @Binding var isFullScreen: Bool
    let content: Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea() 
            VStack {
                content
            }
            .frame(maxWidth: .infinity)
            .frame(height: isFullScreen ? UIScreen.screenHeight - 60 : UIScreen.screenHeight * 0.65)
            .background(TUColor.background)
            .cornerRadius(Constants.ViewLayoutConst.VIEW_STANDARD_CORNER_RADIUS)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
    
    init(isFullScreen: Binding<Bool>, content: () -> Content) {
        self._isFullScreen = isFullScreen
        self.content = content()
    }
}

//#Preview {
//    BottomSheet(isFullScreen: .constant(false))
//}
