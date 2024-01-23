//
//  FAQView.swift
//  Trackus
//
//  Created by 박소희 on 1/22/24.
//

import SwiftUI

struct FAQView: View {
    @StateObject private var viewModel = FAQViewModel()
    
    var body: some View {
        TUCanvas.CustomCanvasView(style: .background) {
            VStack {
                // 질문 및 답변 목록
                List {
                    ForEach(0..<FAQData.questions.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                MyTypography.bodytitle(text: "Q. \(FAQData.questions[index])")
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: viewModel.selectedQuestionIndex == index ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(TUColor.main)
                            }
                            
                            if viewModel.selectedQuestionIndex == index {
                                MyTypography.body(text: "A. \(FAQData.answers[index])")
                                    .padding(.leading, 20)
                                    .padding(.top, 20)
                            }
                            Spacer()
                            Divider()
                                .background(TUColor.border)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // 질문에 대한 답변 숨김 여부
                            viewModel.toggleQuestion(index: index)
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("자주묻는 질문 Q&A")
            .foregroundColor(TUColor.main)
            .background(TUColor.background)
        }
    }
}



struct FAQData {
    static let questions = [
        "결제시 취소는 어디에서 해야하나요?",
        "갤럭시 워치와도 연동이 되나요?",
        "불쾌한 유저 신고는 어디서 하나요?",
        "러닝 메이트와 뛴 기록도 데이터에 포함되나요?"
    ]

    static let answers = [
        "취소는 앱 내 결제 기록에서 가능합니다.",
        "아니요? 우리는 아마 애플워치만 할껄? 아님 말고",
        "유저 개인 프로필 클릭 후 신고 가능합니다.",
        "아이 그럼~~ 우린 다 제공해줘",
    ]
}

#Preview {
    FAQView()
}
