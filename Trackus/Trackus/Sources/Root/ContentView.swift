//
//  ContentView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TUCanvas.CustomCanvasView(style: .background) {
            TUCanvas.CustomCanvasView(style: .content) {
                Text("안녕 하세용")
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
