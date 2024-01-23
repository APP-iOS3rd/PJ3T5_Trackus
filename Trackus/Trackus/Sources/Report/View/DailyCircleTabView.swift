//
//  DailyCircleTabView.swift
//  Trackus
//
//  Created by 박선구 on 1/22/24.
//

import SwiftUI

// 기간별 운동 정보 일별, 월별 탭 View

enum CircleTab: String, CaseIterable {
    case day = "일"
    case month = "월"
}

struct DailyCircleTabView: View {
    @State private var selectedPicker: CircleTab = .day
    @Namespace private var animation
//    @Binding var dailyCircleTabHeight: CGFloat
    
    var body: some View {
//        TUCanvas.CustomCanvasView(style: .content, content: {
            VStack {
                animate()
                    .padding(.horizontal, 50)
                    .padding(.bottom, 20)
//                    .padding(30)
                
                Spacer()
                
//                GeometryReader { geometry in
//                TabView {
                    CircleSelectView(selec: selectedPicker)
                        .frame(height: 350)
//                }
                    .gesture(
                        DragGesture()
                            .onEnded{ gesture in
                                withAnimation {
                                    if gesture.translation.width > 0 {
                                        // 스와이프가 오른쪽 방향이면 이전
                                        self.selectedPicker = .day
                                    } else {
                                        // 스와이프가 왼쪽 방향이면 다음
                                        self.selectedPicker = .month
                                    }
                                }
                            }
                    )
//                    .cornerRadius(14)
//                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
//                .onPreferenceChange(HeightPreferenceKey.self) {
//                    dailyCircleTabHeight = $0
//                }
//            }
//            .padding(.vertical, -40)
//        })
    }
    
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(CircleTab.allCases, id: \.self) { item in
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
                        .frame(maxWidth: .infinity / 2)
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

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct CircleSelectView : View {
    var selec : CircleTab
    
    var body: some View {
//        GeometryReader { geometry in
            switch selec {
            case .day:
                MyStatsCircleView()
//                    .transition(.rightSlide)
                    .transition(.leftSlide)
//                    .transition(selec == .day ? .rightSlide : .leftSlide)
//                    .frame(width: geometry.size.width, height: 400)
            case .month:
                MyStatsOverviewView()
//                    .transition(.leftSlide)
                    .transition(.rightSlide)
//                    .transition(selec == .month ? .leftSlide : .rightSlide)
//                    .frame(width: geometry.size.width, height: 400)
            }
//        }
    }
}

extension AnyTransition {
    static var leftSlide: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
        let removal = AnyTransition.move(edge: .trailing)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

extension AnyTransition {
    static var rightSlide: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
        let removal = AnyTransition.move(edge: .leading)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

#Preview {
    DailyCircleTabView()
}
