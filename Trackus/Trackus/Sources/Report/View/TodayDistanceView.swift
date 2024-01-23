//
//  TodayDistanceView.swift
//  Trackus
//
//  Created by 박선구 on 1/22/24.
//

import SwiftUI

// 오늘 운동량 차트 View

struct TodayDistanceView: View {
    @State var selectedBarIndex: Int? = nil
    
    let maxWidth: CGFloat = 130 // 최대 그래프 넓이
    
    let distanceLimitValue: Double = 20.0 // 넓이 한계 값 거리
    let speedLimitValue: Double = 20.0 // 넓이 한계 값 속도
    
    var formmatedCurrentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd"
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        TUCanvas.CustomCanvasView(style: .content, content: {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("\(formmatedCurrentDate) 의 운동량은") // 오늘 날짜
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(TUColor.main)
                        .padding(.vertical, 8)
//                        .padding(.vertical)
                
                Text("동일 연령대의 TrackUs 회원 중 상위 33.2%(운동량 기준)") // 같은 나이대 중 상위 퍼센트
                        .font(.caption)
                        .foregroundColor(TUColor.main)
                }
                
                VStack (alignment: .leading) {
                    HStack() {
                        
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(TUColor.main)
                        Text("박선구님") // 사용자의 이름
                            .font(.caption2)
                        
                        Spacer()
                    }
                    
                    HStack {
                        
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(TUColor.sub)
                        Text("TrackUs 20대") // 사용자의 나이대
                            .font(.caption2)
                    }
                }
                .foregroundColor(TUColor.main)
                .padding(.vertical)
                
                VStack {
                    HStack {
                        Text("러닝 거리")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(TUColor.main)
                        VStack {
                            // 사용자의 오늘 하루 러닝 거리
                            HStack {
                                TodayDistanceBar(value: calculateDistanceBarWidth(myDistance[0].distance, data: [myDistance[0]], limitValue: distanceLimitValue), distanceValue: myDistance[0].distance)
                                    .foregroundColor(TUColor.main)
//                                    .frame(maxWidth: .infinity)
                            }
                            
                            // 같은 나이대 오늘 하루 러닝 거리
                            TodayDistanceBar(value: calculateDistanceBarWidth(ageDistance[0].distance, data: [ageDistance[0]], limitValue: distanceLimitValue), distanceValue: ageDistance[0].distance)
                                .foregroundColor(TUColor.sub)
//                                .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack {
                        Text("러닝 속도")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(TUColor.main)
                        VStack {
                            // 사용자의 오늘 하루 러닝 속도
//                            
//                            TodaySpeedBar(value: calculateSpeedBarWidth(mySpeed[0].speed, data: [mySpeed[0]], limitValue: speedLimitValue), speedValue: mySpeed[0].speed)
//                                .foregroundColor(TUColor.main)
//                                .frame(maxWidth: .infinity)
                            
//                            TodaySpeedBar(value: calculateSpeedBarWidth(mySpeedValue: mySpeed[0].speed, ageSpeedValue: ageSpeed[0].speed, mySpeedData: [mySpeed[0]], ageSpeedData: [ageSpeed[0]], limitValue: speedLimitValue), speedValue: mySpeed[0].speed)
                            
                            TodaySpeedBar(value: calculateSpeedBarWidth(mySpeed[0].speed, data: [mySpeed[0]], limitValue: speedLimitValue), speedValue: mySpeed[0].speed)
                                .foregroundColor(TUColor.main)
                            
                            // 같은 나이대의 오늘 하루 러닝 속도
//                            TodaySpeedBar(value: calculateSpeedBarWidth(mySpeedValue: mySpeed[0].speed, ageSpeedValue: ageSpeed[0].speed, mySpeedData: [mySpeed[0]], ageSpeedData: [ageSpeed[0]], limitValue: speedLimitValue), speedValue: ageSpeed[0].speed)
//                                .frame(maxWidth: .infinity)
                            
                            TodaySpeedBar(value: calculateSpeedBarWidth(ageSpeed[0].speed, data: [ageSpeed[0]], limitValue: speedLimitValue), speedValue: ageSpeed[0].speed)
                                .foregroundColor(TUColor.sub)
                            
                        }
                        .padding(.horizontal)
                    }
                }
            }
        })
    }
    
    // 그래프의 높이를 계산 후, 한계값을 넘지 않게 제한하는 함수
    func calculateDistanceBarWidth(_ value: Double, data: [TodayDistanceModel], limitValue: Double) -> Double {
        let normalizedWidth = (value / limitValue) * Double(maxWidth)
        
        guard !data.isEmpty else {
            return normalizedWidth
        }
        
        let maxNormalizedWidth = data.map { $0.distance / limitValue * Double(maxWidth) }.max() ?? 0
        
        var scaleFactor: Double = 1.0
        
        if maxNormalizedWidth > Double(maxWidth) {
            scaleFactor = Double(maxWidth) / maxNormalizedWidth
        }
        
//        let scaleFactor = maxNormalizedWidth > limitValue ? limitValue / maxNormalizedWidth : 1.0
        return min(normalizedWidth * scaleFactor, Double(maxWidth))
    }
    
    // 그래프의 높이를 계산 후, 한계값을 넘지 않게 제한하는 함수
    func calculateSpeedBarWidth(_ value: Double, data: [TodaySpeedModel], limitValue: Double) -> Double {
        let normalizedWidth = (value / limitValue) * Double(maxWidth)
        
        guard !data.isEmpty else {
            return normalizedWidth
        }
        
        let maxNormalizedWidth = data.map { $0.speed / limitValue * Double(maxWidth) }.max() ?? 0
//        let maxNormalizedWidth = data.map { $0.speed / ageSpeed.map(\.speed).max()! * Double(maxWidth) }.max() ?? 0
        
        var scaleFactor: Double = 1.0
        
        if maxNormalizedWidth > Double(maxWidth) {
            scaleFactor = Double(maxWidth) / maxNormalizedWidth
        }
//        
//        let scaleFactor = maxNormalizedWidth > limitValue ? limitValue / maxNormalizedWidth : 1.0
        return min(normalizedWidth * scaleFactor, Double(maxWidth))
    }
    
//    func calculateSpeedBarWidth(mySpeedValue: Double, ageSpeedValue: Double, mySpeedData: [TodaySpeedModel], ageSpeedData: [TodaySpeedModel], limitValue: Double) -> Double {
//        let myNormalizedWidth = (mySpeedValue / limitValue) * Double(maxWidth)
//        
//        guard !mySpeedData.isEmpty else {
//            return myNormalizedWidth
//        }
//        
//        let myMaxNormalizedWidth = mySpeedData.map { $0.speed / limitValue * Double(maxWidth) }.max() ?? 0
//        
//        var myScaleFactor: Double = 1.0
//        
//        if myMaxNormalizedWidth > Double(maxWidth) {
//            myScaleFactor = Double(maxWidth) / myMaxNormalizedWidth
//        }
//        
//        let adjustedMyWidth = min(myNormalizedWidth * myScaleFactor, Double(maxWidth))
//        
//        // 이제 mySpeed를 기반으로 ageSpeed의 너비를 조정합니다.
//        let ageNormalizedWidth = (ageSpeedValue / limitValue) * Double(maxWidth)
//        
//        guard !ageSpeedData.isEmpty else {
//            return ageNormalizedWidth
//        }
//        
//        let ageMaxNormalizedWidth = ageSpeedData.map { $0.speed / limitValue * Double(maxWidth) }.max() ?? 0
//        
//        var ageScaleFactor: Double = 1.0
//        
//        if ageMaxNormalizedWidth > Double(maxWidth) {
//            ageScaleFactor = Double(maxWidth) / ageMaxNormalizedWidth
//        }
//        
//        // mySpeed가 특정 한계를 초과하면 ageSpeed의 너비를 줄입니다.
//        let adjustedAgeWidth = min(ageNormalizedWidth * ageScaleFactor, Double(maxWidth) - adjustedMyWidth)
//        
//        return adjustedAgeWidth
//    }
    
}

struct TodayDistanceBar: View {
    var value : Double
    var distanceValue: Double
//    var isSelected : Bool
    
//    var selectedData: TodayDistanceModel?
    
    @State private var barWidth: CGFloat = 0 // 애니메이션을 위한
    @State private var firstTime: Bool = false
    
//    var selectedData: TodayDistanceModel?
    
    var body: some View {
        
        HStack {
            
            ZStack(alignment: .leading){
                
                Capsule().frame(width: 130, height: 15) // 그래프 높이
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                Capsule().frame(width: barWidth, height: 15)
                
                Text("\(String(format: "%0.1f", distanceValue)) km")
                    .foregroundColor(TUColor.main)
                    .font(.caption)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .offset(x: +value + 10)

                
            }
            .onAppear {
                if !firstTime {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.barWidth = value
                    }
                    firstTime = true
                }
            }
//            .frame(maxWidth: .infinity)
        }
    }
}

struct TodaySpeedBar: View {
    var value : Double
    var speedValue: Double
//    var isSelected : Bool
    
//    var selectedData: TodayDistanceModel?
    
    @State private var barWidth: CGFloat = 0 // 애니메이션을 위한
    @State private var firstTime: Bool = false
    
//    var selectedData: TodaySpeedModel?
    
    var body: some View {
        
        HStack {
            
            ZStack(alignment: .leading){
                
                Capsule().frame(width: 130, height: 15) // 그래프 높이
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                Capsule().frame(width: barWidth, height: 15)
                
                Text("\(String(format: "%0.1f", speedValue)) km/h")
                    .foregroundColor(TUColor.main)
                    .font(.caption)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .offset(x: +value + 10)

                
            }
            .onAppear {
                if !firstTime {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.barWidth = value
                    }
                    firstTime = true
                }
            }
//            .frame(maxWidth: .infinity)
                
        }
    }
}

struct TodayDistanceModel: Identifiable, Equatable {
    var id = UUID().uuidString
    var distance: Double
}

struct TodaySpeedModel: Identifiable, Equatable {
    var id = UUID().uuidString
    var speed: Double
}


var myDistance: [TodayDistanceModel] = [ // 사용자 러닝거리
    TodayDistanceModel(distance: 4.6)
]

var ageDistance: [TodayDistanceModel] = [ // 연령대 러닝거리
    TodayDistanceModel(distance: 3.2)
]

var mySpeed: [TodaySpeedModel] = [ // 사용자 러닝속도
    TodaySpeedModel(speed: 11.4)
]

var ageSpeed: [TodaySpeedModel] = [ // 연령대 러닝속도
    TodaySpeedModel(speed: 10.8)
]

#Preview {
    TodayDistanceView()
}
