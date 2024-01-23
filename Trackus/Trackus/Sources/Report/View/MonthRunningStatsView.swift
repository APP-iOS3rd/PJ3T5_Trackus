//
//  chartYouTube2.swift
//  ChartPrac
//
//  Created by 박선구 on 1/20/24.
//

import SwiftUI

// 월 평균 러닝속도 차트 뷰

struct MonthRunningStatsView: View {
    @State var avgWeakData : Double = 10 // 평균 값
    @State var selectedBarIndex: Int? = nil
    
//    let maxWidth: CGFloat = 400
    let minFrameWidth: CGFloat = 315
    
    let maxHeight: CGFloat = 100 // 최대 그래프 높이
    let limitValue: Double = 20.0 // 높이 한계 값
    
    var body: some View {
        //        GeometryReader { geometry in
//        ZStack (alignment: .top){
            //                TUColor.box.edgesIgnoringSafeArea(.all) // 뷰의 전체 배경색
            
            VStack {
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        HStack() {
                            
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(TUColor.main)
                            Text("박선구님") // 사용자 이름
                                .font(.caption2)
                        }
                        
                        HStack {
                            
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(TUColor.sub)
                            Text("평균 속력 (\(String(format: "%.1f", avgWeakData)) km/h)")
                                .font(.caption2)
                        }
                    }
                    .foregroundColor(TUColor.main)
                    .padding(.top)
                }
                
                VStack {
                    ZStack {
                        HStack (spacing: 2) {
                            ForEach(monthData, id: \.id) { data in
                                
                                MonthBarView(value: calculateBarHeight(data.weight), day: data.day, isSelected: selectedBarIndex == monthData.firstIndex(of: data), selectedData: data)
                                    .onTapGesture {
                                        selectedBarIndex = selectedBarIndex == monthData.firstIndex(of: data) ? nil : monthData.firstIndex(of: data)
                                    }
                                    .foregroundColor(selectedBarIndex == monthData.firstIndex(of: data) ? TUColor.main : TUColor.main.opacity(0.5))
                            }
                        }
                        .padding(.top)
                        
                        MonthLineView(value: calculateBarHeight(avgWeakData))
                        //                                .frame(minWidth: minFrameWidth)
                        //                                .frame(width: minFrameWidth)
                    }
                }
                .frame(height: 150) // 그래프 프레임
                //                    .frame(minWidth: minFrameWidth)
                //                    .frame(width: maxWidth)
                
                //                    ZStack {
                VStack {
                    Text("박선구 님의 5월 러닝 속도 평균은 ") + // 이름, 선택한 월의 속도 평균
                    Text("10.5 km/h").foregroundColor(TUColor.sub) + // 선택한 월의 속도 평균
                    Text("입니다. 20대 평균보다 ") + // 사용자가 선택한 연령대
                    Text("1.8km/h").foregroundColor(TUColor.sub) + // 사용자가 선택한 연령대 와 선택한 월의 평균 차이
                    Text(" 빨리 달리고 있으며 상위 ") + // 빠르게 달리고 있는지, 느리게 달리고 있는지
                    Text("23%").foregroundColor(TUColor.sub) + // 연령층의 상위 몇 퍼센트인지
                    Text(" 입니다.")
                }
                //                        .frame(width: 280)
                //                        .frame(maxWidth: 280, minWidth: 250)
                .frame(minWidth: 250, maxWidth: 280)
                .padding(.horizontal)
                .font(.body)
                .frame(height: 103)
                //                    .frame(minHeight: 103)
                .background(TUColor.subBox)
                .foregroundColor(TUColor.main)
                .cornerRadius(14)
//                .padding(.top, 20)
                .padding(.bottom, 10)
                //                    .frame(minWidth: minFrameWidth)
                //                    .frame(width: minFrameWidth)
            }
            //                    .frame(minWidth: 150, maxWidth: 300)
            //                }
            //                .frame(height: 300)
            //            }
//        }
    }
//    }
    
    func calculateBarHeight(_ weight: Double) -> Double { // ViewModel 로 빼기
        let normalizedHeight = (weight / limitValue) * Double(maxHeight)
        
        guard !monthData.isEmpty else {
            return normalizedHeight
        }
        
        let maxNormalizedHeight = monthData.map { $0.weight / limitValue * Double(maxHeight) }.max() ?? 0
        let scaleFactor = maxNormalizedHeight > Double(maxHeight) ? Double(maxHeight) / maxNormalizedHeight : 1.0
        return min(normalizedHeight * scaleFactor, Double(maxHeight))
    }
}

struct MonthBarView: View {
    var value : CGFloat
    var day: String?
    var isSelected : Bool
    
    var selectedData: WeakModel?
    
    @State private var barHeight: CGFloat = 0
    @State private var firstTime: Bool = false
    
    var body: some View {
            
            VStack {
                
                ZStack(alignment: .bottom){
                    Capsule()
                        .frame(minWidth: 21, minHeight: 100, maxHeight: 100)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                    Capsule()
                        .frame(minWidth: 21, minHeight: barHeight, maxHeight: barHeight)
                    
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
                    .font(.caption2)
            }
    }
}

struct MonthLineView: View {
    
    var value : CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom){
                Rectangle()
                    .frame(height: 100)
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                VStack {
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(TUColor.sub)
                    Spacer()
                }
                .frame(height: value)
            }
        }
    }
}

var monthData: [WeakModel] = [
    WeakModel(day: "Jan", weight: 12.5),
    WeakModel(day: "Feb", weight: 17.2),
    WeakModel(day: "Mar", weight: 24),
    WeakModel(day: "Apr", weight: 15.5),
    WeakModel(day: "May", weight: 14),
    WeakModel(day: "Jun", weight: 7.5),
    WeakModel(day: "Jul", weight: 15.2),
    WeakModel(day: "Aug", weight: 4.1),
    WeakModel(day: "Sep", weight: 5.2),
    WeakModel(day: "Oct", weight: 5.9),
    WeakModel(day: "Nov", weight: 10.0),
    WeakModel(day: "Dec", weight: 13.1)
]

#Preview {
    MonthRunningStatsView()
}
