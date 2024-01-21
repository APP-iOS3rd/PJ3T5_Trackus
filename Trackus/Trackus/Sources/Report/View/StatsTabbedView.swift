//
//  ReportChartTab.swift
//  ChartPrac
//
//  Created by 박선구 on 1/20/24.
//

import SwiftUI

// 일별, 월별, 년도별 러닝 속도 차트를 제공해주는 Tab 뷰

enum chartTab: String, CaseIterable {
    case weak = "일별"
    case month = "월별"
    case year = "연도별"
}

struct StatsTabbedView: View {
    @State private var pickerSelectedItem = 0
    @State private var isPickerPresented = false
    @State private var selectedAge = AvgAge.twenties // 사용자의 나이대
    @State var selection: String = "20대"
    
    @State private var selectedPicker: chartTab = .weak
    @Namespace private var animation
    
    var body: some View {
        ZStack (alignment: .top) {
            TUColor.box.edgesIgnoringSafeArea(.all)
            
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
                                .resizable()
                                .frame(width: 12, height: 10)
                        }
                        .foregroundColor(TUColor.main)
                        
                    })
                    .padding(6)
                    .background(TUColor.subBox)
                    .cornerRadius(10)
                    
                    Text("평균 러닝 속도")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(TUColor.main)
                    
                    Spacer()
                }
                
                    animate()
                    .padding(.horizontal, 60)
                
                Spacer()
                
                selectView(selec: selectedPicker)
            }
            .frame(height: 450)
            
        }
        .sheet(isPresented: $isPickerPresented,onDismiss: {
            
        }, content: {
            filterPicker(selectedAge: $selectedAge, isPickerPresented: $isPickerPresented)
                .presentationDetents([.fraction(0.3), .large])
                .presentationDragIndicator(.hidden)
        })
    }
    
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(chartTab.allCases, id: \.self) { item in
                ZStack {
                    if selectedPicker == item {
                        Capsule()
                            .foregroundColor(.gray)
                            .frame(height: 30)
                            .matchedGeometryEffect(id: "일별", in: animation)
                    }
                    
                    Text(item.rawValue)
                        .font(.body)
                        .bold()
                        .frame(maxWidth: .infinity / 3)
                        .frame(height: 30)
                        .foregroundColor(selectedPicker == item ? TUColor.main : .gray)
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedPicker = item
                    }
                }
            }
        }
        .background(TUColor.subBox) // 색 변경 할지도..
        .cornerRadius(100)
    }
}

struct selectView : View {
    var selec : chartTab
    
    var body: some View {
        switch selec {
        case .weak:
            DailyRunningStatsView()
        case .month:
            MonthRunningStatsView()
        case .year:
            YearRunningStatsView()
        }
    }
}

struct filterPicker: View {
    @Binding var selectedAge: AvgAge
    @Binding var isPickerPresented: Bool

    var body: some View {
        ZStack {
            TUColor.subBox.edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        isPickerPresented.toggle()
                    }, label: {
                        Text("확인")
                            .padding()
                    })
                }
                
                
                Picker("", selection: $selectedAge) {
                    ForEach(AvgAge.allCases, id: \.self) { age in
                        Text(age.rawValue).tag(age)
                    }
                }
                .foregroundColor(TUColor.main)
                .pickerStyle(WheelPickerStyle())
                .padding(.horizontal, 50)
                
            }
        }
    }
}

#Preview {
    StatsTabbedView()
}
