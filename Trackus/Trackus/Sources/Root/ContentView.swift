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
        AuthenticatedView {
            MainTabView()
                .environmentObject(viewModel)
        }
        
        //        switch viewModel.authenticationState {
        //        case .unauthenticated, .authenticating:
        //            LoginView()
        //                .environmentObject(viewModel)
        //        case .signUpcating:
        //            SignUpView()
        //                .environmentObject(viewModel)
        //        case .authenticated:
        //            MainTabView()
        //                .environmentObject(viewModel)
        //        }
    }
}

#Preview {
    ContentView()
}
