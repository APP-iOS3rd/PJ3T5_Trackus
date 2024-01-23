//
//  TUCanvas.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/19.
//

import SwiftUI

struct TUCanvas {
    enum TUCanvasStyle {
        case content
        case background
    }
    /**
     ## TUCanvas
     TUCanvasStyle 열거형 타입을 받아서 타입에 맞는 뷰를 반환합니다.
     
     ## Parameter
     style: TUCanvasStyle에 정의된 view 타입
     content: View를 반환하는 타입
     
     ## 사용예시
     TUCanvas.CustomCanvasView(style:TUCanvasStyle, content: () -> View)
     */
    struct CustomCanvasView<Content: View>: View {
        let style: TUCanvasStyle
        let content: Content
        var body: some View {
            // style별로 다른 캔버스를 나타냄
            switch style {
            case .background:
                VStack {
                    ZStack {
                        TUColor.background
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            content
                        }
                    }
                }
            case .content:
                content
                    .modifier(ContentModifier())
           
            }
        }
        
        init(style: TUCanvasStyle = .background, @ViewBuilder content: () -> Content) {
            self.content = content()
            self.style = style
        }
    }
}

