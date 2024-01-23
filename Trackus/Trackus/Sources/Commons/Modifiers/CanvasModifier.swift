//
//  TUCanvasModifier.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/19.
//

import SwiftUI

struct ContentModifier: ViewModifier {
    // 컬러가 정해지면 변경예정
    // 기본색상 설정
    let color: Color = TUColor.box
    
    func body(content: Content) -> some View {
        content
            .padding(Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(Constants.ViewLayoutConst.VIEW_STANDARD_CORNER_RADIUS)
    }
}

