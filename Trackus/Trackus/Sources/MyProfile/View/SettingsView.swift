//
//  SettingsView.swift
//  Trackus
//
//  Created by 박소희 on 1/22/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: MyProfileView()) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(TUColor.main)
                        .padding()
                }
                
                Spacer()
                
                MyTypography.subtitle(text: "설정")
                Spacer()
            }
            .background(TUColor.background)
            .navigationBarItems(leading: EmptyView(), trailing: EmptyView())
            

                VStack(alignment: .leading, spacing: Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING) {
                    MyTypography.bodytitle(text: "앱 정보")
                        .padding(.leading)
                    MyTypography.body(text: "버전 정보")
                        .padding(.leading)
                    ListSettingsItem(title: "팀")
                    Divider()
                        .background(TUColor.border)

                    MyTypography.bodytitle(text: "계정관리")
                        .padding(.leading)
                    MyTypography.body(text: "로그아웃")
                        .padding(.leading)

                    // 회원탈퇴 버튼
                    Button("회원탈퇴") {

                        // 버튼을 클릭하면 WithdrawalView로 이동
                        viewModel.navigateToWithdrawalView()

                    }
                    .foregroundColor(Color.red)
                    .background(NavigationLink("", destination: WithdrawalView(), isActive: $viewModel.isWithdrawalActive))
                    .padding(.leading)
                }
                .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                Spacer()
            }
            .foregroundColor(TUColor.main)
            .background(TUColor.background)
            .navigationBarHidden(true)
        }
}

#Preview {
    SettingsView()
}

