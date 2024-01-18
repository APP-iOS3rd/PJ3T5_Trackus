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
}
