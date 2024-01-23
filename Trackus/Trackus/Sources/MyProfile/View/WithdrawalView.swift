//
//  WithdrawalView.swift
//  Trackus
//
//  Created by 박소희 on 1/22/24.
//
import SwiftUI

struct WithdrawalView: View {
    @StateObject private var viewModel = WithdrawalViewModel()

    var body: some View {
        TUCanvas.CustomCanvasView(style: .background) {
            VStack {

                VStack(alignment: .leading, spacing: Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING) {
                    MyTypography.bodytitle(text: "회원탈퇴 안내")
                    MyTypography.profilebody(text: "회원 탈퇴시 아래 사항을 꼭 확인해 주세요.")

                    VStack(alignment: .leading, spacing: Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING) {
                        MyTypography.body(text: "1.개인 정보 및 이용 기록은 모두 삭제되며, 삭제된 계정은 복구할 수 없습니다.")
                        MyTypography.body(text: "2.프리미엄 결제 기록의 남은 기간 금액은 환불되지 않습니다.")
                        MyTypography.body(text: "3.러닝 데이터를 포함한 모든 운동에 관련된 정보는 따로 저장되지 않으며 즉시 삭제 됩니다.")
                    }

                    MyTypography.bodytitle(text: "회원탈퇴 사유")
                    TextEditor(text: $viewModel.text)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .foregroundColor(TUColor.border)
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.ViewLayoutConst.VIEW_STANDARD_CORNER_RADIUS)
                                .stroke(Color.gray, lineWidth: 2)
                        )

                    HStack {
                        MyTypography.bodytitle(text: "안내 사항 확인 후 탈퇴에 동의합니다.")
                        Spacer()
                        Image(systemName: viewModel.isAgreed ? "largecircle.fill.circle" : "circle")
                            .resizable()
                            .frame(width: Constants.ViewLayoutConst.VIEW_STANDARD_CORNER_RADIUS, height: Constants.ViewLayoutConst.VIEW_STANDARD_CORNER_RADIUS)
                            .foregroundColor(TUColor.main)
                            .onTapGesture {
                                viewModel.toggleAgreement()                            }
                    }

                    TUButton(buttonText: "회원탈퇴") {
                        viewModel.initiateWithdrawal()
                    }
                    .foregroundColor(TUColor.border)
                    .padding(.horizontal)
                    .alert(isPresented: $viewModel.showWithdrawalAlert) {
                        Alert(
                            title: Text("알림"),
                            message: Text("정말 탈퇴를 진행하시겠습니까? 울 서비스의 모든 데이터가 삭제됩니다."),
                            primaryButton: .cancel(),
                            secondaryButton: .destructive(Text("ok"), action: {
                                // 회원 탈퇴 동작 추가하기
                                viewModel.confirmWithdrawal()
                            })
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                Spacer()
            }
            .navigationTitle("회원탈퇴")
            .foregroundColor(TUColor.main)
            .background(TUColor.background)
            .navigationBarHidden(true)
        
            
        }
    }
}

#Preview {
    WithdrawalView()
}
