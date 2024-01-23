//
//  ViewPadding.swift
//  Trackus
//
//  Created by 윤준성 on 1/19/24.
//

import SwiftUI

struct PaddingValues {
    static let standard: CGFloat = 20
    static let special: CGFloat = 32
}

extension View {
    func standardPadding() -> some View {
        self.padding(.all, PaddingValues.standard)
    }

    func specialPadding() -> some View {
        self.padding(.all, PaddingValues.special)
    }
    
    func verticalStandardPadding() -> some View {
        self.padding(.init(top: PaddingValues.standard,
                           leading: 0,
                           bottom: PaddingValues.standard,
                           trailing: 0))
    }
    
    func horizontalStandardPadding() -> some View {
        self.padding(.init(top: 0,
                           leading: PaddingValues.standard,
                           bottom: 0,
                           trailing: PaddingValues.standard))
    }
    
    func horizontalSpecialPadding() -> some View {
        self.padding(.init(top: 0,
                           leading: PaddingValues.special,
                           bottom: 0,
                           trailing: PaddingValues.special))
    }
    
    func verticalSpecialPadding() -> some View {
        self.padding(.init(top: PaddingValues.special,
                           leading: 0,
                           bottom: PaddingValues.special,
                           trailing: 0))
    }
}
