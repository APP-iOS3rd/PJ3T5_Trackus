//
//  FAQView.swift
//  Trackus
//
//  Created by 박소희 on 1/22/24.
//

import SwiftUI

struct FAQView: View {
    @State private var selectedQuestionIndex: Int?

    var body: some View {
        NavigationView {
            VStack {
                // 뒤로가기 버튼과 제목
                HStack {
                    NavigationLink(destination: MyProfileView()) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .padding()
                    }
                    Spacer()

                    Text("자주묻는 질문 Q&A")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                }
                .foregroundColor(TUColor.main)
                .background(TUColor.background)
                
                // 질문 및 답변 목록
                List {
                    ForEach(0..<FAQData.questions.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("Q. \(FAQData.questions[index])")
                                    .foregroundColor(TUColor.main)
                                    .font(.headline)
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: selectedQuestionIndex == index ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(TUColor.main)
                            }
                            if selectedQuestionIndex == index {
                                Text("A. \(FAQData.answers[index])")
                                    .foregroundColor(TUColor.border)
                                    .font(.subheadline)
                                    .padding(.leading, 20)
                                    .padding(.top, 20)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // 질문에 대한 답변 숨김 여부
                            selectedQuestionIndex = selectedQuestionIndex == index ? nil : index
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .foregroundColor(TUColor.main)
            .background(TUColor.background)
            .navigationBarHidden(true)
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
