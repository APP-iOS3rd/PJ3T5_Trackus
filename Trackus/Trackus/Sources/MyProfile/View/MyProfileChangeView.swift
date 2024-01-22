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
        TUCanvas.CustomCanvasView(style: .background) {
            NavigationView {
                VStack {
                    // NavigationBarItems를 사용하여 좌측에 뒤로가기 버튼 및 타이틀 추가
                    HStack {
                        NavigationLink(destination: MyProfileView()) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20))
                                .foregroundColor(TUColor.main)
                                .padding()
                        }

                        Spacer()

                        // 가운데에 "프로필 변경" 텍스트
                        MyTypography.subtitle(text: "프로필 변경")
                        Spacer()
                    }
                    .background(TUColor.background)
                    .navigationBarItems(leading: EmptyView(), trailing: EmptyView())
                    VStack {
                        Image("userface")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)

                        VStack(alignment: .leading, spacing: Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING) {
                            MyTypography.bodytitle(text: "닉네임")
                            TUTextField(placeholder: "닉네임", text: $username)
                                .padding(.bottom, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                                .padding(.trailing, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)

                            Divider()
                                .background(TUColor.border)

                            MyTypography.bodytitle(text: "신체정보")

                            HStack {
                                            MyTypography.profilebody(text: "신장")

                                            Spacer()

                                            Picker(selection: $height, label: Text("")) {
                                                ForEach(100..<200) {
                                                    Text("\($0) cm")
                                                }
                                            }
                                            .pickerStyle(DefaultPickerStyle())
                                        }

                                        HStack {
                                            MyTypography.profilebody(text: "체중")

                                            Spacer()

                                            Picker(selection: $weight, label: Text("")) {
                                                ForEach(30..<200) {
                                                    Text("\($0) kg")
                                                }
                                            }
                                            .pickerStyle(DefaultPickerStyle())
                                        }

                                        Divider()
                                            .background(TUColor.border)

                                        MyTypography.bodytitle(text: "운동정보")

                                        HStack {
                                            MyTypography.profilebody(text: "러닝 스타일")

                                            Spacer()

                                            StepperRotation(value: $runningStyleIndex, options: runningStyles)
                                        }

                                        HStack {
                                            MyTypography.profilebody(text: "일일목표")

                                            Spacer()

                                            Picker(selection: $setDailyGoal, label: Text("")) {
                                                ForEach(1..<100) {
                                                    Text("\($0) km")
                                                }
                                            }
                                            .pickerStyle(DefaultPickerStyle())
                                        }

                                        Divider()
                                            .background(TUColor.border)

                            MyTypography.bodytitle(text: "사용자 관련")

                            Toggle("프로필 공개 여부", isOn: $isProfilePublic)
                                .toggleStyle(SwitchToggleStyle(tint: TUColor.main))
                                .font(Font.system(size: 15, weight: .regular))
                                .foregroundColor(TUColor.main)
                        }
                        .background(TUColor.background)
                        .padding(.horizontal, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                        .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)

                        // 수정완료 버튼 추가
                        TUButton(buttonText: "수정완료") {
                            // 나중에 동작 추가하기
                        }
                        .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                    }

                    Spacer()
                }
                .navigationBarHidden(true)
                .background(TUColor.background)
            }
            .background(TUColor.background)
        }
    }
}

struct StepperRotation: View {
    @Binding var value: Int
    var options: [String]

    var body: some View {
        HStack(spacing: 0) {
            Picker(selection: $value, label: Text("")) {
                ForEach(0..<options.count) {
                    Text(options[$0])
                }
            }
            .pickerStyle(DefaultPickerStyle())
            .foregroundColor(TUColor.main)
            
        }
    }
}


#Preview {
    MyProfileChangeView()
}
