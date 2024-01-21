//
//  chartYouTube3.swift
//  ChartPrac
//
//  Created by 박선구 on 1/20/24.
//

import SwiftUI

// 연 평균 러닝 속도 차트 뷰

struct YearRunningStatsView: View {
    @State var avgWeakData : Double = 10 // 평균 값
    @State var selectedBarIndex: Int? = nil
    
    let maxHeight: CGFloat = 100 // 최대 그래프 높이
    let limitValue: Double = 20.0 // 높이 한계 값
    
    var body: some View {
        ZStack {
            TUColor.box.edgesIgnoringSafeArea(.all) // 뷰의 전체 배경색
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        HStack() {
                            
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(TUColor.main)
                            Text("박선구님") // 사용자 이름
                                .font(.footnote)
                        }
                        
                        HStack {
                            
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(TUColor.sub)
                            Text("평균 속력 (\(String(format: "%.1f", avgWeakData)) km/h)")
                                .font(.footnote)
                        }
                    }
                    .foregroundColor(TUColor.main)
                    .padding(.vertical)
                }
                
                ScrollView(.horizontal) {
                    ZStack {
                        HStack (spacing: 10) {
                            ForEach(yearData, id: \.id) { data in
                                YearBarView(value: calculateBarHeight(data.weight), day: data.day, isSelected: selectedBarIndex == yearData.firstIndex(of: data), selectedData: data)
                                        .onTapGesture {
                                            selectedBarIndex = selectedBarIndex == yearData.firstIndex(of: data) ? nil : yearData.firstIndex(of: data)
                                        }
                                        .foregroundColor(selectedBarIndex == yearData.firstIndex(of: data) ? TUColor.main : .gray)
                                }
                        }
                        .padding(.top, 24)
//                        }
                        
                        YearLineView(value: calculateBarHeight(avgWeakData))
                    }
                }
                .frame(height: 150) // 그래프 프레임
                
                VStack {
                    Text("박선구 님의 2024년 러닝 속도 평균은 ") + // 이름, 현재의 연도
                    Text("12.25 km/h").foregroundColor(TUColor.sub) + // 현재의 연도의 속도 평균
                    Text("입니다. 20대 평균보다 ") + // 선택한 연령대
                    Text("0.25km/h").foregroundColor(TUColor.sub) + // 선택한 연령대 년도별 속도 평균 과 사용자 년도별 속도 평균 차이
                    Text(" 빠르게 달리고 있으며 상위 ") + // 사용자가 높으면 '빠르게' 낮은면 '느리게'
                    Text("23%").foregroundColor(TUColor.sub) + // 상위 몇 퍼센트인지
                    Text(" 입니다.")
                }
                .padding(.horizontal)
                .font(.body)
//                .fontWeight(.bold)
                .frame(height: 103)
                .background(TUColor.subBox)
                .foregroundColor(TUColor.main)
                .cornerRadius(14)
                .padding(.top, 20)
            }
        }
    }
    
    func calculateBarHeight(_ weight: Double) -> Double {
        let normalizedHeight = (weight / limitValue) * Double(maxHeight)
        
        guard !yearData.isEmpty else {
            return normalizedHeight
        }
        
        let maxNormalizedHeight = yearData.map { $0.weight / limitValue * Double(maxHeight) }.max() ?? 0
        let scaleFactor = maxNormalizedHeight > Double(maxHeight) ? Double(maxHeight) / maxNormalizedHeight : 1.0
        return min(normalizedHeight * scaleFactor, Double(maxHeight))
    }
    
}

struct YearBarView: View {
    var value : CGFloat
    var day: String?
    var isSelected : Bool
    
    var selectedData: WeakModel?
    
    @State private var barHeight: CGFloat = 0
    @State private var firstTime: Bool = false
    
    var body: some View {
            
            VStack {
                
                ZStack(alignment: .bottom){
                    Capsule().frame(width: 25, height: 100)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                    Capsule().frame(width: 25, height: barHeight)
                    
                    if isSelected {
                        Text("\(String(format: "%0.1f", selectedData?.weight ?? 0))")
                            .foregroundColor(TUColor.main)
                            .font(.caption2)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .offset(y: -value - 10)
                    }
                    
                }
                .onAppear {
                    if !firstTime {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.barHeight = value
                        }
                        firstTime = true
                    }
                }
                
                Text(day ?? "Day")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
    }
}

struct YearLineView: View {
    
    var value : CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom){
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                VStack {
                    Rectangle().frame(width: 1000, height: 3)
                        .foregroundColor(TUColor.sub)
                    Spacer()
                }
                .frame(width: 350, height: value)
            }
        }
    }
}

var yearData: [WeakModel] = [
    WeakModel(day: "2023", weight: 12.5),
    WeakModel(day: "2024", weight: 17.2),
    WeakModel(day: "2025", weight: 21.0),
    WeakModel(day: "2026", weight: 15.5),
    WeakModel(day: "2027", weight: 11.1),
    WeakModel(day: "2028", weight: 7.5),
    WeakModel(day: "2029", weight: 15.2),
    WeakModel(day: "2030", weight: 4.1),
    WeakModel(day: "2031", weight: 5.2),
    WeakModel(day: "2032", weight: 5.9),
    WeakModel(day: "2033", weight: 10.0),
    WeakModel(day: "2034", weight: 13.1),
    WeakModel(day: "2035", weight: 13.1),
    WeakModel(day: "2036", weight: 13.1),
    WeakModel(day: "2037", weight: 13.1),
    WeakModel(day: "2038", weight: 13.1),
    WeakModel(day: "2039", weight: 13.1),
    WeakModel(day: "2041", weight: 13.1),
    WeakModel(day: "2042", weight: 13.1),
    WeakModel(day: "2043", weight: 13.1),
    WeakModel(day: "2044", weight: 13.1),
]

#Preview {
    YearRunningStatsView()
}
