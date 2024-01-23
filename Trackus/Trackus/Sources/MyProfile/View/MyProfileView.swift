//
//  MyProfileView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct MyProfileView: View {
    @StateObject private var viewModel = MyProfileViewModel()

    var body: some View {
        TUCanvas.CustomCanvasView(style: .background) {
            ScrollView {
                // 프로필 정보
                ProfileInfo()
                Spacer()
                
                // 사용자 정보
                RoundedRectangle(cornerRadius: Constants.ViewLayoutConst.VIEW_STANDARD_CORNER_RADIUS)
                    .foregroundColor(TUColor.box)
                    .frame(height: 80)
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            UserDetailItemView(title: "170cm", content: "키")
                            Spacer()
                            UserDetailItemView(title: "65kg", content: "몸무게")
                            Spacer()
                            UserDetailItemView(title: "25세", content: "나이")
                        }
                            .padding(Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                    )
                
                // 설정과 개인정보 항목
                VStack(alignment: .leading, spacing: Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING) {
                    MyTypography.bodytitle(text: "운동")
                        .padding(.horizontal)
                    ListSettingsItem(title: "러닝기록")
                    Divider()
                        .background(TUColor.border)
                    
                    MyTypography.bodytitle(text: "서비스")
                        .padding(.horizontal)
                    ListSettingsItem(title: "이용약관")
                    ListSettingsItem(title: "오픈소스/라이센스")
                    Divider()
                        .background(TUColor.border)
                    
                    MyTypography.bodytitle(text: "고객지원")
                        .padding(.horizontal)
                    NavigationLink(destination: FAQView(), isActive: $viewModel.isFAQActive) {
                        ListSettingsItem(title: "자주묻는 질문 Q&A")
                            .onTapGesture {
                                viewModel.faqButtonTapped()
                            }
                    }
                    NavigationLink(destination: AskView(), isActive: $viewModel.isAskActive) {
                        ListSettingsItem(title: "문의하기")
                            .onTapGesture {
                                viewModel.askButtonTapped()
                            }
                    }
                    Divider()
                        .background(TUColor.border)
                    
                    MyTypography.bodytitle(text: "우리팀을 응원하기")
                        .padding(.horizontal)
                    ListSettingsItem(title: "프리미엄 결제하기")
                }
                .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                
                Spacer()
            }
            .foregroundColor(TUColor.main)
            .background(TUColor.background)
            
            // SettingsView가 나타날 때마다 설정 활성화 초기화
            .onAppear {
                viewModel.isSettingsActive = false
            }
        }
    }
}

    
class NavigationManager: ObservableObject {
    static let shared = NavigationManager()

    @Published var isSettingsActive: Bool = false

    func navigateToSettings() {
        isSettingsActive = true
    }
}
struct ProfileInfo: View {
    var body: some View {
        HStack {
            // 프로필 이미지
            Image("userface")
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .padding(.trailing, 8)
            
            // 이름
            VStack(alignment: .leading, spacing: 4) {
                MyTypography.subtitle(text: "이름")
                    .font(.headline)
            }
            
            Spacer()
            
            // 프로필 변경 버튼
            NavigationLink(destination: MyProfileChangeView()) {
                HStack {
                    MyTypography.body(text: "프로필 변경")
                        .font(.subheadline)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

struct UserDetailItemView: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(TUColor.main)
                .padding(.bottom, 5)
            Text(content)
                .font(.subheadline)
                .foregroundColor(TUColor.border)
        }
        .padding()
    }
}

struct ListSettingsItem: View {
    var title: String
    
    var body: some View {
        HStack {
            MyTypography.profilebody(text: title)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 18))
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}


#Preview {
    MyProfileView()
}
