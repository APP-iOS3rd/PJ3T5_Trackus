//
//  MainTabView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/19.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex = 0
    
    init() {
        UITabBar.appearance().backgroundColor = TUColor.tab
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                RunningView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image("run-icon").renderingMode(.template)
                        Text("러닝")
                    }
                    .tag(0)
                
                ReportView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("리포트")
                    }.tag(1)
                
                MyProfileView()
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("프로필")
                    }.tag(2)
            }
            .accentColor(TUColor.main)
            
        }
    }
}

#Preview {
    MainTabView()
}
