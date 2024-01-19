//
//  TUColor.swift
//  Trackus
//
//  Created by 박소희 on 1/19/24.
//

import SwiftUI

// 사용예시) TUColor.main

struct TUColor {
    static let main = Color(hex: 0xFFFFFF)
    static let sub = Color(hex: 0x2D4AE3)
    static let box = Color(hex: 0x212121)
}

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}