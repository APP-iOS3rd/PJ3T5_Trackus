//
//  SettingsView.swift
//  Trackus
//
//  Created by 박소희 on 1/22/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var isBackToProfileActive: Bool = false
    @State private var isWithdrawalActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // 뒤로가기 버튼과 설정 타이틀
                HStack {
                    NavigationLink(destination: MyProfileView()) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(TUColor.main)
                            .padding()
                    }
                    Spacer()
                    
                    Text("설정")
                        .font(.title)
                        .foregroundColor(TUColor.main)
                    
                    Spacer()
                }
                .padding()
                .background(TUColor.background)
                
                // 참고 코드의 내용
                VStack(alignment: .leading, spacing: 20) {
                    Text("앱 정보")
                        .font(.headline)
                        .foregroundColor(TUColor.main)
                        .padding(.horizontal)
                    Text("버전 정보")
                        .foregroundColor(TUColor.border)
                        .padding(.horizontal)
                    ListSettingsItem(title: "팀")
                    Divider()
                        .background(TUColor.border)
                    
                    Text("계정관리")
                        .font(.headline)
                        .foregroundColor(TUColor.main)
                        .padding(.horizontal)
                    Text("로그아웃")
                        .foregroundColor(TUColor.border)
                        .padding(.horizontal)
                    
                    // 회원탈퇴 버튼
                    Button("회원탈퇴") {
                        // 버튼을 클릭하면 WithdrawalView로 이동
                        isWithdrawalActive = true
                    }
                    .foregroundColor(Color.red)
                    .padding(.horizontal)
                    .background(NavigationLink("", destination: WithdrawalView(), isActive: $isWithdrawalActive))
                }
                .padding(.top, 20)
                Spacer()
                                
            }
            .foregroundColor(TUColor.main)
            .background(TUColor.background)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SettingsView()
}
