//
//  ReportView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct ReportView: View {
    @State var selectedAge = AvgAge.twenties // 사용자의 나이대
    
    var body: some View {
        
        TUCanvas.CustomCanvasView(style: .background) {
                ScrollView {
                    VStack (alignment: .leading){
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
                        TodayDistanceView()
                            .padding(.bottom)
                        
                            TabView {
                                MonthDistanceView(selectedAge: $selectedAge)
                                StatsTabbedView(selectedAge: $selectedAge)
                            }
                            .frame(height: 450)
                            .tabViewStyle(.page(indexDisplayMode: .always))
                        
                        Divider()
                        
                    }
                    .padding(.horizontal, 20)
                }
        }
    }
}

#Preview {
    ReportView()
}
