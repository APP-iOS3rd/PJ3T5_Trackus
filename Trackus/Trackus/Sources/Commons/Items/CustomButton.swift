//
//  CustomButton.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

// 예시입니당

import SwiftUI

struct CustomButton: View {
    var ButtonText: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(ButtonText)
        }
        .frame(width: 300, height: 50)
        .background(.green)

    }
}

//#Preview {
//    CustomButton()
//}
