//
//  SwiftUIView.swift
//  Trackus
//
//  Created by 박선구 on 1/23/24.
//

import SwiftUI

// 나이대별 월 평균 운동량을 비교해주는 뷰

struct MonthDistanceView: View {
    @State var selectedBarIndex: Int? = nil
    @Binding var selectedAge : AvgAge // 사용자의 나이대
    @State var isPickerPresented = false
    
    let maxHeight: CGFloat = 100 // 최대 그래프 높이
    let limitValue: Double = 20.0 // 높이 한계 값
    
    var body: some View {
        TUCanvas.CustomCanvasView(style: .content) {
            
            
            ZStack (alignment: .top){
                TUColor.box.edgesIgnoringSafeArea(.all) // 뷰의 전체 배경색
                
                VStack {
                    
                    HStack {
                        // 연령대 피커 자리
                        Button(action: {
                            isPickerPresented.toggle()
                        }, label: {
                            HStack {
                                Text(selectedAge.rawValue)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Image(systemName: "chevron.down")
                                    .frame(width: 10, height: 10)
                            }
                            .foregroundColor(TUColor.main)
                            
                        })
                        .padding(6)
                        .background(TUColor.subBox)
                        .cornerRadius(10)
                        
                        
                        Text("평균 운동량 추세")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(TUColor.main)
                        
                        Spacer()
                    }
                    
                    
                    Spacer() // 공간 확보
                    
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
                                Text("트랙어스 20대")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(TUColor.main)
                    }
                    VStack {
                        ZStack {
                            
                            HStack (spacing: 2) {
                                ForEach(kmData, id: \.id) { data in
                                    
                                    ZStack {
//                                        KMLineView(value: calculateBarHeight(data.avg))
////                                            .foregroundColor(TUColor.sub.opacity(0.9))
//                                            .foregroundColor(TUColor.sub)
//                                            .cornerRadius(14)
//                                            .offset(y: +2)
                                        
                                        KMBarView(value: calculateBarHeight(data.weight), day: data.day, isSelected: selectedBarIndex == kmData.firstIndex(of: data), selectedData: data)
                                            .onTapGesture {
                                                selectedBarIndex = selectedBarIndex == kmData.firstIndex(of: data) ? nil : kmData.firstIndex(of: data)
                                            }
                                            .foregroundColor(selectedBarIndex == kmData.firstIndex(of: data) ? TUColor.main : TUColor.main.opacity(0.5))
                                        
                                        KMLineView(value: calculateBarHeight(data.avg))
                                            .foregroundColor(TUColor.sub.opacity(0.8))
                                            .cornerRadius(14)
                                            .offset(y: +2)
                                
                                    }
                                }
                            }
                            .padding(.top, 24)
                            
                        }
                        .frame(height: 150)
                        
                        VStack {
                            Text("박선구 님의 운동량은 20대 평균보다 ") + // 이름, 선택한 연령대
                            Text("1.7%").foregroundColor(TUColor.sub) + // 이번 달 운동 횟수와 연령대 평균 운동 횟수 비교
                            Text(" 높으며 전달 대비 운동횟수가 3회 증가 했습니다.") // 사용자 운동 횟수가 평균보다 높은지, 낮은지 저번 달과 이번 달 운동 횟수 비교 해서 이번달이 높으면 증가, 저번달이 높으면 감소
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
                .frame(height: 400)
                
                .sheet(isPresented: $isPickerPresented,onDismiss: {
                    
                }, content: {
                    filterPicker(selectedAge: $selectedAge, isPickerPresented: $isPickerPresented)
                        .presentationDetents([.fraction(0.3), .large])
                        .presentationDragIndicator(.hidden)
                })
            }
        }
    }
    
    func calculateBarHeight(_ weight: Double) -> Double {
        let normalizedHeight = (weight / limitValue) * Double(maxHeight)
        
        guard !kmData.isEmpty else {
            return normalizedHeight
        }
        
        let maxNormalizedHeight = kmData.map { $0.weight / limitValue * Double(maxHeight) }.max() ?? 0
        let scaleFactor = maxNormalizedHeight > Double(maxHeight) ? Double(maxHeight) / maxNormalizedHeight : 1.0
        return min(normalizedHeight * scaleFactor, Double(maxHeight))
    }
}

struct KMBarView: View {
    var value : CGFloat
    var day: String?
    var isSelected : Bool
    
    var selectedData: MonthModel?
    
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

struct KMLineView: View {
    
    var value : CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom){
                Rectangle()
                    .frame(height: 100)
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                VStack {
                    
                    Rectangle()
                        .frame(height: value)
                        .cornerRadius(14)
                    Spacer()
                }
                .frame(height: value)
            }
            
            Text("")
                .foregroundStyle(.gray)
                .font(.caption2)
        }
    }
}

struct MonthModel: Identifiable, Equatable {
    var id = UUID().uuidString
    var day: String
    var weight: Double
    var avg: Double
}

var kmData: [MonthModel] = [
    MonthModel(day: "Jan", weight: 19.5, avg: 8.5),
    MonthModel(day: "Feb", weight: 17.2, avg: 10.5),
    MonthModel(day: "Mar", weight: 20, avg: 10),
    MonthModel(day: "Apr", weight: 15.5, avg: 5.5),
    MonthModel(day: "May", weight: 11.1, avg: 6.5),
    MonthModel(day: "Jun", weight: 7.5, avg: 3.5),
    MonthModel(day: "Jul", weight: 15.2, avg: 5.5),
    MonthModel(day: "Aug", weight: 40.0, avg: 10),
    MonthModel(day: "Sep", weight: 5.2, avg: 19.5),
    MonthModel(day: "Oct", weight: 5.9, avg: 14.5),
    MonthModel(day: "Nov", weight: 2.0, avg: 4.5),
    MonthModel(day: "Dec", weight: 0.0, avg: 5.5)
]

//#Preview {
//    MonthDistanceView(selectedAge: AvgAge.teens)
//}
