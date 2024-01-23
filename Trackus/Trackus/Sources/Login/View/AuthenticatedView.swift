//
//  AuthenticatedView.swift
//  Trackus
//
//  Created by 최주원 on 1/23/24.
//

import SwiftUI

extension AuthenticatedView where Unauthenticated == EmptyView {
  init(@ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = nil
    self.content = content
  }
}

struct AuthenticatedView<Content, Unauthenticated>: View where Content: View, Unauthenticated: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var presentingLoginScreen = false
    
    var unauthenticated: Unauthenticated?
    @ViewBuilder var content: () -> Content
    
    public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = unauthenticated
        self.content = content
    }
    
    public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated, @ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = unauthenticated()
        self.content = content
    }
    
    
    var body: some View {
        switch viewModel.authenticationState {
            // 로그인
        case .unauthenticated, .authenticating:
            VStack {
                LoginView()
                    .environmentObject(viewModel)
            }
            //이전에 로그인 했을경우
        case .signUpcating:
            VStack{
                SignUpView()
                    .environmentObject(viewModel)
            }
        case .authenticated:
            VStack {
                content()
            }
        }
    }
}
