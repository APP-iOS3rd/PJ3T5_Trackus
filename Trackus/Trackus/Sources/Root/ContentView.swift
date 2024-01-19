//
//  ContentView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/17.
//

import SwiftUI

struct ContentView: View {
    // 화면을 나누기 위해서 임시로 설정
    let isLogin = false
    var body: some View {
        Group {
            if isLogin {
                Login()
            } else {
                MainTabView()
            }
        }
    }
}

#Preview {
    ContentView()
}
