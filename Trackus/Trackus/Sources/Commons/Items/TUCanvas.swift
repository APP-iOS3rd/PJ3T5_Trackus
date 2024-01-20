//
//  TUCanvas.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/19.
//

import SwiftUI

struct TUCanvas {
    // 여러가지 스타일의 캔버스뷰 추가예정
    struct ContentCanvasView<Content: View>: View {
        let content: Content
        var body: some View {
            content
                .modifier(TUCanvasModifier())
        }
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
    }
}

