//
//  ContentView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    // 화면을 나누기 위해서 임시로 설정
    let isLogin = false
    var body: some View {
        switch viewModel.authenticationState {
        case .unauthenticated, .authenticating:
            LoginView()
                .environmentObject(viewModel)
        case .signUpcating:
            SignUpView()
                .environmentObject(viewModel)
        case .authenticated:
            MainTabView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    ContentView()
}
