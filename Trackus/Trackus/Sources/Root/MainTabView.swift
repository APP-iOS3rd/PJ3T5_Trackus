//
//  MainTabView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/19.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @State var selectedIndex = 0
    @State private var path: NavigationPath = NavigationPath()
    
    init() {
        let appearance: UITabBarAppearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = TUColor.tab
        appearance.shadowColor = TUColor.tab
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "러닝"
        case 1: return "리포트"
        case 2: return "프로필"
        default: return ""
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $selectedIndex) {
                RunningView(path: $path)
                    .tabItem {
                        Image("run-icon").renderingMode(.template)
                        Text("러닝")
                    }
                    .tag(0)
                
                
                ReportView()
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("리포트")
                    }
                    .tag(1)
                
                
                MyProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("프로필")
                    }
                    .tag(2)
                    .environmentObject(viewModel)
            }
            .navigationTitle(tabTitle)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(TUColor.main)
            
        }
        
    }
}

#Preview {
    MainTabView()
}

