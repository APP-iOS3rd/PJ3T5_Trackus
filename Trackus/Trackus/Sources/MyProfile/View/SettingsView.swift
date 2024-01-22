//
//  SettingsView.swift
//  Trackus
//
//  Created by 박소희 on 1/22/24.
//

import SwiftUI

struct SettingsView: View {
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
                    }
                    .padding(.leading)

                    Spacer()

                    // 가운데에 "설정" 텍스트
                    Text("설정")
                        .font(.title)
                        .foregroundColor(TUColor.main)

                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                .background(TUColor.background)

                // 참고 코드의 내용
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
                        isWithdrawalActive = true
                    }
                    .foregroundColor(Color.red)
                    .background(NavigationLink("", destination: WithdrawalView(), isActive: $isWithdrawalActive))
                    .padding(.leading)
                }
                .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                Spacer()
            }
            .foregroundColor(TUColor.main)
            .background(TUColor.background)
            .navigationBarHidden(true)
            .navigationBarTitle("설정", displayMode: .automatic)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SettingsView()
}
