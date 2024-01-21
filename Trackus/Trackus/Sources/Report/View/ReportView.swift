//
//  ReportView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct ReportView: View {
    @State private var selectedButton: ButtonType?
    @State private var progress: CGFloat = 0.5
    private var day = "01.17"
    private var momentum = "33.2"

        enum ButtonType {
            case daily
            case monthly
        }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    VStack(alignment: .leading) {
                        MyTypography.title(text: "리포트")
                        MyTypography.body(text: "기간별 운동량, 칼로리, 통계")
                    }
                    .padding()
                    Divider()
                        .frame(width: 250)
                        .background(.white)
                    
                    VStack(alignment: .leading) {
                        MyTypography.subtitle(text: "상세한 러닝 리포트")
                        MyTypography.body(text: "TrackUs Pro 회원은 상세한 러닝 리 포트를 제공받고 효율적인 러닝이 가능 합니다.")
                            .frame(width: 250)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        MyTypography.subtitle(text: "기간별 운동 정보")
                            .padding()
                        MyTypography.body(text: "러닝 데이터를 기반으로 통계를 확인합니다.")
                            .frame(width: 300)
                    }
                    HStack {
                            Button(action: {
                                selectedButton = .daily
                            }) {
                                Text("일")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(selectedButton == .daily ? Color.gray : Color.yellow)
                                    .cornerRadius(10)
                            }
                            .padding()

                            Button(action: {
                                selectedButton = .monthly
                            }) {
                                Text("월")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(selectedButton == .monthly ? Color.gray : Color.yellow)
                                    .cornerRadius(10)
                                
                            }
                            .padding()

                            if selectedButton == .daily {
                                DailyGoalView(goal: "일일 목표")
                            } else if selectedButton == .monthly {
                                MonthlyGoalView(goal: "월별 목표")
                            }
                        }
                    
                    
                    VStack {
                        CircularProgressView(progress: progress)
                            .frame(width: 150, height: 150)
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .offset(y: -105)

                                Text("3.2km")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .offset(y: -50)

                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        MyTypography.subtitle(text: "연령대 추세")
                        MyTypography.body(text: "비슷한 연령대의 운동 정보를 비교합니다.")
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        MyTypography.bodytitle(text: "\(day)의 운동량은")
                        MyTypography.body(text: "동일 연령대의 TrackUs 회원 중 상위 \(momentum)% (운동량 기준)")
                        BarGraphView(data1: 0.7, data2: 0.5)
                            .padding(.top, 50)
                    }
                }
            }
        }
        .frame(width: 1000,height: 800)
        .background(.black)
    }
}

struct DailyGoalView: View {
    var goal: String

    var body: some View {
        VStack {
            Text("일별 목표 화면")
                .font(.headline)
                .padding()
            Text(goal)
                .font(.title)
                .padding()
        }
    }
}

struct MonthlyGoalView: View {
    var goal: String

    var body: some View {
        VStack {
            Text("월별 목표 화면")
                .font(.headline)
                .padding()
            Text(goal)
                .font(.title)
                .padding()
        }
    }
}

struct CircularProgressView: View {
    var progress: CGFloat

    var body: some View {
        ZStack {
            // 원형 트랙
            Circle()
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 10.0, lineCap: .round))
                .opacity(0.3)

            // 원형 그래프
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 10.0, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
    }
}

struct BarGraphView: View {
    let data1: CGFloat
    let data2: CGFloat
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Spacer(minLength: 0)
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 30, height: data1 * 150)
                Text("\(Int(data1))")
                    .padding(.top, 5)
            }
            
            VStack {
                Spacer(minLength: 0)
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 30, height: data2 * 90)
                Text("\(Int(data2))")
                    .padding(.top, 5)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ReportView()
}
