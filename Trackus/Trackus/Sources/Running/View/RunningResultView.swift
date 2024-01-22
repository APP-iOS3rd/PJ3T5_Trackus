//
//  RunningResultView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/21.
//

import SwiftUI

struct RunningResultView: View {
    @State private var showCountView = false
    var body: some View {
        TUCanvas.CustomCanvasView {
            VStack {
                HStack {
                    Text("운동 결과")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .horizontalStandardPadding()
                    
                    Spacer()
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0 + 20)
                
                Divider()
                    .background(Color.white)
                
                Spacer()
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("운동량")
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding()
                        TUCanvas.CustomCanvasView(style: .content) {
                            VStack {
                                HStack {
                                    Image("kilometer")
                                    Text("킬로미터")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                        .horizontalStandardPadding()
                                    Spacer()
                                    Text("4.3 km")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                }
                                .verticalStandardPadding()
                                HStack {
                                    Image("calorie")
                                    Text("칼로리 소모")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                        .horizontalStandardPadding()
                                    Spacer()
                                    Text("326 kcal")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                }
                                .verticalStandardPadding()

                                HStack {
                                    Image("time")
                                    Text("러닝 타임")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                        .horizontalStandardPadding()
                                    Spacer()
                                    Text("4.3km")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                }
                                .verticalStandardPadding()
                            }
                        }
                        .horizontalStandardPadding()
                        
                        Divider()
                            .frame(height: 8)
                            .background(TUColor.box)
                            .padding(.top)
                        
                        Text("결과 비교")
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding()
                        TUCanvas.CustomCanvasView(style: .content) {
                            VStack {
                                HStack {
                                    Image("kilometer")
                                    Text("킬로미터")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                        .horizontalStandardPadding()
                                    Spacer()
                                    Text("목표보다 1.3 km 더 뛰었어요!")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                }
                                .verticalStandardPadding()
                                HStack {
                                    Image("calorie")
                                    Text("칼로리 소모")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                        .horizontalStandardPadding()
                                    Spacer()
                                    Text("99 kcal를 더 소모했어요!")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                }
                                .verticalStandardPadding()

                                HStack {
                                    Image("time")
                                    Text("러닝 타임")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                        .horizontalStandardPadding()
                                    Spacer()
                                    Text("예상 시간보다 00:32 단축 되었어요!")
                                        .font(.body)
                                        .foregroundStyle(Color.white)
                                }
                                .verticalStandardPadding()
                            }
                        }
                        .horizontalStandardPadding()
                        
                        Divider()
                            .frame(height: 8)
                            .background(TUColor.box)
                            .padding(.top)
                        
                        Text("피드백")
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding()
                        TUCanvas.CustomCanvasView(style: .content) {
                            Text("예상 시간보다 빠르게 목표에 도달했어요. 기록 단축이 목표가 아니라면 페이스를 조금 더 느슨하게 가져가보면 어떨까요?")
                                .foregroundStyle(Color.white)
                                .font(.body)
                        }
                        .horizontalStandardPadding()
                        
                        NavigationLink(destination: ReportView()) {
                            Text("리포트로 이동하기")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .standardPadding()
                    }
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    RunningResultView()
}
