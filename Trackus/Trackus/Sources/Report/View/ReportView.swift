//
//  ReportView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct ReportView: View {
    
    private var before = "30%"
    private var peer = "20%"
    private let items : [String] = ["1","2"]
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    MyTypography.title(text: "리포트")
                    MyTypography.body(text: "기간별 운동량, 칼로리, 통계")
                }
                .padding()
                
                VStack(alignment: .leading) {
                    MyTypography.subtitle(text: "오늘은")
                    HStack {
                        MyTypography.subtitle(text: "어제보다")
                        Text(before)
                            .font(Font.system(size: 20, weight: .semibold))
                            .foregroundColor(.green)
                        MyTypography.subtitle(text: "더 빨리 달렸습니다.")
                    }
                    HStack {
                        MyTypography.subtitle(text: "또래보다")
                        Text(peer)
                            .font(Font.system(size: 20, weight: .semibold))
                            .foregroundColor(.red)
                        MyTypography.subtitle(text: "더 천천히 달렸습니다.")
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    MyTypography.body(text: "기간별 운동 정보")
                    
                }
            }
        }
        .frame(width: 1000,height: 1000)
        .background(.black)
    }
}

#Preview {
    ReportView()
}
