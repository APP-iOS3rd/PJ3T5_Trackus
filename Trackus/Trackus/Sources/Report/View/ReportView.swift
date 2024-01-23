//
//  ReportView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct ReportView: View {
    @State private var selectedButton: ButtonType?
    @State var selectedAge = AvgAge.twenties // 사용자의 나이대
//    @State var dailyCircleTabHeight: CGFloat = 0
    private var day = "01.17"
    private var momentum = "33.2"

        enum ButtonType {
            case daily
            case monthly
        }
    
    var body: some View {
        
        TUCanvas.CustomCanvasView(style: .background) {
//            NavigationStack {
                ScrollView {
                    VStack (alignment: .leading){
//                        HStack (alignment: .bottom){
//                            Text("리포트")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//                                .foregroundStyle(TUColor.main)
//                            Text("기간별 운동량, 칼로리, 통계")
//                                .foregroundStyle(.gray)
//                                .padding(.bottom, 6)
//                                .font(.footnote)
//                        }
    //                    .border(Color.black)
                        
//                        Divider()
                        
                        VStack { // 러닝 리포트 클릭 시 프리미엄 결제 창으로 이동
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("상세한 러닝 리포트")
                                        .foregroundStyle(TUColor.main)
                                        .fontWeight(.bold)
                                        .padding(.bottom)
                                    
                                    Text("TrackUs Pro 회원은 상세한 러닝 리포트를 제공받고 효율적인 러닝이 가능합니다.")
                                        .padding(.trailing, 70)
                                        .foregroundStyle(.gray)
                                        .font(.footnote)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.gray)
                            }
                        }
                        .padding(.horizontal)
                        .frame(height: 142)
                        .background(TUColor.box)
                        .cornerRadius(14)
                        
                        Divider()
                        
                        VStack (alignment: .leading){
                            Text("기간별 운동 정보")
                                .font(.title2)
                                .foregroundStyle(TUColor.main)
                            Text("러닝 데이터를 기반으로 통계를 확인합니다.")
                                .foregroundStyle(.gray)
                                .font(.footnote)
                        }
                        .padding(.vertical)
                        
                        TUCanvas.CustomCanvasView(style: .content) {
                            DailyCircleTabView()
                                .frame(minWidth: 300, maxWidth: .infinity)
                        }
    //                        .frame(width: 350)
                        
                        Divider()
                        
                        VStack (alignment: .leading){
                            Text("연령대 추세")
                                .font(.title2)
                                .foregroundStyle(TUColor.main)
                            Text("비슷한 연령대의 운동 정보를 비교합니다.")
                                .foregroundStyle(.gray)
                                .font(.footnote)
                        }
                        .padding(.vertical)
                        
                        // 오늘 운동량
                        // 박스가 들어가야 함
                        TodayDistanceView()
                            .padding(.bottom)
                        
//                        AgeStatsTabbedView()
//                        TUCanvas.CustomCanvasView(style: .content) {
                            TabView {
                                MonthDistanceView(selectedAge: $selectedAge)
//                                    .border(Color.red)
                                StatsTabbedView(selectedAge: $selectedAge)
//                                    .border(Color.red)
                            }
                            .frame(height: 450)
                            .tabViewStyle(.page(indexDisplayMode: .always))
//                        }
                        
                        Divider()
                        
                    }
                    .padding(.horizontal, 20)
//                    .navigationTitle("리포트")
                }
//            }
//            .background(Color.indigo)
        }
//        TUCanvas.CustomCanvasView(style: .background) {
//            ScrollView {
//                    VStack {
//                        VStack(alignment: .leading) {
//                            MyTypography.title(text: "리포트")
//                            MyTypography.body(text: "기간별 운동량, 칼로리, 통계")
//                        }
//    //                    .padding()
//                        Divider()
//    //                        .frame(width: 250)
//                            .background(.white)
//                        
//                        VStack(alignment: .leading) {
//                            MyTypography.subtitle(text: "상세한 러닝 리포트")
//                            MyTypography.body(text: "TrackUs Pro 회원은 상세한 러닝 리 포트를 제공받고 효율적인 러닝이 가능 합니다.")
//    //                            .frame(width: 250)
//                        }
//    //                    .padding()
//                        
//                        VStack(alignment: .leading) {
//                            MyTypography.subtitle(text: "기간별 운동 정보")
//                                .padding()
//                            MyTypography.body(text: "러닝 데이터를 기반으로 통계를 확인합니다.")
//    //                            .frame(width: 300)
//                        }
//                        
//                        DailyCircleTabView()
//                        
//                        VStack(alignment: .leading, spacing: 10) {
//                            MyTypography.subtitle(text: "연령대 추세")
//                            MyTypography.body(text: "비슷한 연령대의 운동 정보를 비교합니다.")
//                        }
//                        .padding(.top, 50)
//                        
//                        VStack(alignment: .leading, spacing: 10) {
//                            MyTypography.bodytitle(text: "\(day)의 운동량은")
//                            MyTypography.body(text: "동일 연령대의 TrackUs 회원 중 상위 \(momentum)% (운동량 기준)")
//                            BarGraphView(data1: 0.7, data2: 0.5)
//                                .padding()
//                        }
//                        
//                        AgeStatsTabbedView()
//                    }
//            }
//            .padding(.horizontal, 20)
//        }
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
