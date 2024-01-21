//
//  WithdrawalView.swift
//  Trackus
//
//  Created by 박소희 on 1/22/24.
//
import SwiftUI

struct WithdrawalView: View {
    @State private var text: String = ""
    @State private var isAgreed: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
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
                .background(TUColor.background)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("회원탈퇴 안내")
                        .font(.headline)
                        .foregroundColor(TUColor.main)
                        .padding(.horizontal)
                    Text("회원 탈퇴시 아래 사항을  꼭 확인해 주세요.")
                        .foregroundColor(TUColor.sub)
                        .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("1.개인 정보 및 이용 기록은 모두 삭제되며, 삭제된 계정은 복구할 수 없습니다.")
                            .font(.headline)
                            .foregroundColor(TUColor.border)
                            .padding(.horizontal)
                        Text("2.프리미엄 결제 기록의 남은 기간 금액은 환불되지 않습니다.")
                            .font(.headline)
                            .foregroundColor(TUColor.border)
                            .padding(.horizontal)
                        Text("3.러닝 데이터를 포함한 모든 운동에 관련된 정보는 따로 저장되지 않으며 즉시 삭제 됩니다.")
                            .font(.headline)
                            .foregroundColor(TUColor.border)
                            .padding(.horizontal)
                    }
                    Text("회원탈퇴 사유")
                        .font(.headline)
                        .foregroundColor(TUColor.main)
                        .padding(.horizontal)
                    TextField("입력하세요", text: $text)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading) // 큰 크기로 조절
                    HStack {
                        
                        Text("안내 사항 확인 후 탈퇴에 동의합니다.")
                            .font(.headline)
                            .foregroundColor(TUColor.main)
                            .padding(.horizontal)
                        
                    }
                    TUButton(buttonText: "회원탈퇴") {
                        // 나중에 동작 추가하기
                    }
                    
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
    WithdrawalView()
}
