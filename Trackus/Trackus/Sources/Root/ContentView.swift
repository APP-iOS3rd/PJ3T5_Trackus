//
//  ContentView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        TUCanvas.CustomCanvasView {
            AuthenticatedView {
                MainTabView()
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
