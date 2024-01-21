//
//  MyProfileChangeView.swift
//  Trackus
//
//  Created by 박소희 on 1/21/24.
//

import SwiftUI

struct MyProfileChangeView: View {
    @State private var username: String = ""
    @State private var height: Int = 170
    @State private var weight: Int = 65
    @State private var runningStyleIndex: Int = 0
    @State private var setDailyGoal: Int = 10
    @State private var isProfilePublic: Bool = true

    var runningStyles = ["가벼운 러닝", "무거운 러닝", "전문 러닝"]


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

                    // 가운데에 "프로필 변경" 텍스트
                    Text("프로필 변경")
                        .font(.headline)
                        .foregroundColor(TUColor.main)

                    Spacer()
                }
                .padding()
                .background(TUColor.background)

                VStack {
                    Image("userface")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(TUColor.main, lineWidth: 2))
                        .padding(.top, 20)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("닉네임")
                            .font(.headline)
                            .foregroundColor(TUColor.main)
                        TUTextField(placeholder: "닉네임", text: $username)
                        Divider()
                            .background(TUColor.border)

                        Text("신체정보")
                            .font(.headline)
                            .foregroundColor(TUColor.main)

                        // 신장
                        HStack {
                            Text("신장")
                                .font(.headline)
                                .foregroundColor(TUColor.main)
                                .frame(width: 80)

                            Spacer()

                            StepperUpDown(value: $height, unitLabel: "cm")
                                .frame(width: 100, height: 40)
                        }

                        // 체중
                        HStack {
                            Text("체중")
                                .font(.headline)
                                .foregroundColor(TUColor.main)
                                .frame(width: 80)

                            Spacer()

                            StepperUpDown(value: $weight, unitLabel: "kg")
                                .frame(width: 100, height: 40)
                        }
                        Divider()
                            .background(TUColor.border)

                        Text("운동정보")
                            .font(.headline)
                            .foregroundColor(TUColor.main)
                        // 러닝 스타일 선택
                        HStack {
                            Text("러닝 스타일")
                                .font(.headline)
                                .foregroundColor(TUColor.main)
                                .frame(width: 80)

                            Spacer()

                            StepperRotation(value: $runningStyleIndex, options: runningStyles)
                                .frame(width: 100, height: 40)
                        }

                        // 일일목표
                        HStack {
                            Text("신장")
                                .font(.headline)
                                .foregroundColor(TUColor.main)
                                .frame(width: 80)

                            Spacer()

                            StepperUpDown(value: $setDailyGoal, unitLabel: "km")
                                .frame(width: 100, height: 40)
                        }

                        Divider()
                            .background(TUColor.border)

                        Text("사용자 관련")
                            .font(.headline)
                            .foregroundColor(TUColor.main)
                        Toggle("프로필 공개 여부", isOn: $isProfilePublic)
                            .toggleStyle(SwitchToggleStyle(tint: TUColor.main))
                            .foregroundColor(TUColor.main)
                    }
                    .background(TUColor.background)
                    .padding(.top, 20)
                    // 수정완료 버튼 추가
                    TUButton(buttonText: "수정완료") {
                        // 나중에 동작 추가하기
                    }
                    .padding(.top, 20)
                }

                Spacer()
            }
            .navigationBarHidden(true)
            .background(TUColor.background)
        }
        .background(TUColor.background)
    }
}

struct StepperUpDown: View {
    @Binding var value: Int
    var unitLabel: String

    var body: some View {
        HStack(spacing: 0) {
            Text("\(value)\(unitLabel)")
                .foregroundColor(TUColor.main)

            VStack(spacing: 0) {
                // 증가
                Button(action: {
                    value += 1
                }) {
                    Image(systemName: "chevron.up.circle.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(TUColor.main)
                }
                .padding(.bottom, 2)

                // 감소
                Button(action: {
                    value -= 1
                }) {
                    Image(systemName: "chevron.down.circle.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(TUColor.main)
                }
                .padding(.top, 2)
            }
            .padding(.leading, 4)
        }
    }
}

struct StepperRotation: View {
    @Binding var value: Int
    var options: [String]

    var body: some View {
        HStack(spacing: 0) {
            Text(options[value])
                .foregroundColor(TUColor.main)

            VStack(spacing: 0) {
                // 이전 스타일
                Button(action: {
                    self.value = (self.value - 1 + options.count) % options.count
                }) {
                    Image(systemName: "chevron.up.circle.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(TUColor.main)
                }
                .padding(.bottom, 2)

                // 다음 스타일
                Button(action: {
                    self.value = (self.value + 1) % options.count
                }) {
                    Image(systemName: "chevron.down.circle.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(TUColor.main)
                }
                .padding(.top, 2)
            }
            .padding(.leading, 4)
        }
    }
}


#Preview {
    MyProfileChangeView()
}
