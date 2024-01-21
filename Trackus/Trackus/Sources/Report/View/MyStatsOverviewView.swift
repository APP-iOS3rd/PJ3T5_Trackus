//
//  ChartUP.swift
//  ChartPrac
//
//  Created by 박선구 on 1/21/24.
//

import SwiftUI

// 나의 월별 운동량 정보를 그래프로 보여주는 뷰

struct MyStatsOverviewView: View {
    @State var avgWeakData : Double = 10 // 평균 값
    @State var selectedBarIndex: Int? = nil
    @State var selectedData: WeakModel? = nil
    
    let maxHeight: CGFloat = 100 // 최대 그래프 높이
    let limitValue: Double = 20.0 // 높이 한계 값
    
    var body: some View {
        ZStack {
            TUColor.box.edgesIgnoringSafeArea(.all) // 뷰의 전체 배경색
            
            VStack {
                    VStack {
                            HStack (spacing: 2) {
                                ForEach(monthData2, id: \.id) { data in
                                    
                                    ChartUpBarView(value: calculateBarHeight(data.weight), day: data.day, isSelected: selectedBarIndex == monthData2.firstIndex(of: data), selectedData: data)
                                        .onTapGesture {
                                            selectedBarIndex = selectedBarIndex == monthData2.firstIndex(of: data) ? nil : monthData2.firstIndex(of: data)
                                            selectedData = selectedBarIndex == nil ? nil : data
                                        }
                                        .foregroundColor(selectedBarIndex == monthData2.firstIndex(of: data) ? TUColor.main : .gray)
                                }
                            }
                            .padding(.top, 24)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            Text("운동시간")
                                .fontWeight(.semibold)
                            Text("00:00:32") // 한달 평균 운동 시간
                                .foregroundColor(TUColor.main)
                                .bold()
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("칼로리 소모")
                                .fontWeight(.semibold)
                            Text("0 Kcal") // 한달 평균 소모 칼로리
                                .foregroundColor(TUColor.main)
                                .bold()
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            
                            
                            Text("주행거리")
                                .fontWeight(.semibold)
                            Text("\(String(format: "%0.1f km", selectedData?.weight ?? 0.0))") // 한달 평균 주행거리
                                .foregroundColor(TUColor.main)
                                .bold()
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("평균속도")
                                .fontWeight(.semibold)
                            Text("40.2 km/h") // 한달 평균 러닝속도
                                .foregroundColor(TUColor.main)
                                .bold()
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .frame(height: 176)
                .background(TUColor.subBox)
                .cornerRadius(14)
            }
            .frame(height: 472)
            .border(Color.black)
        }
    }
    
    // 그래프의 높이를 계산 후, 한계값을 넘지 않게 제한하는 함수
    func calculateBarHeight(_ weight: Double) -> Double {
        let normalizedHeight = (weight / limitValue) * Double(maxHeight)
        
        guard !monthData2.isEmpty else {
            return normalizedHeight
        }
        
        let maxNormalizedHeight = monthData2.map { $0.weight / limitValue * Double(maxHeight) }.max() ?? 0
        let scaleFactor = maxNormalizedHeight > Double(maxHeight) ? Double(maxHeight) / maxNormalizedHeight : 1.0
        return min(normalizedHeight * scaleFactor, Double(maxHeight))
    }
}

struct ChartUpBarView: View {
    var value : Double
    var day: String?
    var isSelected : Bool
    
    var selectedData: WeakModel?
    
    @State private var barHeight: CGFloat = 0
    @State private var firstTime: Bool = false
    
    var body: some View {
            
            VStack {
                
                ZStack(alignment: .bottom){
                    Capsule()
                        .frame(minWidth: 25, maxWidth: 30, minHeight: 100, maxHeight: 100)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                    Capsule()
                        .frame(minWidth: 25, maxWidth: 30, minHeight: CGFloat(barHeight), maxHeight: CGFloat(barHeight))
                    
                    if isSelected {
                        Text("\(String(format: "%0.1f", selectedData?.weight ?? 0))")
                            .fontWeight(.bold)
                            .foregroundColor(TUColor.main)
                            .font(.caption2)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .offset(y: -CGFloat(value) - 10)
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

// 한달 동안 러닝의 평균
var monthData2: [WeakModel] = [
    WeakModel(day: "Jan", weight: 12.5),
    WeakModel(day: "Feb", weight: 17.2),
    WeakModel(day: "Mar", weight: 20),
    WeakModel(day: "Apr", weight: 15.5),
    WeakModel(day: "May", weight: 11.1),
    WeakModel(day: "Jun", weight: 7.5),
    WeakModel(day: "Jul", weight: 15.2),
    WeakModel(day: "Aug", weight: 12.0),
    WeakModel(day: "Sep", weight: 5.2),
    WeakModel(day: "Oct", weight: 5.9),
    WeakModel(day: "Nov", weight: 2.0),
    WeakModel(day: "Dec", weight: 0.0)
]

#Preview {
    MyStatsOverviewView()
}
