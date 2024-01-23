//
//  SwiftUIView.swift
//  Trackus
//
//  Created by 박선구 on 1/23/24.
//
import SwiftUI

// 주 평균 러닝속도 차트 뷰

struct DailyRunningStatsView: View {
    @State var avgWeakData : Double = 10 // 평균 값
    @State var selectedBarIndex: Int? = nil
    
//    let minFrameWidth: CGFloat = 315
    
    let maxHeight: CGFloat = 100 // 최대 그래프 높이
    let limitValue: Double = 20.0 // 높이 한계 값
    
    var body: some View {
            
            VStack {
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        HStack() {
                            
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(TUColor.main)
                            Text("박선구님")
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
                        HStack (spacing: 10) {
                            ForEach(weakData, id: \.id) { data in
                                
                                BarView(value: calculateBarHeight(data.weight), day: data.day, isSelected: selectedBarIndex == weakData.firstIndex(of: data), selectedData: data)
                                    .onTapGesture {
                                        selectedBarIndex = selectedBarIndex == weakData.firstIndex(of: data) ? nil : weakData.firstIndex(of: data)
                                    }
                                    .foregroundColor(selectedBarIndex == weakData.firstIndex(of: data) ? TUColor.main : TUColor.main.opacity(0.5))
                            }
                        }
                        .padding(.top)
                        
                        LineView(value: calculateBarHeight(avgWeakData))
                    }
                }
                .frame(height: 150) // 그래프 프레임
                
                VStack {
                    Text("박선구 님의 주간 러닝 속도 평균은 ") +  // 이름
                    Text("14.5 km/h").foregroundColor(TUColor.sub) + // 사용자 한 주의 평균 속도
                    Text("입니다. 20대 평균보다 ") + // 연령대
                    Text("2km/h").foregroundColor(TUColor.sub) + // 연령대 한 주 평균 속도, 사용자 평균 차이
                    Text(" 빨리 달리고 있으며 상위 ") + // 연령대 평균이 사용자 평균 보다 높으면 빨리, 느리게
                    Text("23%").foregroundColor(TUColor.sub) + // 상위 몇 퍼센트 인지 ?
                    Text(" 입니다.")
                    
                }
                .frame(minWidth: 250, maxWidth: 280)
                .padding(.horizontal)
                .font(.body)
                .frame(height: 103)
                .background(TUColor.subBox)
                .foregroundColor(TUColor.main)
                .cornerRadius(14)
                .padding(.bottom, 10)
            }
    }
    
    // 그래프의 높이를 계산 후, 한계값을 넘지 않게 제한하는 함수
    func calculateBarHeight(_ weight: Double) -> Double {
        let normalizedHeight = (weight / limitValue) * Double(maxHeight)
        
        guard !weakData.isEmpty else {
            return normalizedHeight
        }
        
        let maxNormalizedHeight = weakData.map { $0.weight / limitValue * Double(maxHeight) }.max() ?? 0
        let scaleFactor = maxNormalizedHeight > Double(maxHeight) ? Double(maxHeight) / maxNormalizedHeight : 1.0
        return min(normalizedHeight * scaleFactor, Double(maxHeight))
    }
}


struct BarView: View {
    var value : CGFloat
    var day: String?
    var isSelected : Bool
    
    var selectedData: WeakModel?
    
    @State private var barHeight: CGFloat = 0
    @State private var firstTime: Bool = false
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .bottom){
                Capsule().frame(width: 30, height: 100) // 그래프 높이
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                Capsule().frame(width: 30, height: barHeight)
                
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
        }
    }
}

struct LineView: View { // 평균 그래프
    
    var value : CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom){
                Rectangle()
                    .frame(height: 100) // 그래프 높이
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

struct WeakModel: Identifiable, Equatable {
    var id = UUID().uuidString
    var day: String
    var weight: Double
}

var weakData: [WeakModel] = [
    WeakModel(day: "Sun", weight: 12.5),
    WeakModel(day: "Mon", weight: 17.2),
    WeakModel(day: "Tue", weight: 24.0),
    WeakModel(day: "Wed", weight: 15.5),
    WeakModel(day: "Thu", weight: 11.1),
    WeakModel(day: "Fri", weight: 7.5),
    WeakModel(day: "Sat", weight: 10.0)
]

#Preview {
    DailyRunningStatsView()
}
