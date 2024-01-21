//
//  ReportTab.swift
//  ChartPrac
//
//  Created by 박선구 on 1/20/24.
//

import SwiftUI

// 연령대 별 평균 운동량과 러닝속도 차트를 제공하는 Tab 뷰

struct AgeStatsTabbedView: View {
    var body: some View {
        TUCanvas.CustomCanvasView(style: .content) {
            VStack {
                TabView {
                    MonthDistanceView()
                    StatsTabbedView()
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 500)
            }
//            .padding()
            .background(TUColor.box)
//            .cornerRadius(14)
        }
//        VStack {
//            TabView {
//                MonthDistanceView()
//                StatsTabbedView()
//            }
//            .tabViewStyle(.page(indexDisplayMode: .always))
//            .frame(height: 500)
//        }
//        .padding()
//        .background(TUColor.box)
//        .cornerRadius(14)
    }
}

#Preview {
    AgeStatsTabbedView()
}
