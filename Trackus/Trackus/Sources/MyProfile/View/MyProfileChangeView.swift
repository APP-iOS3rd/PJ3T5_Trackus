//
//  MyProfileChangeView.swift
//  Trackus
//
//  Created by 박소희 on 1/21/24.
//

import SwiftUI

struct MyProfileChangeView: View {
    @StateObject private var viewModel = MyProfileChangeViewModel()

    var runningStyles = ["가벼운 러닝", "무거운 러닝", "전문 러닝"]
    @State private var check: Bool = false

    var body: some View {
            TUCanvas.CustomCanvasView(style: .background) {
                ScrollView {
                    VStack {
                        Image("userface")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                        
                        VStack(alignment: .leading, spacing: Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING / 2) {
                            MyTypography.bodytitle(text: "닉네임")
                            TUTextField(placeholder: "닉네임", text: $viewModel.username, availability: $check)
                                .padding(.bottom, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                                .padding(.trailing, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                            
                            Divider()
                                .background(TUColor.border)
                            
                            MyTypography.bodytitle(text: "신체정보")
                            
                            HStack {
                                MyTypography.profilebody(text: "신장")
                                
                                Spacer()
                                
                                Picker(selection: $viewModel.height, label: Text("")) {
                                    ForEach(100..<200) {
                                        Text("\($0) cm")
                                            .foregroundColor(TUColor.main)
                                    }
                                }
                                .accentColor(TUColor.main)
                                .pickerStyle(DefaultPickerStyle())
                            }
                            
                            HStack {
                                MyTypography.profilebody(text: "체중")
                                
                                Spacer()
                                
                                Picker(selection: $viewModel.weight, label: Text("")) {
                                    ForEach(30..<200) {
                                        Text("\($0) kg")
                                            .foregroundColor(TUColor.main)
                                    }
                                }
                                .accentColor(TUColor.main)
                                .pickerStyle(DefaultPickerStyle())
                            }
                            
                            Divider()
                                .background(TUColor.border)
                            
                            MyTypography.bodytitle(text: "운동정보")
                            
                            HStack {
                                MyTypography.profilebody(text: "러닝 스타일")
                                
                                Spacer()
                                
                                StepperRotation(value: $viewModel.runningStyleIndex, options: runningStyles)
                            }
                            
                            HStack {
                                MyTypography.profilebody(text: "일일목표")
                                
                                Spacer()
                                
                                Picker(selection: $viewModel.setDailyGoal, label: Text("")) {
                                    ForEach(1..<100) {
                                        Text("\($0) km")
                                            .foregroundColor(TUColor.main)
                                    }
                                }
                                .accentColor(TUColor.main)
                                .pickerStyle(DefaultPickerStyle())
                            }
                            
                            Divider()
                                .background(TUColor.border)
                            
                            MyTypography.bodytitle(text: "사용자 관련")
                            
                            Toggle("프로필 공개 여부", isOn: $viewModel.isProfilePublic)
                                .toggleStyle(SwitchToggleStyle(tint: Color.green))
                                .font(Font.system(size: 15, weight: .regular))
                                .foregroundColor(TUColor.main)
                        }
                        .background(TUColor.background)
                        .padding(.horizontal, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING)
                        .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING / 2)
                        
                        // 수정완료 버튼 추가
                        TUButton(buttonText: "수정완료") {
                            // 나중에 동작 추가하기
                            viewModel.saveChanges()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(TUColor.main)
                        .cornerRadius(Constants.ViewLayoutConst.VIEW_STANDARD_CORNER_RADIUS)
                        .padding(.horizontal)
                        //.padding(.bottom, )
                        .padding(.top, Constants.ViewLayoutConst.VIEW_STANDARD_INNER_SPACING / 0.3)
                    }
                    .background(TUColor.background)
                }
                .navigationTitle("마이페이지")
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
            .accentColor(TUColor.main)
        }
    }
}

#Preview {
    MyProfileChangeView()
}
