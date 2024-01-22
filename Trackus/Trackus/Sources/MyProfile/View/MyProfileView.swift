//
//  MyProfileView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct MyProfileView: View {
    @State private var isSettingsActive: Bool = false
    @State private var isFAQActive: Bool = false
    @State private var isAskActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // 상단 바
                HStack {
                    Text("설정 및 개인정보")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                    
                    Image(systemName: "gear")
                        .font(.system(size: 20))
                        .padding()
                        .onTapGesture {
                            // 톱니바퀴 이미지를 클릭했을 때 설정화면으로 이동
                            isSettingsActive = true
                        }
                        .background(NavigationLink("", destination: SettingsView(), isActive: $isSettingsActive))
                }
                // 프로필 정보
                ProfileInfo()
                
                // 사용자 정보
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 80)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            UserDetailItemView(title: "170cm", content: "키")
                            Spacer()
                            UserDetailItemView(title: "65kg", content: "몸무게")
                            Spacer()
                            UserDetailItemView(title: "25세", content: "나이")
                        }
                    )
                
                // 설정과 개인정보 항목
                VStack(alignment: .leading, spacing: 20) {
                    Text("운동")
                        .font(.headline)
                        .padding(.horizontal)
                    ListSettingsItem(title: "러닝기록")
                    Divider()
                    
                    Text("서비스")
                        .font(.headline)
                        .padding(.horizontal)
                    ListSettingsItem(title: "이용약관")
                    ListSettingsItem(title: "오픈소스/라이센스")
                    Divider()
                    
                    Text("고객지원")
                        .font(.headline)
                        .padding(.horizontal)
                    NavigationLink(destination: FAQView(), isActive: $isFAQActive) {
                        ListSettingsItem(title: "자주묻는 질문 Q&A")
                            .onTapGesture {
                                isFAQActive = true
                            }
                    }
                    NavigationLink(destination: AskView(), isActive: $isAskActive) {
                        ListSettingsItem(title: "문의하기")
                            .onTapGesture {
                                isAskActive = true
                            }
                    }
                    Divider()
                    
                    Text("우리팀을 응원하기")
                        .font(.headline)
                        .padding(.horizontal)
                    ListSettingsItem(title: "프리미엄 결제하기")
                    
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .navigationBarHidden(true)
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
                .frame(width: 50, height: 50)
                .padding(.trailing, 8)
            
            // 이름
            VStack(alignment: .leading, spacing: 4) {
                Text("이름")
                    .font(.headline)
            }
            
            Spacer()
            
            // 프로필 변경 버튼
            NavigationLink(destination: MyProfileChangeView()) {
                Text("프로필 변경>")
                    .foregroundColor(.blue)
                    .font(.subheadline)
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
                .foregroundColor(.blue)
            Text(content)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct ListSettingsItem: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            
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
